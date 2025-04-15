#!/bin/bash

# Check if FIRST_TIME_RUN is set
if [ -z "$FIRST_TIME_RUN" ]; then
  echo "Environment variable 'FIRST_TIME_RUN' not set."
  read -p "Is this your first time setting up the Scraper project? (Y/N): " confirm
  if [ "$confirm" = "Y" ]; then
    echo "Setting up environment..."
    export FIRST_TIME_RUN=true
    
    # Create .env file from template if it doesn't exist
    if [ ! -f .env ]; then
      cp .env.example .env
      echo ".env file created from template."
    fi
    
    # Clone repositories if they don't exist
    if [ ! -d "Scraper-Manager" ]; then
      git clone https://github.com/MetaBundleAutomation/Scraper-Manager
    fi
    
    if [ ! -d "Scraper-Dashboard" ]; then
      git clone https://github.com/MetaBundleAutomation/Scraper-Dashboard
    fi
    
    if [ ! -d "Scraper-Instance" ]; then
      git clone https://github.com/MetaBundleAutomation/Scraper-Instance
    fi
    
    echo "Setup completed successfully."
  else
    echo "Aborting setup."
    exit 1
  fi
fi

# Start the Docker Compose stack
echo "Starting Docker Compose stack..."
docker-compose up -d

echo "MetaBundle Scraper system is now running."
