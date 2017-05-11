curl \
    -X POST \
    --verbose \
    --silent \
    -H "Content-Type: application/json" \
    -d "{\"share\": \"THIS_IS_NOT_A_VALID_SHARE\"}" \
    http://localhost:9000/consentShare | json_pp

echo
