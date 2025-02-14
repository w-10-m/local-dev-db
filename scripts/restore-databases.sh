
# scripts/restore-databases.sh
#!/bin/bash
if [ -z "$1" ]; then
    echo "Please provide backup directory date (YYYYMMDD)"
    echo "Example: ./restore-databases.sh 20240213"
    exit 1
fi

BACKUP_DIR="./backups/$1"

if [ ! -d "$BACKUP_DIR" ]; then
    echo "Backup directory $BACKUP_DIR not found!"
    exit 1
fi

echo "Restoring from backup directory: $BACKUP_DIR"

# Restore PostgreSQL
if [ -f "$BACKUP_DIR/postgres_backup.sql" ]; then
    echo "Restoring PostgreSQL..."
    PGPASSWORD=dev_password psql -h localhost -U dev_user -d dev_db < "$BACKUP_DIR/postgres_backup.sql"
else
    echo "PostgreSQL backup file not found!"
fi

# Restore MongoDB
if [ -d "$BACKUP_DIR/mongo_backup" ]; then
    echo "Restoring MongoDB..."
    mongorestore --uri="mongodb://dev_user:dev_password@localhost:27017" "$BACKUP_DIR/mongo_backup"
else
    echo "MongoDB backup directory not found!"
fi

# Restore DynamoDB
if [ -f "$BACKUP_DIR/dynamodb/TestUsers.json" ]; then
    echo "Restoring DynamoDB..."
    # First ensure the table exists
    aws dynamodb create-table \
        --table-name TestUsers \
        --attribute-definitions AttributeName=id,AttributeType=S \
        --key-schema AttributeName=id,KeyType=HASH \
        --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5 \
        --endpoint-url http://localhost:8000 2>/dev/null || true
    
    # Parse JSON backup and restore items
    cat "$BACKUP_DIR/dynamodb/TestUsers.json" | jq -c '.Items[]' | while read -r item; do
        aws dynamodb put-item \
            --table-name TestUsers \
            --item "$item" \
            --endpoint-url http://localhost:8000
    done
else
    echo "DynamoDB backup file not found!"
fi

echo "Restore completed!"