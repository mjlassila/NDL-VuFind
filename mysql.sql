--
-- Table structure for table `comments`
--

CREATE TABLE `comments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL DEFAULT '0',
  `resource_id` int(11) NOT NULL DEFAULT '0',
  `comment` text NOT NULL,
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `resource_id` (`resource_id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 CHARSET=utf8 COLLATE=utf8_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `resource`
--

CREATE TABLE `resource` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `record_id` varchar(60) NOT NULL DEFAULT '',
  `title` varchar(200) NOT NULL DEFAULT '',
  `source` varchar(50) NOT NULL DEFAULT 'VuFind',
  `data` blob,
  `title_sort` varchar(60) NOT NULL DEFAULT '',
  `author_sort` varchar(60) NOT NULL DEFAULT '',
  `date_sort` varchar(60) NOT NULL DEFAULT '',
  `format_sort` varchar(60) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `record_id` (`record_id`)
) ENGINE=InnoDB AUTO_INCREMENT=58 CHARSET=utf8 COLLATE=utf8_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `resource_tags`
--

CREATE TABLE `resource_tags` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `resource_id` int(11) NOT NULL DEFAULT '0',
  `tag_id` int(11) NOT NULL DEFAULT '0',
  `list_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `posted` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `resource_id` (`resource_id`),
  KEY `tag_id` (`tag_id`),
  KEY `list_id` (`list_id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 CHARSET=utf8 COLLATE=utf8_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `search`
--

CREATE TABLE `search` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL DEFAULT '0',
  `session_id` varchar(128),
  `folder_id` int(11) DEFAULT NULL,
  `created` date NOT NULL DEFAULT '0000-00-00',
  `title` varchar(20) DEFAULT NULL,
  `saved` int(1) NOT NULL DEFAULT '0',
  `search_object` blob,
  `schedule` int(1) NOT NULL DEFAULT '0',
  `last_executed` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `schedule_base_url` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `folder_id` (`folder_id`),
  INDEX (`session_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 CHARSET=utf8 COLLATE=utf8_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tags`
--

CREATE TABLE `tags` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tag` varchar(25) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=55 CHARSET=utf8 COLLATE=utf8_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL DEFAULT '',
  `password` varchar(32) NOT NULL DEFAULT '',
  `firstname` varchar(50) NOT NULL DEFAULT '',
  `lastname` varchar(50) NOT NULL DEFAULT '',
  `email` varchar(250) NOT NULL DEFAULT '',
  `cat_username` varchar(50) DEFAULT NULL,
  `cat_password` varchar(50) DEFAULT NULL,
  `college` varchar(100) NOT NULL DEFAULT '',
  `major` varchar(100) NOT NULL DEFAULT '',
  `home_library` varchar(100) NOT NULL DEFAULT '',
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `language` varchar(30) NOT NULL DEFAULT '',
  `due_date_reminder` int(11) NOT NULL DEFAULT 0,
  `last_login` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  KEY `due_date_reminder` (`due_date_reminder`)
) ENGINE=InnoDB AUTO_INCREMENT=19 CHARSET=utf8 COLLATE=utf8_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user_list`
--

CREATE TABLE `user_list` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `title` varchar(200) NOT NULL,
  `description` text DEFAULT NULL,
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `public` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 CHARSET=utf8 COLLATE=utf8_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user_resource`
--

CREATE TABLE `user_resource` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `resource_id` int(11) NOT NULL,
  `list_id` int(11) DEFAULT NULL,
  `notes` text,
  `saved` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `resource_id` (`resource_id`),
  KEY `user_id` (`user_id`),
  KEY `list_id` (`list_id`),
  CONSTRAINT `user_resource_ibfk_2` FOREIGN KEY (`resource_id`) REFERENCES `resource` (`id`) ON DELETE CASCADE,
  CONSTRAINT `user_resource_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1 CHARSET=utf8 COLLATE=utf8_swedish_ci;

--
-- Table structure for table `session`
--

DROP TABLE IF EXISTS `session`;
CREATE TABLE `session` (
  `id` int(11) NOT NULL auto_increment,
  `session_id` varchar(128),
  `data` text,
  `last_used` int(12) NOT NULL default 0,
  `created` datetime NOT NULL default '0000-00-00 00:00:00',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `session_id` (`session_id`),
  INDEX (`last_used`)
) ENGINE=InnoDB AUTO_INCREMENT=1 CHARSET=utf8 COLLATE=utf8_swedish_ci;


--
-- Table structure for table `change_tracker`
--

DROP TABLE IF EXISTS `change_tracker`;
CREATE TABLE `change_tracker` (
  `core` varchar(30) NOT NULL,              -- solr core containing record
  `id` varchar(64) NOT NULL,                -- ID of record within core
  `first_indexed` datetime,                 -- first time added to index
  `last_indexed` datetime,                  -- last time changed in index
  `last_record_change` datetime,            -- last time original record was edited
  `deleted` datetime,                       -- time record was removed from index
  PRIMARY KEY (`core`, `id`),
  KEY `deleted_index` (`deleted`)
) ENGINE=InnoDB CHARSET=utf8 COLLATE=utf8_swedish_ci;


--
-- Table structure for table `oai_resumption`
--

DROP TABLE IF EXISTS `oai_resumption`;
CREATE TABLE `oai_resumption` (
  `id` int(11) NOT NULL auto_increment,
  `params` text,
  `expires` datetime NOT NULL default '0000-00-00 00:00:00',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 CHARSET=utf8 COLLATE=utf8_swedish_ci;


-- --------------------------------------------------------

--
-- Table structure for table `user_account`
--

CREATE TABLE `user_account` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `account_name` varchar(255) NOT NULL DEFAULT '',
  `description` varchar(255)  NOT NULL DEFAULT '',
  `cat_username` varchar(50)  NOT NULL DEFAULT '',
  `cat_password` varchar(50)  NOT NULL DEFAULT '',
  `home_library` varchar(100) NOT NULL DEFAULT '',
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `saved` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `user_account_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1 CHARSET=utf8 COLLATE=utf8_swedish_ci;


-- --------------------------------------------------------

--
-- Table structure for table `due_date_reminder`
--

CREATE TABLE `due_date_reminder` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `loan_id` varchar(255) NOT NULL,
  `due_date` datetime NOT NULL,
  `notification_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `due_date_reminder_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1 CHARSET=utf8 COLLATE=utf8_swedish_ci;


--
-- Constraints for dumped tables
--

--
-- Constraints for table `comments`
--
ALTER TABLE `comments`
  ADD CONSTRAINT `comments_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `comments_ibfk_2` FOREIGN KEY (`resource_id`) REFERENCES `resource` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `resource_tags`
--
ALTER TABLE `resource_tags`
  ADD CONSTRAINT `resource_tags_ibfk_14` FOREIGN KEY (`resource_id`) REFERENCES `resource` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `resource_tags_ibfk_15` FOREIGN KEY (`tag_id`) REFERENCES `tags` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `resource_tags_ibfk_16` FOREIGN KEY (`list_id`) REFERENCES `user_list` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `resource_tags_ibfk_17` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `user_list`
--
ALTER TABLE `user_list`
  ADD CONSTRAINT `user_list_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `user_resource`
--
ALTER TABLE `user_resource`
  ADD CONSTRAINT `user_resource_ibfk_3` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `user_resource_ibfk_4` FOREIGN KEY (`resource_id`) REFERENCES `resource` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `user_resource_ibfk_5` FOREIGN KEY (`list_id`) REFERENCES `user_list` (`id`) ON DELETE CASCADE;
