use template.nss.dbname;

# Las tablas ...
CREATE TABLE groups (
  name varchar(20) NOT NULL default '',
  password varchar(34) NOT NULL default 'x',
  gid smallint NOT NULL auto_increment,
  PRIMARY KEY  (gid)
) TYPE=MyISAM AUTO_INCREMENT=5000;

CREATE TABLE grouplist (
  rowid smallint NOT NULL auto_increment,
  gid smallint NOT NULL default '0',
  username char(16) NOT NULL default '',
  PRIMARY KEY  (rowid)
) TYPE=MyISAM;

CREATE TABLE users (
  username varchar(20) NOT NULL default '',
  uid smallint NOT NULL auto_increment,
  gid smallint NOT NULL default '5000',
  shell varchar(64) NOT NULL default '/bin/bash',
  password varchar(34) NOT NULL default 'x',
  PRIMARY KEY (uid),
  UNIQUE KEY username (username),
  KEY uid (uid)
) TYPE=MyISAM AUTO_INCREMENT=5000;

# Algunos datos ...
INSERT INTO users (username, password)
    VALUES ('cinergi', SHA1('cinergi'));
INSERT INTO groups (name)
    VALUES ('ssh-mysql');
INSERT INTO grouplist (gid,username)
    VALUES (5000,'cinergi');

# Los permisos ...
GRANT USAGE ON *.* TO `template.nss.admin`@`localhost` IDENTIFIED BY 'template.nss.admin.passwd';
GRANT USAGE ON *.* TO `template.nss.user`@`localhost` IDENTIFIED BY 'template.nss.user.passwd';

GRANT Select (`username`, `uid`, `gid`, `shell`, `password`)
             ON `template.nss.dbname`.`users`
             TO 'template.nss.admin'@'localhost';
GRANT Select (`name`, `password`, `gid`)
             ON `template.nss.dbname`.`groups`
             TO 'template.nss.admin'@'localhost';

GRANT Select (`username`, `uid`, `gid`, `shell`)
             ON `template.nss.dbname`.`users`
             TO 'template.nss.user'@'localhost';
GRANT Select (`name`, `password`, `gid`)
             ON `template.nss.dbname`.`groups`
             TO 'template.nss.user'@'localhost';

GRANT Select (`username`, `gid`)
             ON `template.nss.dbname`.`grouplist`
             TO 'template.nss.user'@'localhost';
GRANT Select (`username`, `gid`)
             ON `template.nss.dbname`.`grouplist`
             TO 'template.nss.admin'@'localhost';
          
FLUSH PRIVILEGES;
