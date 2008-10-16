# Tested on mySQL and Postgresql
create table addressbook(userid char(8), entry varchar(70));

# Create an index for the userid, tested on mySQL and  PostgreSQL
create index addressbook_idx on addressbook(userid);

# Create an index for the userid, tested on DB2
#create index addressbook_idx on addressbook(userid) cluster;


# Create preferences table in DB2 (and probably others)
CREATE TABLE preferences(userid char(8) NOT NULL, key varchar(128) NOT NULL, entry varchar(1024) NOT NULL);

# Create preferences table in Mysql
CREATE TABLE preferences(userid char(8) NOT NULL, preferences.key text NOT NULL, entry text NOT NULL);

# Create users table in Mysql - added by ChrisG
CREATE TABLE users(permId CHAR(8) NOT NULL PRIMARY KEY, displayName VARCHAR(50), gatorlinkId VARCHAR(50) NOT NULL UNIQUE, gatorlinkPassword VARCHAR(50) NOT NULL);

# added by ChrisG - FOR DEVELOPMENT ONLY - REMOVE FOR PRODUCTION
# note: the code has been modified not to check that the password
#       in the DB is correct. Just put whatever. -jli
INSERT INTO users SET permId="00000001", displayName="Your Name", gatorlinkId="yourId", gatorlinkPassword="yourPassword";

# after a "use public", run this to grant permissions on all
# tables to the "gatormail" user with the password "omfgbomb". -jli
GRANT ALL ON * TO gatormail@localhost IDENTIFIED BY 'omfgbomb';
