#!/bin/bash
cd firebase-js-sdk
folder="node_modules"
if [ ! -d "$folder" ]; then
  echo "No build found for firebase-js-sdk. Building..."
  yarn
  yarn build
else
  echo "Build found for firebase-js-sdk. Build skipped..."
fi
cd ..
