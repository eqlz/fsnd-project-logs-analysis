--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;


--
-- Name: article_path_views; Type: view; Schema: public
--

create view article_path_views as
	select path, count(*) as views
	from log
	where status = '200 OK'
	group by path
	order by views desc;


--
-- Name: daily_errorreq_totalreq; Type: view; Schema: public
--

create view daily_errorreq_totalreq as 
	select date(time),
		   count(case 
                 when status like '4%' then 1
                 when status like '5%' then 1 
                 else null 
                 end) as error_req, 
           count(*) as total_req 
    from log 
    group by date(time);