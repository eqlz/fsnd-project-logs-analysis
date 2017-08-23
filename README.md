# Project-Logs-Analysis
Project logs analysis is a python application to generate reports based on information from database *news*.

Databse news is a PostgreSQL database for a fictional news website. Database news has three tables:
articles, authors, and log.  Table articles contains information of newspaper articles like article author, title and so on.  Table authors has information related to news authors, such as author's name. Table log has a database row for each time a reader loaded a web page.

When running the python application, following reports will be generated:
* the top three most viewed articles
* authors and their articles' total views, author with most views first
* days where above 1% of requests leading to errors

## Running Environment
Python: 3.5    
PostgreSQL: 9.5.8    
psycopg: psycopg2 2.7.3     


## Run the application

Firstly, set up database *news*
1. Create databse news  
This python application is running in Vagrant virtual machine.  Download Vagrantfile, and creating news database will be automated by `Vagrantfile`.

2. Download newsdata.sql  
Download newsdata.zip, and unzip this file after downloading it.  The file inside is called `newsdata.sql`, and `newsdata.sql` should be put into the same folder as Vagrantfile.

3. Import the schema and data from `newsdb.sql` into news database  
Use command `psql -d news -f newsdata.sql`

Secondly, create SQL views

An SQL script `create_views.sql`, has been made to contain `CREATE VIEW` statements for this application.

1. Downlaod `create_view.sql` to the same folder where `newsdata.sql` is put

2. Import views to news database, using the command line: `psql -d news -f create_views.sql`

At last, after setting up database and views, run the application via command line `python3 newsdb.py`.

When the application finishes running, three reports will be printed out.  To find out what reports should look like, check `Reports.txt`.

## License
The content of this repository is licensed under **MIT License**.