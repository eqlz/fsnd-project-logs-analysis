# Project-Logs-Analysis
Project logs analysis uses a given database called news to generate reports.  This python application can generate the following reports:
* the top three most viewed articles
* authors and their articles' total views, author with most views first
* days where above 1% of requests leading to errors

## Running Environment
Python 2.7

## Run the application
First, connect to the database news via terminal through command line `psql news`, and then create the following SQL views and table:

A SQL view article_path_views
`create view article_path_views as
    select path, count(*) as views
      from log
     where status = '200 OK'
     group by path
     order by views desc
    offset 1;`

A SQL table article_views
`create table article_views(
     slug text,
    views integer
);`

A SQL view daily_errorreq_totalreq:
`create view daily_errorreq_totalreq as 
    select date(time),
           count(case 
                 when status like '4%' then 1
                 when status like '5%' then 1 
                 else null 
                 end) as error_req, 
           count(*) as total_req 
      from log 
  group by date(time);`

A SQL view daily_error_rate
`create view daily_error_rate as
    select date, 
           cast(error_req as numeric) / total_req as error_rate
      from daily_errorreq_totalreq;`

After setting up SQL views and table, run the application via command line `python newsdb.py`.  When the application finishes running, three reports will be printed out.

## License
The content of this repository is licensed under **MIT License**.