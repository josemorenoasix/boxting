USE nss_mysql;

DROP TABLE IF EXISTS groups;
CREATE TABLE groups (
  dbid int(11) NOT NULL auto_increment primary key,
  name varchar(30) DEFAULT '' NOT NULL,
  gid int(11) NOT NULL,
  password varchar(64) DEFAULT 'x' NOT NULL,
  flag char(1) DEFAULT 'A'
);
INSERT INTO groups VALUES (1,'users',100,'x','A');

DROP TABLE IF EXISTS users;
CREATE TABLE users (
  dbid int(11) NOT NULL auto_increment primary key,
  username varchar(50) DEFAULT '' NOT NULL,
  gecos varchar(40) DEFAULT '' NOT NULL,
  shell varchar(20) DEFAULT '/bin/sh' NOT NULL,
  password varchar(60) DEFAULT '' NOT NULL,
  flag char(1) DEFAULT 'N' NOT NULL,
  uid int(11) NOT NULL,
  gid int(11) NOT NULL,
  homedir varchar(64) DEFAULT '/bin/sh' NOT NULL,
  lstchg varchar(50) NOT NULL default '',
  min int(11) NOT NULL default '0',
  max int(11) NOT NULL default '0',
  warn int(11) NOT NULL default '7',
  inact int(11) NOT NULL default '-1',
  expire int(11) NOT NULL default '-1'
);

DROP TABLE IF EXISTS grouplist;
CREATE TABLE grouplist (
  dbid int(11) NOT NULL auto_increment primary key,
  gid int(11) DEFAULT '0' NOT NULL,
  uid int(11) DEFAULT '0' NOT NULL,
  username varchar(50) DEFAULT '' NOT NULL
);

GRANT select(dbid,username,uid,gid,gecos,shell,homedir,flag) on users to 'template.nss.user'@localhost identified by 'template.nss.user.passwd';
GRANT select(dbid,name,gid,password,flag) on groups to 'template.nss.user'@localhost identified by 'template.nss.user.passwd';
GRANT select(dbid,gid,uid,username) on grouplist to 'template.nss.user'@localhost identified by 'template.nss.user.passwd';
GRANT select(dbid,username,password,uid,gid,gecos,shell,homedir,flag,lstchg,min,max,warn,inact,expire) on users to 'template.nss.user'@localhost identified by 'template.nss.user.passwd';
GRANT select(dbid,username,uid,gid,gecos,shell,homedir,flag) on users to 'template.nss.admin'@localhost identified by 'template.nss.admin.passwd';
GRANT select(dbid,name,gid,password,flag) on groups to 'template.nss.admin'@localhost identified by 'template.nss.admin.passwd';
GRANT select(dbid,gid,uid,username) on grouplist to 'template.nss.admin'@localhost identified by 'template.nss.admin.passwd';
GRANT select(dbid,username,password,uid,gid,gecos,shell,homedir,flag,lstchg,min,max,warn,inact,expire) on users to 'template.nss.admin'@localhost identified by 'template.nss.admin.passwd';
GRANT update(dbid,username,password,uid,gid,gecos,shell,homedir,flag,lstchg,min,max,warn,inact,expire) on users to 'template.nss.admin'@localhost identified by 'template.nss.admin.passwd';

FLUSH PRIVILEGES;
