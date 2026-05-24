#!/bin/sh

if [ ! -d "build" ]; then
  echo "⚠️ Build folder not found. Running build..."
  npm install && npm run build
else
  echo "✅ Build folder already exists. Skipping build."
fi