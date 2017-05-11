package services

import javax.inject._
import scala.util.{Failure, Success, Try}
import org.slf4j.Logger
import org.slf4j.LoggerFactory
import org.mitre.secretsharing.{Part, Secrets}
import constants.SSSConstants

@Singleton
class SecretRepository {
  val logger = LoggerFactory.getLogger(classOf[SecretRepository])
  private val shares = scala.collection.mutable.ArrayBuffer.empty[String]
  var secret = None: Option[String]

  /**
   * Add a single share. Test for validity by instantiating a new Part(). Do
   * not accept duplicate shares. Do not accept shares beyond that required to
   * construct the secret.
   *
   * @param share String
   * @return code Int
   */
  def addShare(share: String): Int = {
    secret match {
      case Some(_) => SSSConstants.STATUS_SUFFICIENT_SHARES
      case None => {
        Try(new Part(share)) match {
          case Success(_) => {
            if (!shares.contains(share)) {
              logger.info(s"Adding share $share")
              shares += share
            } else {
              logger.warn(s"Nothing done, this share was previously added: $share")
            }
            constructSecret match {
              case Success(v) => {
                secret = Option(v)
                logger.info(s"Successfully generated secret: $v")
                SSSConstants.STATUS_SUFFICIENT_SHARES
              }
              case Failure(_) => {
                logger.warn("Insufficient shares available to generate secret.")
                SSSConstants.STATUS_INSUFFICIENT_SHARES
              }
            }
          }
          case Failure(e) => {
            logger.warn(s"Invalid share: $share")
            logger.warn(s"Reason: $e")
            SSSConstants.STATUS_INVALID_SHARE
          }
        }
      }
    }
  }

  /**
   * Construct the secret from available shares. If it fails, our shares are
   * not all available or are incorrect.
   */
  def constructSecret(): Try[String] = Try {
    val parts = for (share <- shares.toArray) yield new Part(share)
    new String(Secrets.join(parts).map(_.toChar))
  }
}
