#!/bin/bash

# Check if .env file exists, create from example if it doesn't
if [ ! -f .env ]; then
  echo "Creating .env file from template..."
  cp .env.example .env
fi

# Build and start the Docker Compose stack in development mode
echo "Starting development environment..."
docker-compose up --build

echo "Development environment is now running. Press Ctrl+C to stop."
