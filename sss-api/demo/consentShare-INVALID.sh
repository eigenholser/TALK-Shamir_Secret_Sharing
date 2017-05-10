curl \
    -X POST \
    --verbose \
    -H "Content-Type: application/json" \
    -d "{\"share\": \"THIS_IS_NOT_A_VALID_SHARE\"}" \
    http://localhost:9000/consentShare

echo
