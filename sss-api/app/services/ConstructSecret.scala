package services

import javax.inject._
import scala.util.{Failure, Success, Try}
import org.slf4j.Logger
import org.slf4j.LoggerFactory
import org.mitre.secretsharing.{Part, Secrets}
import constants.SSSConstants

@Singleton
class ConstructSecret {
  private val shares = scala.collection.mutable.ArrayBuffer.empty[String]
  val logger = LoggerFactory.getLogger(classOf[ConstructSecret])
  var sufficientShares = false

  /**
   * Add a single share. Test for validity by instantiating a new Part(). Do
   * not accept duplicate shares. Do not accept shares beyond that required to
   * construct the secret.
   *
   * @param share String
   * @return code Int
   */
  def add(share: String): Int = {
    sufficientShares match {
      case true => SSSConstants.STATUS_SUFFICIENT_SHARES
      case false => {
        logger.warn("If this were a real application we would not be logging the shares!")
        Try(new Part(share)) match {
          case Success(_) => {
            if (!shares.contains(share)) {
              logger.info(s"Adding share $share")
              shares += share
            } else {
              logger.warn(s"This share already added: $share")
            }
            secret match {
              case Success(_) => {
                sufficientShares = true
                SSSConstants.STATUS_SUFFICIENT_SHARES
              }
              case Failure(_) => {
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
  def secret(): Try[String] = Try {
    val parts = scala.collection.mutable.ArrayBuffer.empty[Part]
    (for (share <- shares) yield new Part(share)) map {x => parts += x}
    new String(Secrets.join(parts.toArray).map(_.toChar))
  }
}
