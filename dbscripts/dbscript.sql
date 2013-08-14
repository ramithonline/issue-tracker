SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE SCHEMA IF NOT EXISTS `issueTrackerDb` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
use issueTrackerDb;
-- -----------------------------------------------------
-- Table `issueTrackerDb`.`Project`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS PROJECT (
    PROJECT_ID          INTEGER NOT NULL AUTO_INCREMENT,
    PROJECT_NAME        VARCHAR(45) NULL,
    OWNER               VARCHAR(45) NULL,
    ORGANIZATION_ID     INT NOT NULL,
    CONSTRAINT PK_PROJECT PRIMARY KEY (PROJECT_ID)
)  ENGINE=INNODB;

-- -----------------------------------------------------
-- Table `issueTrackerDb`.`Version`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS VERSION (
    VERSION_ID          INTEGER NOT NULL AUTO_INCREMENT,
    VERSION             VARCHAR(45) NULL,
    PROJECT_ID          INT NOT NULL,
    CONSTRAINT PK_VERSION PRIMARY KEY (VERSION_ID)
)  ENGINE=INNODB;
ALTER TABLE VERSION ADD CONSTRAINT VERSION_FK_BY_PROJECT_ID FOREIGN KEY (PROJECT_ID) REFERENCES PROJECT (PROJECT_ID);
CREATE INDEX VERSION_IND_BY_PROJECT_ID USING HASH ON VERSION(PROJECT_ID);


-- -----------------------------------------------------
-- Table `issueTrackerDb`.`Issue`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS ISSUE (
    ISSUE_ID            INTEGER NOT NULL AUTO_INCREMENT,
    PKEY                VARCHAR(45) NULL,
    PROJECT_ID          INT NOT NULL,
    SUMMARY             VARCHAR(45) NULL,
    DESCRIPTION         TEXT NULL,
    ISSUE_TYPE          VARCHAR(45) NULL,
    PRIORITY            VARCHAR(45) NULL,
    OWNER               VARCHAR(45) NULL,
    STATUS              VARCHAR(45) NULL,
    ASSIGNEE            VARCHAR(45) NULL,
    VERSION_ID          INT NOT NULL,
    CREATED_TIME        TIMESTAMP NULL,
    UPDATED_TIME        TIMESTAMP NULL,
    SEVERITY            VARCHAR(45) NULL,
    CONSTRAINT PK_ISSUE PRIMARY KEY (ISSUE_ID),
    UNIQUE (PKEY)
)  ENGINE=INNODB;
ALTER TABLE ISSUE ADD CONSTRAINT ISSUE_FK_BY_PROJECT_ID FOREIGN KEY (PROJECT_ID) REFERENCES PROJECT (PROJECT_ID);
CREATE INDEX ISSUE_IND_BY_PROJECT_ID USING HASH ON PROJECT (PROJECT_ID);

