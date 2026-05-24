#!/bin/sh

if [ ! -d "build" ]; then
  echo "Build folder not found. Running build..."
  export NODE_OPTIONS="${NODE_OPTIONS:---max-old-space-size=1536}"
  npm install --prefer-offline --no-audit --progress=false && npm run build
else
  echo "Build folder already exists. Skipping build."
fi
