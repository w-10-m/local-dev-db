# scripts/setup-dynamodb.sh
#!/bin/bash
echo "Creating DynamoDB test table..."
aws dynamodb create-table \
    --table-name TestUsers \
    --attribute-definitions AttributeName=id,AttributeType=S \
    --key-schema AttributeName=id,KeyType=HASH \
    --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5 \
    --endpoint-url http://localhost:8000

aws dynamodb batch-write-item \
    --request-items '{
        "TestUsers": [
            {
                "PutRequest": {
                    "Item": {
                        "id": {"S": "1"},
                        "name": {"S": "Test User 1"},
                        "email": {"S": "test1@example.com"}
                    }
                }
            },
            {
                "PutRequest": {
                    "Item": {
                        "id": {"S": "2"},
                        "name": {"S": "Test User 2"},
                        "email": {"S": "test2@example.com"}
                    }
                }
            }
        ]
    }' \
    --endpoint-url http://localhost:8000
