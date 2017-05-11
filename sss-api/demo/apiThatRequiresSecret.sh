curl \
    -X GET \
    --verbose \
    --silent \
    -H "Content-Type: application/json" \
    http://localhost:9000/apiThatRequiresSecret | json_pp

echo
