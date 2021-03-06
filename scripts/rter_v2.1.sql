-- MySQL rter v2
-- ===========
-- Run these commands to setup the MySQL databases for the rter v2 project

SET foreign_key_checks = 0;

DROP TABLE IF EXISTS Roles;
CREATE TABLE IF NOT EXISTS Roles (
	Title VARCHAR(64) NOT NULL,
	Permissions INT NOT NULL DEFAULT 0,

	PRIMARY KEY(Title)
);

DROP TABLE IF EXISTS Users;
CREATE TABLE `Users` (
	`Username` VARCHAR(64) NOT NULL,
	`Password` CHAR(128) NOT NULL,
	`Salt` CHAR(128) NOT NULL,
	`Role` VARCHAR(64) NOT NULL DEFAULT 'public',
	`TrustLevel` INT(11) NOT NULL DEFAULT '0',
	`CreateTime` DATETIME NOT NULL DEFAULT '0001-01-01 00:00:00',
	`Heading` DECIMAL(9,6) NOT NULL DEFAULT '0.000000',
	`Lat` DECIMAL(9,6) NOT NULL DEFAULT '0.000000',
	`Lng` DECIMAL(9,6) NOT NULL DEFAULT '0.000000',
	`UpdateTime` DATETIME NOT NULL DEFAULT '0001-01-01 00:00:00',
	`Status` VARCHAR(64) NOT NULL,
	`StatusTime` DATETIME NOT NULL DEFAULT '0001-01-01 00:00:00',
	PRIMARY KEY (`Username`),
	UNIQUE INDEX `Username` (`Username`),
	INDEX `Role` (`Role`),
	CONSTRAINT `users_ibfk_1` FOREIGN KEY (`Role`) REFERENCES `Roles` (`Title`) ON UPDATE CASCADE
)
COLLATE='utf8_general_ci'
ENGINE=InnoDB;

DROP TABLE IF EXISTS UserDirections;
CREATE TABLE IF NOT EXISTS UserDirections (
	Username VARCHAR(64) NOT NULL,
	LockUsername VARCHAR(64) NOT NULL,
	Command VARCHAR(64) NOT NULL DEFAULT "none",

	Heading DECIMAL(9, 6) NOT NULL DEFAULT 0,
	Lat DECIMAL(9, 6) NOT NULL DEFAULT 0,
	Lng DECIMAL(9, 6) NOT NULL DEFAULT 0,

	UpdateTime DATETIME NOT NULL,

	PRIMARY KEY(Username),
	FOREIGN KEY(Username) REFERENCES Users (Username) ON UPDATE CASCADE ON DELETE CASCADE
);

DROP TABLE IF EXISTS Items;
CREATE TABLE IF NOT EXISTS Items (
	ID INT NOT NULL AUTO_INCREMENT,
	Type VARCHAR(64) NOT NULL,
	Author VARCHAR(64) NOT NULL,

	ThumbnailURI VARCHAR(2048) NOT NULL DEFAULT "",
	ContentURI VARCHAR(2048) NOT NULL DEFAULT "",
	UploadURI VARCHAR(2048) NOT NULL DEFAULT "",

	ContentToken VARCHAR(2048) NOT NULL DEFAULT "",

	HasHeading TINYINT(1) NOT NULL DEFAULT 0,
	Heading DECIMAL(9, 6) NOT NULL DEFAULT 0,

	HasGeo TINYINT(1) NOT NULL DEFAULT 0,
	Lat DECIMAL(9, 6) NOT NULL DEFAULT 0,
	Lng DECIMAL(9, 6) NOT NULL DEFAULT 0,
	Radius DECIMAL(12, 6) NOT NULL DEFAULT 0,

	Live TINYINT(1) NOT	NULL DEFAULT 0,
	StartTime DATETIME NOT NULL,
	StopTime DATETIME NOT NULL,

	PRIMARY KEY(ID),
	FOREIGN KEY(Author) REFERENCES Users (Username) ON UPDATE CASCADE
);

DROP TABLE IF EXISTS ItemComments;
CREATE TABLE IF NOT EXISTS ItemComments (
	ID INT NOT NULL AUTO_INCREMENT,
	ItemID INT NOT NULL,
	Author VARCHAR(64) NOT NULL,

	Body TEXT NOT NULL,

	UpdateTime DATETIME NOT NULL,

	PRIMARY KEY(ID),
	FOREIGN KEY(ItemID) REFERENCES Items (ID) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY(Author) REFERENCES Users (Username) ON UPDATE CASCADE
);

DROP TABLE IF EXISTS Terms;
CREATE TABLE IF NOT EXISTS Terms (
	Term VARCHAR(64) NOT NULL,

	Automated TINYINT(1) NOT NULL DEFAULT 0,
	Author VARCHAR(64) NOT NULL,

	UpdateTime DATETIME NOT NULL,

	PRIMARY KEY(Term),
	FOREIGN KEY(Author) REFERENCES Users (Username) ON UPDATE CASCADE
);

DROP TABLE IF EXISTS TermRelationships;
CREATE TABLE IF NOT EXISTS TermRelationships (
	Term VARCHAR(64) NOT NULL,
	ItemID INT NOT NULL,
	PRIMARY KEY(Term, ItemID),
	FOREIGN KEY(Term) REFERENCES Terms (Term) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY(ItemID) REFERENCES Items (ID) ON UPDATE CASCADE ON DELETE CASCADE
);

DROP TABLE IF EXISTS TermRankings;
CREATE TABLE IF NOT EXISTS TermRankings (
	Term VARCHAR(64) NOT NULL,
	Ranking TEXT NOT NULL,
	
	UpdateTime DATETIME NOT NULL,

	PRIMARY KEY(Term),
	FOREIGN KEY(Term) REFERENCES Terms (Term) ON UPDATE CASCADE ON DELETE CASCADE
);

