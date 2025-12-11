#!/bin/bash

# Generate config.json with REST API port set to 8080
mkdir -p /data/config
cat > /data/config/config.json << 'EOF'
{
  "Settings": {
    "RestApiPort": 8080,
    "RestApiEnabled": true
  }
}
EOF

CMD="./TShock.Server -port 7777 -config /data/config/config.json -configpath /data/config -worldselectpath /data/worlds -additionalplugins /data/plugins -maxplayers 16"

# Pass in world if set
if [ "${WORLD:-null}" != null ]; then
    if [ ! -f "/data/worlds/$WORLD" ]; then
        echo "World file does not exist! Automatically create one"
    	CMD="$CMD -autocreate 1"
    fi
    CMD="$CMD -world /data/worlds/$WORLD"
fi

echo "Starting container, CMD: $CMD $@"
exec $CMD $@
