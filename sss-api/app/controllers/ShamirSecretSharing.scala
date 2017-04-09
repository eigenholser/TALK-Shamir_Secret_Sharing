package controllers

import akka.actor.ActorSystem
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

// Represents the request body for split.
case class Secret(required: Int, total: Int, secret: String)

/**
 * This controller implements Shamir Secret Sharing methods `split` and `join`.
 * that split a secret into shares and combine shares into a secret.
 *
 * @param actorSystem We need the `ActorSystem`'s `Scheduler` to
 * run code after a delay.
 * @param exec We need an `ExecutionContext` to execute our
 * asynchronous code.
 */
@Singleton
class ShamirSecretSharing @Inject() (actorSystem: ActorSystem)(implicit exec: ExecutionContext) extends Controller {
  implicit val splitFmt = Json.format[Secret]
  val logger = LoggerFactory.getLogger(classOf[ShamirSecretSharing])

  /**
   * Split a secret into shares. Expect parameters as JSON:
   *
   * {
   *   "required": 3,           // required to recover secret.
   *   "total": 5,              // total shares to create.
   *   "secret": "The Secret!"  // The secret.
   * }
   */
  def split = Action.async { implicit request =>
    request.body.asJson match {
      case Some(body) => {
        val reqBody = body.as[Secret]
        val required = reqBody.required
        val total = reqBody.total
        val secret = reqBody.secret.getBytes
        logger.debug(s"Creating $total shares, $required shares needed to recover secret.")
        // TODO: Handle errors like join below.
        val shares = Secrets.split(secret, total, required, new Random())
        shares foreach {x => logger.debug(s"Share: $x")}
        // Is this the conanoical approach? Looks goofy.
        Future(Ok(JsArray(for(share <- shares) yield JsString(share.toString))))
      }
      case None => {
        logger.warn("Bad request")
        val userMessage = "Bad request"
        val result = Json.obj("status" -> "failure", "data" -> userMessage)
        Future(BadRequest(result))
      }
    }
  }

  /**
   * Join shares and recover secret. Expect shares as JSON array in request
   * body:
   *
   * [
   *   "share1",
   *   "share2",
   *   ...,
   *   "shareN"
   * ]
   */
  def join = Action.async { implicit request =>
    request.body.asJson match {
      case Some(body) => {
        val shares = body.as[Array[String]]
        shares foreach {x => logger.debug(s"Share: $x")}
        val parts: Array[Part] = for (
          share <- shares
        ) yield new Part(share)
        Try(new String(Secrets.join(parts).map(_.toChar))) match {
          case Success(secret) => {
            Future(Ok(Json.obj("status" -> "success", "data" -> secret)))
          }
          case Failure(e) => {
            val msg = s"Unable to reconstitute secret: ${e.getMessage}"
            logger.error(msg)
            // XXX: Including exception message may leak data.
            val result = Json.obj("status" -> "failure", "data" -> msg)
            Future(BadRequest(result))
          }
        }
      }
      case None => {
        logger.warn("Bad request")
        val msg = "Bad request"
        val result = Json.obj("status" -> "failure", "data" -> msg)
        Future(BadRequest(result))
      }
    }
  }
}
