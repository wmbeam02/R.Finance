library(RMySQL) 
## Double Octothorpes are the code to append multiple DFs into a TABLE
setwd( 'C:\\Users\\Matt\\Desktop\\R Work\\IB' )
Tick.DF=read.table( 'TickTesting.txt', stringsAsFactors=F, sep=';' )
## Tick2.DF=read.table( 'TickTestingDos.txt', stringsAsFactors=F, sep=';' )
names( Tick.DF )=c( 'Time', 'Price', 'Size' )
## names( Tick2.DF )=c( 'Time', 'Price', 'Size' )
Tick.DF$Time=strptime( Tick.DF$Time, format='%Y%m%d %H%M%S' )
## Tick2.DF$Time=strptime( Tick2.DF$Time, format='%Y%m%d %H%M%S' )
Tick.DF.sub=Tick.DF[Tick.DF$Time <= '2014-02-11 15:00:00', ]
# Creating a unique table name

currentDate=Sys.Date()
# Creating Schema
conn=dbConnect( MySQL(), user='root', password='password', host='localhost' )
dbSendQuery( conn, 'CREATE DATABASE ticktest1' )
dbSendQuery( conn, "USE testing" )
conn=dbConnect( MySQL(), user='root', password='password', host='localhost', dbname='ticktest1' )
dbSendQuery( conn, 'drop table if exists tick' )

# Creating Generic Table:
# dbSendQuery( conn, 'CREATE TABLE tick (trade_id INT AUTO_INCREMENT PRIMARY KEY, time DATETIME, price INT, size INT );' ) 

# Creating Table from DF
dbWriteTable( conn, 'ticktable1', Tick.DF.sub, row.names=F )
## dbWriteTable( conn, db.name, Tick2.DF, row.names=F, append=T )

dbSendQuery( conn, 'ALTER TABLE ticktable1 ADD COLUMN tick_id INT AUTO_INCREMENT PRIMARY KEY;' )
