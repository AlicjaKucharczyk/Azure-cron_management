CREATE SCHEMA cron_management;

CREATE or replace FUNCTION cron_management.alter_job(job_id bigint, schedule text DEFAULT NULL::text, command text DEFAULT NULL::text, database text DEFAULT NULL::text, username text DEFAULT NULL::text, active boolean DEFAULT NULL::boolean) RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'cron'
    AS $$ 
BEGIN 
        EXECUTE cron.alter_job(job_id, schedule, command, database, username, active);
END;
$$;

CREATE FUNCTION cron_management.schedule(schedule text, command text) RETURNS bigint
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'cron'
    AS $$ 
BEGIN 
        RETURN cron.schedule(schedule, command);
END;
$$;

CREATE FUNCTION cron_management.schedule(job_name text, schedule text, command text) RETURNS bigint
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'cron'
    AS $$ 
BEGIN 
        RETURN cron.schedule(job_name, schedule, command);
END;
$$;

CREATE FUNCTION cron_management.schedule_in_database(job_name text, schedule text, command text, database text, username text DEFAULT NULL::text, active boolean DEFAULT true) RETURNS bigint
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'cron'
    AS $$ 
BEGIN 
        RETURN cron.schedule_in_database(job_name, schedule, command, database, username, active);
END;
$$;

CREATE FUNCTION cron_management.unschedule(job_id bigint) RETURNS boolean
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'cron'
    AS $$ 
BEGIN 
        RETURN cron.unschedule(job_id);
END;
$$;

CREATE FUNCTION cron_management.unschedule(job_name name) RETURNS boolean
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'cron'
    AS $$ 
BEGIN 
        RETURN cron.unschedule(job_name);
END;
$$;

CREATE FUNCTION cron_management.show_job_runs() RETURNS TABLE(jobid bigint, runid bigint, job_pid integer, database text, username text, command text, status text, return_message text, start_time timestamp with time zone, end_time timestamp with time zone)
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'cron'
    AS $$ 
BEGIN 
        RETURN QUERY
        TABLE cron.job_run_details;
END;
$$;

CREATE FUNCTION cron_management.show_jobs() RETURNS TABLE(jobid bigint, schedule text, command text, nodename text, nodeport integer, database text, username text, active boolean, jobname text)
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'cron'
    AS $$ 
BEGIN 
        RETURN QUERY
        TABLE cron.job;
END;
$$;





