
# Local Development Database Environment

This repository contains a Docker Compose setup for local development databases including PostgreSQL, MongoDB, and DynamoDB.

## Prerequisites
- Docker
- Docker Compose
- Node.js (optional, for npm scripts)

## Setup
1. Clone this repository
2. Copy `.env.example` to `.env` and adjust values if needed
3. Run `npm install` (optional)
4. Run `npm start` or `docker compose up -d`

## Available Scripts
- `npm start` - Start all databases
- `npm run stop` - Stop all containers
- `npm run clean` - Stop and remove all containers and volumes
- `npm run status` - Check container status
- `npm run logs` - View container logs

## Database Connection Details

### PostgreSQL
- Host: localhost
- Port: 5432
- Database: dev_db
- Username: dev_user
- Password: dev_password
- Connection URL: postgresql://dev_user:dev_password@localhost:5432/dev_db

Compatible with tools like:
- pgAdmin
- DBeaver
- TablePlus
- DataGrip

### MongoDB
- Host: localhost
- Port: 27017
- Username: dev_user
- Password: dev_password
- Authentication Database: admin
- Connection String: mongodb://dev_user:dev_password@localhost:27017

Compatible with tools like:
- MongoDB Compass
- Studio 3T
- NoSQLBooster

### DynamoDB Local
- Endpoint: http://localhost:8000
- Region: any (typically use us-east-1)
- Access Key: any (dummy value)
- Secret Key: any (dummy value)

Compatible with tools like:
- NoSQL Workbench
- Dynamodb-admin
- AWS CLI (with --endpoint-url parameter)

Note: For DynamoDB Local, you can use any dummy AWS credentials as it doesn't perform real authentication.

## Database Versions
- PostgreSQL: 16.2
- MongoDB: 7.0.5
- DynamoDB Local: 2.1.0

## Examples

### Connecting with AWS CLI (DynamoDB)
```bash
aws dynamodb list-tables --endpoint-url http://localhost:8000
```

### Connecting with psql (PostgreSQL)
```bash
psql -h localhost -U dev_user -d dev_db
```

### Connecting with mongosh (MongoDB)
```bash
mongosh mongodb://dev_user:dev_password@localhost:27017
```