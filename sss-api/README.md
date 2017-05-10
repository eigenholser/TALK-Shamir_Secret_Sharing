# Shamir Secret Sharing Microservice

Implementation of Shamir Secret Sharing using the Java [Secret Sharing](https://github.com/secretsharing/secretsharing)
library available [on Github](https://github.com/secretsharing/secretsharing).

## API Endpoints

There are 4 API endpoints in this demo application:

    /splitSecret                # Split the secret into shares.
    /joinShares                 # Join shares and construct the secret.
    /consentShare               # Add a single share.
    /apiThatRequiresSecret      # POC for API that requires the secret.

The demo is broken into two parts. First is `splitSecret` and `joinShares`.
These two API endpoints demonstrate how we can generate shares and
reconstitute the secret from the shares.

The second part is a proof of concept that demonstrates how we might implement
a mechanism for shareholders to consent to a service that requires a secret.
This is the `consentShare` API endpoint. The `apiThatRequiresSecret` endpoint
represents an API that might require the secret to service it's requests. When
the threshold of shares is made available via `consentShare`, the secret will
be constructed and stored.

The `consentShare` API endpoint does not permit duplicate share submissions.
Invalid shares will be rejected. Once the required number of shares are
available, no more shares will be accepted. All shares are held in memory.
Construction of the secret will be attempted with each share addition. Once
the secret is successfully constructed it will be stored in memory for future
use.

It is possible to submit a valid share that was not generated from the secret.
This will break the system. Just don't do that. Perhaps in a real application,
an API that clears all cached shares will be useful. For our purposes, a
restart will suffice.

`consentShare` in a real application would be authenticated and use TLS. The
consent should also be logged, probably in a database rather than a logfile.
This would represent non-repudiation of consent.


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

To demonstrate the secret reconstruction for the proof of concept API:

    cd demo
    sh apiThatRequiresSecret.sh    # See log messages.
    sh consentShare-1.sh     # ...
    sh consentShare-2.sh
    sh apiThatRequiresSecret.sh
    sh consentShare-INVALID.sh
    sh consentShare-3.sh
    sh apiThatRequiresSecret.sh

Note the log messages along the way. Mix up the shell scripts however you like.


## References
* [Cryptographer-verified implementation of Shamir's Secret Sharing Scheme](https://github.com/secretsharing/secretsharing)
* [Building a REST API in Java and Scala Using Play Framework – Part 1](http://nordicapis.com/building-a-rest-api-in-java-scala-using-play-framework-2-part-1/)
* [Building a REST API in Java and Scala Using Play Framework – Part 2](http://nordicapis.com/building-rest-api-java-scala-using-play-framework-part-2/)
* [Swagger Play2](https://github.com/swagger-api/swagger-play/tree/master/play-2.5/swagger-play2)
