package actors

import akka.actor._
import org.slf4j.Logger
import org.slf4j.LoggerFactory
import scala.concurrent.duration._
import services.SecretRepository

/**
 * Log a message about secret status.
 */
class MonitorSecret(secretRepository: SecretRepository) extends Actor {
  val logger = LoggerFactory.getLogger(classOf[MonitorSecret])

  def receive = {
    case "tick" =>
      secretRepository.secret match {
        case Some(_) => {
          logger.info("Secret has been constructed.")
        }
        case None => {
          logger.warn("Secret not yet available.")
        }
      }
  }
}

