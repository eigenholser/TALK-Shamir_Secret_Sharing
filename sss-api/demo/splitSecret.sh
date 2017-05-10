curl \
    -X POST \
    --silent \
    -H "Content-Type: application/json" \
    -d "{\"required\": 3, \"total\": 5, \"secret\": \"The secret number is 42\"}" \
    http://localhost:9000/splitSecret | json_pp

echo
