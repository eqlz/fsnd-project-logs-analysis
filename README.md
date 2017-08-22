A SQL view article_path_views is created:
create view article_path_views as
    select path, count(*) as views
    from log
    where status = '200 OK'
    group by path
    order by views desc
    offset 1;


A SQL table article_views is created:
create table article_views(
    slug  text,
    views integer
);


A SQL view daily_errorreq_totalreq is created:
create view daily_errorreq_totalreq as 
select date(time),
       count(case when status like '4%' then 1
                  when status like '5%' then 1 
                  else null 
            end) as error_req, 
       count(*) as total_req 
from log 
group by date(time);


A SQL view error_rate is created:
create view daily_error_rate as
select date, 
       cast(error_req as numeric) / total_req as error_rate
from daily_errorreq_totalreq;