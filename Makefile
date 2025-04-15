.PHONY: dev build start stop clean logs help

help:
	@echo "MetaBundle Scraper Commands:"
	@echo "  make dev        - Start development environment with live reloading"
	@echo "  make build      - Build all Docker images"
	@echo "  make start      - Start all services"
	@echo "  make stop       - Stop all services"
	@echo "  make clean      - Remove all containers and images"
	@echo "  make logs       - View logs from all services"
	@echo "  make setup      - Run first-time setup"

dev:
	bash dev.sh

build:
	bash build-images.sh

start:
	docker-compose up -d

stop:
	docker-compose down

clean:
	docker-compose down --rmi all --volumes --remove-orphans

logs:
	docker-compose logs -f

setup:
	bash setup.sh
