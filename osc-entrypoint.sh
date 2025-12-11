#!/bin/bash

# Generate config.json with REST API port set to 8080
mkdir -p /config
cat > /config/config.json << 'EOF'
{
  "Settings": {
    "RestApiPort": 8080,
    "RestApiEnabled": true
  }
}
EOF

CMD="./TShock.Server -port 7777 -config /config/config.json -configpath /config -worldselectpath /worlds -additionalplugins /plugins -maxplayers 16"

# Pass in world if set
if [ "${WORLD:-null}" != null ]; then
    if [ ! -f "/worlds/$WORLD" ]; then
        echo "World file does not exist! Automatically create one"
    	CMD="$CMD -autocreate 1"
    fi
    CMD="$CMD -world /worlds/$WORLD"
fi

echo "Starting container, CMD: $CMD $@"
exec $CMD $@
