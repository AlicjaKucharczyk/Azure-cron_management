CREATE USER myuser;
\c postgres myuser
SET search_path TO cron_management ;
SELECT cron_management.schedule('* * * * *','ANALYZE pg_class;');
SELECT * FROM cron_management.show_jobs();
SELECT * FROM cron_management.show_job_runs();
SELECT cron_management.unschedule(1);
SELECT cron_management.schedule('* * * * *','ANALYZE pg_class;');
SELECT cron_management.schedule('Analyze pg_class','* * * * *','ANALYZE pg_class;');
SELECT cron_management.unschedule('Analyze pg_class');
SELECT cron_management.alter_job(2, command := 'ANALYZE pg_collation;');
SELECT * FROM cron_management.show_jobs();
SELECT * FROM cron_management.schedule_in_database('analyze pg_cast', '* * * * *', 'ANALYZE pg_cast;', 'template1');
SELECT * FROM cron_management.show_jobs();
