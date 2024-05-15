# Azure-cron_management
Provides a workaround to manage pg_cron permissions in Azure Database for PostgreSQL Flexible Server without full admin rights, focusing on custom users needing to execute scheduled tasks securely.

# Setup
Run the `create_schema.sql` script on the database where `pg_cron` is installed, typically the `postgres` database. If you have modified the `cron.database_name` parameter to a different database and wish to manage it from there, adjust accordingly.

```bash
psql -f create_schema.sql postgres
```

Once the schema is created, grant privileges to the new objects to the user designated to manage `pg_cron`. Replace `myuser` with your user name.

```sql
GRANT USAGE ON SCHEMA cron_management TO myuser;
GRANT ALL ON FUNCTION cron_management.alter_job(job_id bigint, schedule text, command text, database text, username text, active boolean) TO myuser;
GRANT ALL ON FUNCTION cron_management.schedule(schedule text, command text) TO myuser;
GRANT ALL ON FUNCTION cron_management.schedule(job_name text, schedule text, command text) TO myuser;
GRANT ALL ON FUNCTION cron_management.schedule_in_database(job_name text, schedule text, command text, database text, username text, active boolean) TO myuser;
GRANT ALL ON FUNCTION cron_management.unschedule(job_id bigint) TO myuser;
GRANT ALL ON FUNCTION cron_management.unschedule(job_name name) TO myuser;
GRANT ALL ON FUNCTION cron_management.show_jobs() TO myuser;
GRANT ALL ON FUNCTION cron_management.show_job_runs() TO myuser;
```

Check if your user is able to schedule jobs:

`SELECT cron_management.schedule('* * * * *','ANALYZE pg_class;');`