CREATE TABLE `images` (
  `img_name` varchar(255) NOT NULL,
  `img_data` longblob NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
 
ALTER TABLE `images` ADD UNIQUE KEY `img_name` (`img_name`);