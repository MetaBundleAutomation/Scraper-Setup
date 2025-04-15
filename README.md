# MetaBundle Scraping Project

This is the root folder for the MetaBundle Scraping System, which handles orchestration and environment setup for the entire scraping architecture.

## Project Structure

The project consists of four main components:

1. **Scraper-Setup** (root directory): Handles orchestration and environment setup
2. **Scraper-Manager**: FastAPI backend that receives frontend requests and spins up new scraper instances
3. **Scraper-Instance**: Lightweight container that runs mock scrape tasks
4. **Scraper-Dashboard**: React + TypeScript frontend to issue scrape commands and display logs

## Getting Started

### Prerequisites

- Docker and Docker Compose
- Git
- Bash shell (Git Bash for Windows)

### Installation

1. Clone this repository:
   ```
   git clone https://github.com/MetaBundleAutomation/Scraper-Setup
   cd Scraper-Setup
   ```

2. Run the setup script:
   ```
   bash setup.sh
   ```
   This will:
   - Check if this is the first time running the setup
   - Create a .env file from the template if needed
   - Clone the other required repositories
   - Start the Docker Compose stack

### Development

For development purposes, you can use the `dev.sh` script:

```
bash dev.sh
```

This will start all services in development mode, with proper volume mounting for live code changes.

## Component Interaction

1. The **Scraper-Dashboard** frontend provides a button to spawn scrapers
2. When clicked, it calls the **Scraper-Manager** backend's `/spawn` endpoint
3. The **Scraper-Manager** then launches a new **Scraper-Instance** container
4. The **Scraper-Instance** runs a mock scrape task and returns a message
5. The **Scraper-Dashboard** displays this message in its console

## Recent Updates

### Improved Container Lifecycle Management

The system has been enhanced with the following improvements:

- **Self-Removing Containers**: Scraper-Instance containers now remove themselves after task completion
- **Resource Efficiency**: Optimized memory and CPU usage by ensuring containers are fully removed
- **Simplified Workflow**: Streamlined the scraper instance to send Hello World messages and results
- **Improved Communication**: Enhanced message relay between components for better visibility

### Technical Implementation Details

- Docker socket mounting allows containers to remove themselves using the Docker API
- Containers use curl to make API calls to the Docker daemon
- The Manager stores messages and provides an endpoint for the Dashboard to retrieve them
- The Dashboard polls for messages and displays them in real-time

## Next Steps

### Environment Variable Configuration

We are planning to implement a unified environment variable configuration system that will:

1. Allow configuration of all components from a single `.env` file in the root directory
2. Propagate environment variables to all containers automatically
3. Support dynamic port configuration for both frontend and backend services
4. Enable easier deployment across different environments

## Environment Variables

Key environment variables are stored in the `.env` file:

- `FIRST_TIME_RUN`: Set to `true` when first setting up the project
- `BACKEND_PORT`: Port for the FastAPI backend (default: 8000)
- `FRONTEND_PORT`: Port for the React frontend (default: 3000)
- `COMPOSE_PROJECT_NAME`: Name for the Docker Compose project

## License

This project is proprietary and confidential.
