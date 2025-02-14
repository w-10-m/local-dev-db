
# scripts/backup-databases.sh
#!/bin/bash
BACKUP_DIR="./backups/$(date +%Y%m%d)"
mkdir -p $BACKUP_DIR

echo "Backing up PostgreSQL..."
PGPASSWORD=dev_password pg_dump -h localhost -U dev_user -d dev_db > "$BACKUP_DIR/postgres_backup.sql"

echo "Backing up MongoDB..."
mongodump --uri="mongodb://dev_user:dev_password@localhost:27017" --out="$BACKUP_DIR/mongo_backup"

echo "Backing up DynamoDB..."
mkdir -p "$BACKUP_DIR/dynamodb"
aws dynamodb scan --table-name TestUsers --endpoint-url http://localhost:8000 > "$BACKUP_DIR/dynamodb/TestUsers.json"
