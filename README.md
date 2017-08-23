# Project-Logs-Analysis
Project logs analysis is a python application to generate reports based on information from database *news*.

Databse news is a PostgreSQL database for a fictional news website. news database has three tables:
articles, authors, and log.  Table articles contains information of newspaper articles like article author title and so on.  Table authors has information related to news authors, such as author's name. Table log has a database row for each time a reader loaded a web page.

When running the python application, following reports will be generated:
* the top three most viewed articles
* authors and their articles' total views, author with most views first
* days where above 1% of requests leading to errors

## Running Environment
Python: 3.5  
PostgreSQL: 9.5.8  
psycopg: psycopg2 2.7.3   


## Run the application

Firstly, set up database news
1. Create databse news  
This python application is running in Vagrant virtual machine.  Download Vagrantfile, and creating news database will be automated by `Vagrantfile`.

2. Download newsdata.sql  
Download newsdata.zip, and unzip this file after downloading it.  The file inside is called `newsdata.sql`, and `newsdata.sql` should be put into the same file as Vagrantfile.

3. Import the schema and data from newsdb.sql into news database  
Use command `psql -d news -f newsdata.sql`

Secondly, create SQL views
  

First, connect to the database news via terminal through command line `psql news`, and then create the following SQL views and table:

A SQL view article_path_views
```
create view article_path_views as
    select path, count(*) as views
      from log
     where status = '200 OK'
     group by path
     order by views desc;
```


A SQL view daily_errorreq_totalreq:
```
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
```


After setting up SQL views and table, run the application via command line `python newsdb.py`.  When the application finishes running, three reports will be printed out.

## License
The content of this repository is licensed under **MIT License**.
