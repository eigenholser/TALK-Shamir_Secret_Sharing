name := """sss"""

version := "0.0.1"

scalaVersion := "2.11.8"

javacOptions ++= Seq("-source", "1.8", "-target", "1.8")

lazy val root = (project in file(".")).enablePlugins(PlayScala)

libraryDependencies ++= Seq(
  "org.scalatest" % "scalatest_2.11" % "2.2.6" % "test",
  "org.xerial" % "sqlite-jdbc" % "3.7.2",
  "ch.qos.logback" % "logback-classic" % "1.1.3",
  "com.typesafe.slick" %% "slick" % "3.1.1",
  "com.typesafe" % "config" % "1.3.0",
  "com.typesafe.play" %% "play-ws" % "2.5.4",
  "com.github.scopt" %% "scopt" % "3.5.0",
//  "org.slf4j" % "slf4j-api" % "1.7.22",
//  "org.slf4j" % "slf4j-simple" % "1.7.22"
  //"io.swagger" %% "swagger-play2" % "1.5.1"
  "org.snmp4j" % "snmp4j" % "2.5.2"
)

// Fix for duplicate class issue when running sbt assembly
libraryDependencies ~= {
  _.map(_.exclude("org.slf4j", "jcl-over-slf4j"))
}

// Keep this. Useful for testing ComputershareParsers changes. But don't want
// it for non-test build.
//libraryDependencies ~= {
//  _.map(_.exclude("org.scala-lang", "scala-reflect"))
//}

assemblyMergeStrategy in assembly := {
  case PathList(ps @ _*) if ps.last endsWith "io.netty.versions.properties" =>
    /*
    Both of these libraries contain a bundle.info:
      org.apache.servicemix.bundles.quickfix
      org.apache.servicemix.bundles.xpp3
     */
    MergeStrategy.discard
  case x =>
    val oldStrategy = (assemblyMergeStrategy in assembly).value
    oldStrategy(x)
}

resolvers += Resolver.sonatypeRepo("public")

credentials += Credentials(Path.userHome / ".ivy2" / "credentials")

scalacOptions ++= Seq(
  "-feature",
  "-language:postfixOps",
  "-Xlint",
  "-Xfatal-warnings",
  "-deprecation",
  "-Xlint:missing-interpolator",
// "-Ywarn-unused-import",
  "-Ywarn-unused",
  "-Ywarn-dead-code",
  "-Ywarn-numeric-widen"
)

