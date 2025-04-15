#!/bin/bash

echo "Building all Docker images for MetaBundle Scraper..."

echo "Building Scraper-Manager..."
cd Scraper-Manager
docker build -t scraper-manager:latest .
cd ..

echo "Building Scraper-Instance..."
cd Scraper-Instance
docker build -t scraper-instance:latest .
cd ..

echo "Building Scraper-Dashboard..."
cd Scraper-Dashboard
docker build -t scraper-dashboard:latest .
cd ..

echo "All images built successfully!"
