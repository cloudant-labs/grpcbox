#!/bin/bash

PORT=8080
TLS=false

tests=(
    empty_unary
    large_unary
    client_streaming
    server_streaming
    ping_pong
    # empty_stream
    # timeout_on_sleeping_server
    # compute_engine_creds
    # service_account_creds
    # jwt_token_creds
    # per_rpc_creds
    # oauth2_auth_token
    # cancel_after_begin
    # cancel_after_first_response
    # status_code_and_message
    # custom_metadata
    # unimplemented_method
    # unimplemented_service
)

for test in "${tests[@]}"; do
    echo -n "Running ${test}... "
    $GOPATH/bin/go-grpc-interop-client -use_tls=$TLS -test_case=$test -server_port=$PORT
    if [[ $? -ne 0 ]]; then
        echo "Failed!"
        exit 1
    fi
    echo "Passed"
done

echo "----"
echo "YAY! All enabled tests passed."
