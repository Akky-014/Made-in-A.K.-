-- init.sql
CREATE DATABASE django_db;
CREATE USER django_user WITH PASSWORD 'django_password';
GRANT ALL PRIVILEGES ON DATABASE django_db TO django_user;