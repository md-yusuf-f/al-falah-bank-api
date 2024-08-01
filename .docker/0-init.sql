SELECT 'CREATE DATABASE alfalah' WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = 'alfalah')\gexec
GRANT ALL PRIVILEGES ON DATABASE alfalah TO postgres;