-- -----------------------------------------------------
-- Table `issueTrackerDb`.`Comment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS COMMENT (
    COMMENT_ID          INTEGER NOT NULL AUTO_INCREMENT,
    COMMENT             TEXT NULL,
    CREATED_TIME        TIMESTAMP NULL,
    UPDATED_TIME        TIMESTAMP NULL,
    COMMENT_CREATOR     VARCHAR(45) NULL,
    ISSUE_ID            INT NOT NULL,
    CONSTRAINT PK_COMMENT PRIMARY KEY (COMMENT_ID)
)  ENGINE INNODB;
ALTER TABLE COMMENT ADD CONSTRAINT COMMENT_FK_BY_ISSUE_ID FOREIGN KEY (ISSUE_ID) REFERENCES ISSUE (ISSUE_ID);
CREATE INDEX COMMENT_IND_BY_COMMENT_ID USING HASH ON COMMENT(ISSUE_ID);
 
-- -----------------------------------------------------
-- Table `issueTrackerDb`.`VERSIONISSUES`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS VERSIONISSUES (
    VERSION_ID          INT NOT NULL,
    ISSUE_ID            INT NOT NULL
)  ENGINE INNODB;
ALTER TABLE VERSIONISSUES ADD CONSTRAINT VERSIONISSUES_FK_BY_VERSION_ID FOREIGN KEY (VERSION_ID) REFERENCES VERSION(VERSION_ID);
ALTER TABLE VERSIONISSUES ADD CONSTRAINT VERSIONISSUES_FK_BY_ISSUE_ID FOREIGN KEY (ISSUE_ID) REFERENCES ISSUE (ISSUE_ID);

 
  
INSERT INTO PROJECT (PROJECT_NAME,OWNER,ORGANIZATION_ID) VALUES ('UES','Nuwan','1');
INSERT INTO PROJECT (PROJECT_NAME,OWNER,ORGANIZATION_ID) VALUES ('AF','Dimuthu','1');
INSERT INTO PROJECT (PROJECT_NAME,OWNER,ORGANIZATION_ID) VALUES ('JSE','Chris','2');
  
INSERT INTO VERSION (VERSION,PROJECT_ID) VALUES ("1.0.0","1");
INSERT INTO VERSION (VERSION,PROJECT_ID) VALUES ("1.0.1","2");
INSERT INTO VERSION (VERSION,PROJECT_ID) VALUES ("1.2.0","3");
INSERT INTO VERSION (VERSION,PROJECT_ID) VALUES ("1.0.0","4");
INSERT INTO VERSION (VERSION,PROJECT_ID) VALUES ("1.1.0","5");
INSERT INTO VERSION (VERSION,PROJECT_ID) VALUES ("Windows-XP","6");
INSERT INTO VERSION (VERSION,PROJECT_ID) VALUES ("Windows-SERVER","7");
  
INSERT INTO ISSUE (PKEY,PROJECT_ID,SUMMARY,DESCRIPTION,ISSUE_TYPE,PRIORITY,OWNER,STATUS,ASSIGNEE,VERSION_ID,CREATED_TIME,UPDATED_TIME,SEVERITY) VALUES ("UES-1","1","summary1","description1","BUG","HIGHEST","dimuthu","OPEN","punnadi","1",NOW(),NOW(),"BLOCKER");
INSERT INTO ISSUE (PKEY,PROJECT_ID,SUMMARY,DESCRIPTION,ISSUE_TYPE,PRIORITY,OWNER,STATUS,ASSIGNEE,VERSION_ID,CREATED_TIME,UPDATED_TIME,SEVERITY) VALUES ("AF-1","2","summary2","description2","BUG","HIGH","evanthika","RESOLVED","asanka","2",NOW(),NOW(),"CRITICAL");
INSERT INTO ISSUE (PKEY,PROJECT_ID,SUMMARY,DESCRIPTION,ISSUE_TYPE,PRIORITY,OWNER,STATUS,ASSIGNEE,VERSION_ID,CREATED_TIME,UPDATED_TIME,SEVERITY) VALUES ("JSE-1","3","summary3","description3","QUERY","NORMAL","ashansa","INPROGRESS","nuwan","3",NOW(),NOW(),"TRIVIAL");
INSERT INTO ISSUE (PKEY,PROJECT_ID,SUMMARY,DESCRIPTION,ISSUE_TYPE,PRIORITY,OWNER,STATUS,ASSIGNEE,VERSION_ID,CREATED_TIME,UPDATED_TIME,SEVERITY) VALUES ("UES-2","2","summary4","description4","FEATURE","LOW","punnadi","OPEN","manisha","1",NOW(),NOW(),"MINOR");
	
INSERT INTO COMMENT (COMMENT,CREATED_TIME,UPDATED_TIME,COMMENT_CREATOR,ISSUE_ID) VALUES ("comment1",NOW(),NOW(),"manisha","1");
INSERT INTO COMMENT (COMMENT,CREATED_TIME,UPDATED_TIME,COMMENT_CREATOR,ISSUE_ID) VALUES ("comment2",NOW(),NOW(),"ashansa","3");
INSERT INTO COMMENT (COMMENT,CREATED_TIME,UPDATED_TIME,COMMENT_CREATOR,ISSUE_ID) VALUES ("comment3",NOW(),NOW(),"evanthika","2");
INSERT INTO COMMENT (COMMENT,CREATED_TIME,UPDATED_TIME,COMMENT_CREATOR,ISSUE_ID) VALUES ("comment4",NOW(),NOW(),"asanka","4");
INSERT INTO COMMENT (COMMENT,CREATED_TIME,UPDATED_TIME,COMMENT_CREATOR,ISSUE_ID) VALUES ("comment5",NOW(),NOW(),"manisha","1");
INSERT INTO COMMENT (COMMENT,CREATED_TIME,UPDATED_TIME,COMMENT_CREATOR,ISSUE_ID) VALUES ("comment6",NOW(),NOW(),"nuwan","6");

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
