# scripts/setup-postgres.sh
#!/bin/bash

# Wait for PostgreSQL to be ready
echo "Waiting for PostgreSQL to start..."
until PGPASSWORD=postgres psql -h localhost -U postgres -c '\q' 2>/dev/null; do
  echo "PostgreSQL is unavailable - sleeping"
  sleep 1
done

echo "Creating dev_user..."
PGPASSWORD=postgres psql -h localhost -U postgres -c "CREATE USER dev_user WITH PASSWORD 'dev_password' CREATEDB;" || true

echo "Granting privileges to dev_user..."
PGPASSWORD=postgres psql -h localhost -U postgres -c "ALTER USER dev_user WITH SUPERUSER;" || true

echo "Creating dev_db database..."
PGPASSWORD=postgres psql -h localhost -U postgres -c "CREATE DATABASE dev_db;" || true

echo "PostgreSQL setup completed!"

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