INSERT INTO Roles (Title, Permissions) VALUES ("public", 1), ("observer", 1), ("responder", 3), ("editor", 7), ("admin", 15);

INSERT INTO Users (Username, Password, Salt, Role, TrustLevel, CreateTime) VALUES 
	("anonymous", "a6269c1a0f852712b92066279e45aa25", "216394505bee32c7356b30a9c631ac9c", "public", 0, "2013-03-19 00:00:00"), 
	("admin", "", "", "admin", 0, "2013-03-19 00:00:00")
;
INSERT INTO UserDirections (Username, UpdateTime) VALUES 
	("anonymous", "2013-03-19 00:00:00"), 
	("admin", "2013-03-19 00:00:00")
;

INSERT INTO Terms (Term, Automated, Author, UpdateTime) VALUES 
	("all", 1, "admin", "2013-03-19 00:00:00"), 
	("test", 0, "anonymous", "2013-03-19 00:00:00")
;
INSERT INTO TermRankings (Term, Ranking, UpdateTime) VALUES 
	("all", "",  "2013-03-19 00:00:00"), 
	("test", "",  "2013-03-19 00:00:00")
;

INSERT INTO Users (Username, Password, Salt, Role, TrustLevel, CreateTime) VALUES
	("1e7f033bfc7b3625fa07c9a3b6b54d2c81eeff98", "", "", "observer", 0, "2013-03-19 00:00:00"),
	("fe7f033bfc7b3625fa06c9a3b6b54b2c81eeff98", "", "", "observer", 0, "2013-03-19 00:00:00"),
	("b6200c5cc15cfbddde2874c40952a7aa25a869dd", "", "", "observer", 0, "2013-03-19 00:00:00"),
	("852decd1fbc083cf6853e46feebb08622d653602", "", "", "observer", 0, "2013-03-19 00:00:00"),
	("e1830fcefc3f47647ffa08350348d7e34b142b0b", "", "", "observer", 0, "2013-03-19 00:00:00"),
	("48ad32292ff86b4148e0f754c2b9b55efad32d1e", "", "", "observer", 0, "2013-03-19 00:00:00"),
	("acb519f53a55d9dea06efbcc804eda79d305282e", "", "", "observer", 0, "2013-03-19 00:00:00"),
	("ze7f033bfc7b3625fa06c5a316b54b2c81eeff98", "", "", "observer", 0, "2013-03-19 00:00:00"),
	("t6200c5cc15cfbddde2875c41952a7aa25a869dd", "", "", "observer", 0, "2013-03-19 00:00:00"),
	("952decd1fbc083cf6853e56f1ebb08622d653602", "", "", "observer", 0, "2013-03-19 00:00:00"),
	("y1830fcefc3f47647ffa05351348d7e34b142b0b", "", "", "observer", 0, "2013-03-19 00:00:00"),
	("x8ad32292ff86b4148e0f55412b9b55efad32d1e", "", "", "observer", 0, "2013-03-19 00:00:00"),
	("qcb519f53a55d9dea06ef5cc104eda79d305282e", "", "", "observer", 0, "2013-03-19 00:00:00")
;
INSERT INTO UserDirections (Username, UpdateTime) VALUES 
	("1e7f033bfc7b3625fa07c9a3b6b54d2c81eeff98", "2013-03-19 00:00:00"), 
	("fe7f033bfc7b3625fa06c9a3b6b54b2c81eeff98", "2013-03-19 00:00:00"), 
	("b6200c5cc15cfbddde2874c40952a7aa25a869dd", "2013-03-19 00:00:00"), 
	("852decd1fbc083cf6853e46feebb08622d653602", "2013-03-19 00:00:00"), 
	("e1830fcefc3f47647ffa08350348d7e34b142b0b", "2013-03-19 00:00:00"), 
	("48ad32292ff86b4148e0f754c2b9b55efad32d1e", "2013-03-19 00:00:00"), 
	("acb519f53a55d9dea06efbcc804eda79d305282e", "2013-03-19 00:00:00"), 
	("ze7f033bfc7b3625fa06c5a316b54b2c81eeff98", "2013-03-19 00:00:00"), 
	("t6200c5cc15cfbddde2875c41952a7aa25a869dd", "2013-03-19 00:00:00"), 
	("952decd1fbc083cf6853e56f1ebb08622d653602", "2013-03-19 00:00:00"), 
	("y1830fcefc3f47647ffa05351348d7e34b142b0b", "2013-03-19 00:00:00"), 
	("x8ad32292ff86b4148e0f55412b9b55efad32d1e", "2013-03-19 00:00:00"), 
	("qcb519f53a55d9dea06ef5cc104eda79d305282e", "2013-03-19 00:00:00")
;

-- DROP TABLE IF EXISTS TaxonomyRankingsArchive;
-- CREATE TABLE IF NOT EXISTS TaxonomyRankingsArchive (
-- 	ID INT NOT NULL,
-- 	TaxonomyRankingID INT NOT NULL,
-- 	Ranking TEXT NOT NULL,

-- 	TaxonomyID INT NOT NULL,
	
-- 	UpdateTime DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

-- 	PRIMARY KEY(ID),
-- 	FOREIGN KEY(TaxonomyRankingID) REFERENCES TaxonomyRankings (ID) ON UPDATE CASCADE,
-- 	FOREIGN KEY(TaxonomyID) REFERENCES Taxonomy (ID) ON UPDATE CASCADE
-- );

SET foreign_key_checks = 1;