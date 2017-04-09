# Shamir Secret Sharing Microservice

Implementation of Shamir Secret Sharing using the Java
[Cryptographer-verified implementation of Shamir's Secret Sharing Scheme] [] library
available [on Github] [Cryptographer-verified implementation of Shamir's Secret Sharing Scheme].

## Run With SBT

Just do:

    sbt run

The API listens on port `localhost:9000`.

The shell scripts in the `./demo` directory are very simple and intended to
exercise the Shamir Secret Sharing API using `curl`.

    cd demo
    sh split.sh | json_pp > shares.json
    sh join.sh

Edit the `shares.json` file and remove the extra shares before running `join.sh`
just to see that it works.


## References
* [Cryptographer-verified implementation of Shamir's Secret Sharing Scheme](https://github.com/secretsharing/secretsharing)
* [Building a REST API in Java and Scala Using Play Framework – Part 1](http://nordicapis.com/building-a-rest-api-in-java-scala-using-play-framework-2-part-1/)
* [Building a REST API in Java and Scala Using Play Framework – Part 2](http://nordicapis.com/building-rest-api-java-scala-using-play-framework-part-2/)
* [Swagger Play2](https://github.com/swagger-api/swagger-play/tree/master/play-2.5/swagger-play2)
