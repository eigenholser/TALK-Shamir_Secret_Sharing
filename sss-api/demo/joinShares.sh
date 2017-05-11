curl \
    -X POST \
    --verbose \
    --silent \
    -H "Content-Type: application/json" \
    -d "`cat shares.json`" \
    http://localhost:9000/joinShares | json_pp

echo
