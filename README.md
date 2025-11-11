# Voting Application - DevOps Challenge

## Project Overview

This is a distributed voting application that allows users to vote between two options and view real-time results. The application consists of multiple microservices that work together to provide a complete voting experience.

## Application Architecture

The voting application consists of the following components:

![Architecture Diagram](./architecture.excalidraw.png)

### Frontend Services
- **Vote Service** (`/vote`): Python Flask web application that provides the voting interface
- **Result Service** (`/result`): Node.js web application that displays real-time voting results

### Backend Services  
- **Worker Service** (`/worker`): .NET worker application that processes votes from the queue
- **Redis**: Message broker that queues votes for processing
- **PostgreSQL**: Database that stores the final vote counts

### Data Flow
1. Users visit the vote service to cast their votes
2. Votes are sent to Redis queue
3. Worker service processes votes from Redis and stores them in PostgreSQL
4. Result service queries PostgreSQL and displays real-time results via WebSocket

### Network Architecture
The application should use a **two-tier network architecture** for security and organization:

- **Frontend Tier Network**: 
  - Vote service (port 8080)
  - Result service (port 8081)
  - Accessible from outside the Docker environment

- **Backend Tier Network**:
  - Worker service
  - Redis
  - PostgreSQL
  - Internal communication only

This separation ensures that database and message queue services are not directly accessible from outside, while the web services remain accessible to users.

## Your Task

As a DevOps engineer, your task is to containerize this application and create the necessary infrastructure files. You need to create:

### 1. Docker Files
Create `Dockerfile` for each service:
- `vote/Dockerfile` - for the Python Flask application
- `result/Dockerfile` - for the Node.js application  
- `worker/Dockerfile` - for the .NET worker application
- `seed-data/Dockerfile` - for the data seeding utility

### 2. Docker Compose
Create `docker-compose.yml` that:
- Defines all services with proper networking using **two-tier architecture**:
  - **Frontend tier**: Vote and Result services (user-facing)
  - **Backend tier**: Worker, Redis, and PostgreSQL (internal services)
- Sets up health checks for Redis and PostgreSQL
- Configures proper service dependencies
- Exposes the vote service on port 8080 and result service on port 8081
- Uses the provided health check scripts in `/healthchecks` directory

### 3. Health Checks
The application includes health check scripts:
- `healthchecks/redis.sh` - Redis health check
- `healthchecks/postgres.sh` - PostgreSQL health check

Use these scripts in your Docker Compose configuration to ensure services are ready before dependent services start.

## Requirements

- All services should be properly networked using **two-tier architecture**:
  - **Frontend tier network**: Connect Vote and Result services
  - **Backend tier network**: Connect Worker, Redis, and PostgreSQL
  - Both tiers should be isolated for security
- Health checks must be implemented for Redis and PostgreSQL
- Services should wait for their dependencies to be healthy before starting
- The vote service should be accessible at `http://localhost:8080`
- The result service should be accessible at `http://localhost:8081`
- Use appropriate base images and follow Docker best practices
- Ensure the application works end-to-end when running `docker compose up`
- Include a seed service that can populate test data

## Data Population

The application includes a seed service (`/seed-data`) that can populate the database with test votes:

- **`make-data.py`**: Creates URL-encoded vote data files (`posta` and `postb`)
- **`generate-votes.sh`**: Uses Apache Bench (ab) to send 3000 test votes:
  - 2000 votes for option A
  - 1000 votes for option B

### How to Use Seed Data

1. Include the seed service in your `docker-compose.yml`
2. Run the seed service after all other services are healthy:
   ```bash
   docker compose run --rm seed
   ```
3. Or run it as a one-time service with a profile:
   ```bash
   docker compose --profile seed up
   ```

## Getting Started

1. Examine the source code in each service directory
2. Create the necessary Dockerfiles
3. Create the docker-compose.yml file with two-tier networking
4. Test your implementation by running `docker compose up`
5. Populate test data using the seed service
6. Verify that you can vote and see results in real-time

## Notes

- The voting application only accepts one vote per client browser
- The result service uses WebSocket for real-time updates
- The worker service continuously processes votes from the Redis queue
- Make sure to handle service startup order properly with health checks

Good luck with your challenge! 🚀