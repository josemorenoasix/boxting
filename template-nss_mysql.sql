#
#  Tipo de variables:
#  Claves almacenadas con la funcion SHA1() - https://dev.mysql.com/doc/refman/5.7/en/encryption-functions.html#function_sha1
#   password -> varchar(60)  
#  Nombres de usuario limitados a 20 caracteres  
#   name/username -> varchar(20) 
#
# http://libnss-mysql.sourceforge.net/libnss-mysql/sample/linux/sample_database.sql
# http://www.tldp.org/LDP/lame/LAME/linux-admin-made-easy/shadow-file-formats.html 

USE  template.nss.dbname;

DROP TABLE IF EXISTS groups;
CREATE TABLE groups (
  gid int(11) auto_increment primary key,
  name varchar(30) DEFAULT '' NOT NULL,
  password varchar(60) DEFAULT 'x' NOT NULL,
  flag char(1) DEFAULT 'A'
) ENGINE=MyISAM AUTO_INCREMENT=5000;
INSERT INTO groups (gid,name,password) VALUES ('4999','nss-account-group',SHA('$password'));

DROP TABLE IF EXISTS users;
CREATE TABLE users (
  uid int(11) auto_increment primary key,
  username varchar(20) UNIQUE NOT NULL,
  gecos varchar(40) DEFAULT 'nss-account-user' NOT NULL,
  shell varchar(20) NOT NULL,
  password varchar(60) NOT NULL,
  flag char(1) DEFAULT 'Y' NOT NULL,
  gid int(11) DEFAULT '4999' NOT NULL,
  homedir varchar(64) NOT NULL,
  lstchg varchar(50) NOT NULL default '',
  min int(11) NOT NULL default '0',
  max int(11) NOT NULL default '0',
  warn int(11) NOT NULL default '7',
  inact int(11) NOT NULL default '-1',
  expire int(11) NOT NULL default '-1'
) ENGINE=MyISAM AUTO_INCREMENT=5000;

DROP TABLE IF EXISTS grouplist;
CREATE TABLE grouplist (
  dbid int(11) NOT NULL auto_increment primary key,
  gid int(11) NOT NULL,
  uid int(11) NOT NULL,
  username varchar(20) NOT NULL
) ENGINE=MyISAM;

GRANT select(username,uid,gid,gecos,shell,homedir,flag) on users to 'template.nss.user'@localhost identified by 'template.nss.user.passwd';
GRANT select(name,gid,password,flag) on groups to 'template.nss.user'@localhost identified by 'template.nss.user.passwd';
GRANT select(dbid,gid,uid,username) on grouplist to 'template.nss.user'@localhost identified by 'template.nss.user.passwd';
GRANT select(username,password,uid,gid,gecos,shell,homedir,flag,lstchg,min,max,warn,inact,expire) on users to 'template.nss.user'@localhost identified by 'template.nss.user.passwd';
GRANT select(username,uid,gid,gecos,shell,homedir,flag) on users to 'template.nss.admin'@localhost identified by 'template.nss.admin.passwd';
GRANT select(name,gid,password,flag) on groups to 'template.nss.admin'@localhost identified by 'template.nss.admin.passwd';
GRANT select(dbid,gid,uid,username) on grouplist to 'template.nss.admin'@localhost identified by 'template.nss.admin.passwd';
GRANT select(username,password,uid,gid,gecos,shell,homedir,flag,lstchg,min,max,warn,inact,expire) on users to 'template.nss.admin'@localhost identified by 'template.nss.admin.passwd';
GRANT update(username,password,uid,gid,gecos,shell,homedir,flag,lstchg,min,max,warn,inact,expire) on users to 'template.nss.admin'@localhost identified by 'template.nss.admin.passwd';

FLUSH PRIVILEGES;

