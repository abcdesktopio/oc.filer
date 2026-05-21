#!/bin/sh

# Read first $POD_IP if not set get from hostname -i ip address
export CONTAINER_IP_ADDR=${POD_IP:-$(hostname -i)}
export ACCEPT_BINARIES_UPLOAD=false
export ACCEPT_COMPRESSED_UPLOAD=false
echo "Container local ip addr is $CONTAINER_IP_ADDR"
echo "Accept binaries upload: $ACCEPT_BINARIES_UPLOAD"
echo "Accept compressed upload: $ACCEPT_COMPRESSED_UPLOAD"

# there is only one process to run
# we do not need to use supervisord
# start command node file-service.js
cd /composer/node/file-service
node file-service.js
