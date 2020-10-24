library(RPostgreSQL)

# loads the PostgreSQL driver
drv <- dbDriver("PostgreSQL")

# creates a connection to the postgres database
con <- dbConnect(drv, dbname = "db_secop",
                 host = "ds4a-instance.c0wb6thhjklc.us-east-1.rds.amazonaws.com", 
                 port = 5432,
                 user = "postgres", 
                 password = "ds4a#202082")

# query the data from postgreSQL 
query <- "SELECT * FROM secop LIMIT 10"

Sdf_secop <- dbGetQuery(con, query)
