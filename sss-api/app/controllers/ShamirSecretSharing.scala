package controllers

import akka.actor._
import java.util.Random
import javax.inject._
import org.slf4j.Logger
import org.slf4j.LoggerFactory
import play.api._
import play.api.libs.json._
import play.api.mvc._
import scala.collection.JavaConversions._
import scala.concurrent.{ExecutionContext, Future, Promise}
import scala.concurrent.duration._
import scala.util.{Failure, Success, Try}
import org.mitre.secretsharing.{Part, Secrets}
import constants.SSSConstants
import services.SecretRepository
import actors.MonitorSecret

// Represents the request body for split.
case class Secret(required: Int, total: Int, secret: String)
case class Share(share: String)

/**
 * This controller implements Shamir Secret Sharing methods `split` and `join`.
 * that split a secret into shares and combine shares into a secret. It also
 * implements `add` and `status` as a proof of concept for how Shamir Secret
 * Sharing might be used in practice.
 *
 * @param actorSystem We need the `ActorSystem`'s `Scheduler` to
 * run code after a delay.
 * @param exec We need an `ExecutionContext` to execute our
 * asynchronous code.
 */
@Singleton
class ShamirSecretSharing @Inject() (actorSystem: ActorSystem, secretRepository: SecretRepository)(implicit exec: ExecutionContext) extends Controller {
  implicit val secretFmt = Json.format[Secret]
  implicit val shareFmt = Json.format[Share]
  val logger = LoggerFactory.getLogger(classOf[ShamirSecretSharing])
  val monitorSecretActor = actorSystem.actorOf(Props(new MonitorSecret(secretRepository)), "monitorSecret")
  val job = actorSystem.scheduler.schedule(10.second, 10.second, monitorSecretActor, "tick")

  /**
   * Split a secret into shares. Expect parameters as JSON:
   *
   * POST
   * Response:
   * {
   *   "required": 3,           // required to recover secret.
   *   "total": 5,              // total shares to create.
   *   "secret": "The Secret!"  // The secret.
   * }
   *
   * Response:
   * [
   *   "share1",
   *   "share2",
   *   ...,
   *   "shareN"
   * ]
   *
   */
  def splitSecret = Action.async { implicit request =>
    request.body.asJson match {
      case Some(body) => {
        val reqBody = body.as[Secret]
        val required = reqBody.required
        val total = reqBody.total
        val secret = reqBody.secret.getBytes
        logger.debug(s"Creating $total shares, $required shares needed to recover secret.")
        // TODO: Handle errors like join below.
        val shares = Secrets.split(secret, total, required, new Random())
        logger.warn("If this were a real application we would not be logging the shares!")
        shares foreach {x => logger.debug(s"Share: $x")}
        // Is this the conanoical approach? Looks goofy.
        Future(Ok(JsArray(for(share <- shares) yield JsString(share.toString))))
      }
      case None => {
        logger.warn("Bad request")
        Future(BadRequest)
      }
    }
  }

  /**
   * Join shares and recover secret. Expect shares as JSON array in request
   * body:
   *
   * POST
   * Request body:
   * [
   *   "share1",
   *   "share2",
   *   ...,
   *   "shareN"
   * ]
   *
   * Response:
   * {
   *    "secret": "The Secret!"
   * }
   */
  def joinShares = Action.async { implicit request =>
    request.body.asJson match {
      case Some(body) => {
        val shares = body.as[Array[String]]
        logger.warn("If this were a real application we would not be logging the shares!")
        shares foreach {x => logger.debug(s"Share: $x")}
        val parts: Array[Part] = for (
          share <- shares
        ) yield new Part(share)
        Try(new String(Secrets.join(parts).map(_.toChar))) match {
          case Success(secret) => {
            Future(Ok(Json.obj("secret" -> secret)))
          }
          case Failure(e) => {
            val msg = s"Unable to reconstitute secret: ${e.getMessage}"
            logger.error(msg)
            // XXX: Including exception message may leak data.
            val result = Json.obj("error" -> msg)
            Future(BadRequest(result))
          }
        }
      }
      case None => {
        logger.warn("Bad request")
        Future(BadRequest)
      }
    }
  }

  /**
   * Prototype for an API endpoint that requires the secret to perform it's
   * function.
   */
  def apiThatRequiresSecret = Action.async { implicit request =>
    secretRepository.secret match {
      case Some(v) => {
        logger.info("API is ready!")
        Future(Ok)
      }
      case None => {
        logger.warn("Insufficient shares available to construct secret!")
        Future(InternalServerError)
      }
    }
  }

  /**
   * Consent authorized by shareholder. Normally this would be authenticated.
   * This would constitute consent by the shareholder to generating the secret.
   *
   * {
   *    "share": "THE_SHARE_TO_BE_ADDED"
   * }
   */
  def consentShare = Action.async { implicit request =>
    request.body.asJson match {
      case Some(body) => {
        val share = body.as[Share]
        secretRepository.addShare(share.share) match {
          case SSSConstants.STATUS_INVALID_SHARE => Future(BadRequest)
          case SSSConstants.STATUS_SUFFICIENT_SHARES => {
            // Once the secret is available, stop checking.
            job.cancel()
            Future(Ok)
          }
          case _ => Future(Ok)
        }
      }
      case None => {
        logger.warn("Bad request.")
        Future(BadRequest)
      }
    }
  }
}
