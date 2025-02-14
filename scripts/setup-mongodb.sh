# scripts/setup-mongodb.sh
#!/bin/bash
echo "Creating MongoDB test data..."
mongosh "mongodb://dev_user:dev_password@localhost:27017" << EOF
use test_db
db.createCollection('users')
db.users.insertMany([
    { name: 'Test User 1', email: 'test1@example.com', createdAt: new Date() },
    { name: 'Test User 2', email: 'test2@example.com', createdAt: new Date() }
])
EOF