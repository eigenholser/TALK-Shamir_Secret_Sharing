curl \
    -X POST \
    --silent \
    -H "Content-Type: application/json" \
    -d "`cat shares.txt`" \
    http://localhost:9000/join

echo
