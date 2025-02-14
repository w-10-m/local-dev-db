# scripts/setup-postgres.sh
#!/bin/bash
echo "Creating PostgreSQL test data..."
PGPASSWORD=dev_password psql -h localhost -U dev_user -d dev_db << EOF
CREATE TABLE IF NOT EXISTS test_users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO test_users (name, email) VALUES
    ('Test User 1', 'test1@example.com'),
    ('Test User 2', 'test2@example.com');
EOF
