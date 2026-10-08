-- 1. Create a read-only user
CREATE ROLE readonly_user
WITH LOGIN PASSWORD 'hehe';

-- 2. Allow connection to the warehouse database
GRANT CONNECT ON DATABASE warehouse TO readonly_user;

-- 3. Allow access to the raw schema
GRANT USAGE ON SCHEMA raw TO readonly_user;

-- 4. Allow SELECT on all existing tables
GRANT SELECT ON ALL TABLES IN SCHEMA raw TO readonly_user;
