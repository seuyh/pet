DROP DATABASE IF EXISTS game_server_bd;
CREATE DATABASE game_server_bd;
USE game_server_bd;

-- таблица пользователей --
CREATE TABLE IF NOT EXISTS users (
  `id` SERIAL,
  `nickname` varchar(30) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `password_hash` varchar(255) DEFAULT NULL,
  `reg_ip` varchar(45) DEFAULT NULL,
  `is_banned` bit(1) DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
  
);

-- таблица со странами --
CREATE TABLE IF NOT EXISTS countries (
	`id` SERIAL PRIMARY KEY,
	`country` VARCHAR(200) UNIQUE NOT NULL
	
);

-- таблица с оружием --
CREATE TABLE IF NOT EXISTS weapons (
  `id` SERIAL,
  `name` varchar(30),
  PRIMARY KEY (`id`)
  
);

-- таблица с основной информацией о пользователях --
CREATE TABLE IF NOT EXISTS profiles (
  `user_id` bigint(20) unsigned NOT NULL,
  `reg_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `last_online` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `birthday` date DEFAULT NULL,
  `profile_pic` varchar(150) DEFAULT NULL,
  `page_url` varchar(150) DEFAULT NULL,
  `country_id` bigint(20) unsigned,
  KEY `user_id` (`user_id`),
  KEY `country_id` (`country_id`),
  FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
  		ON DELETE RESTRICT
		ON UPDATE CASCADE,
  FOREIGN KEY (`country_id`) REFERENCES `countries` (id)
  		ON DELETE SET NULL
		ON UPDATE CASCADE

);

-- таблица со списком убийств определенного пользователя --
CREATE TABLE IF NOT EXISTS kill_list (
  `user_id` bigint(20) unsigned,
  `killed_user` bigint(20) unsigned,
  `weapon` bigint(20) unsigned,
  `distance` int(10) unsigned DEFAULT NULL,
  `kill_date` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  KEY `user_id` (`user_id`),
  KEY `killed_user` (`killed_user`),
  KEY `weapon` (`weapon`),
  FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
    	ON DELETE SET NULL
		ON UPDATE CASCADE,
  FOREIGN KEY (`killed_user`) REFERENCES `users` (`id`)
    	ON DELETE SET NULL
		ON UPDATE CASCADE,
  FOREIGN KEY (`weapon`) REFERENCES `weapons` (`id`)
  		ON DELETE SET NULL
		ON UPDATE CASCADE
		
);

-- таблица со списком смертей определенного пользователя --
CREATE TABLE IF NOT EXISTS death_list (
  `user_id` bigint(20) unsigned,
  `killer` bigint(20) unsigned,
  `weapon` bigint(20) unsigned,
  `distance` int(10) unsigned DEFAULT NULL,
  `death_date` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  KEY `user_id` (`user_id`),
  KEY `killer` (`killer`),
  KEY `weapon` (`weapon`),
  FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
  		ON DELETE SET NULL
		ON UPDATE CASCADE,
  FOREIGN KEY (`killer`) REFERENCES `users` (`id`)
  		ON DELETE SET NULL
		ON UPDATE CASCADE,
  FOREIGN KEY (`weapon`) REFERENCES `weapons` (`id`)
  		ON DELETE SET NULL
		ON UPDATE CASCADE

);

-- таблица со статистикой пользователя --
CREATE TABLE IF NOT EXISTS user_stats (
  `user_id` bigint(20) unsigned,
  `kills` int(11) unsigned DEFAULT 0,
  `deaths` int(11) unsigned DEFAULT 0,
  `lvl` int(11) unsigned DEFAULT 0,
  `EXP` int(11) unsigned DEFAULT 0,
  KEY `user_id` (`user_id`),
  FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
    	ON DELETE SET NULL
		ON UPDATE CASCADE
);

-- список существующих привелегий --
CREATE TABLE IF NOT EXISTS priveleges_list (
  `id` SERIAL,
  `name` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`)

);

-- привелегия и дата ее окончания у пользователя --
CREATE TABLE IF NOT EXISTS user_privelege (
  `user_id` bigint(20) unsigned,
  `id` bigint(20) unsigned NOT NULL,
  `privelege_end_date` datetime DEFAULT NULL,
  KEY `user_id` (`user_id`),
  KEY `id` (`id`),
  FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
    	ON DELETE SET NULL
		ON UPDATE CASCADE,
  FOREIGN KEY (`id`) REFERENCES `priveleges_list` (`id`)
  		ON DELETE RESTRICT
		ON UPDATE CASCADE

);

-- таблица хранящиая команды и тех кто в них состоит(пользователя всего 2 потому-что сервер подразумевает игру максимум вдвоем)  --
CREATE TABLE IF NOT EXISTS teams (
  `id` SERIAL,
  `user1` bigint(20) UNSIGNED,
  `user2` bigint(20) UNSIGNED,
  KEY `user1` (`user1`),
  KEY `user2` (`user2`),
  FOREIGN KEY (`user1`) REFERENCES `users` (`id`)
    	ON DELETE SET NULL
		ON UPDATE CASCADE,
  FOREIGN KEY (`user2`) REFERENCES `users` (`id`)
    	ON DELETE SET NULL
		ON UPDATE CASCADE
);

-- таблица игровых товаров --
CREATE TABLE IF NOT EXISTS products ( 
  `id` SERIAL,
  `name` varchar(30) NOT NULL,
  `description` varchar(250) NOT NULL,
  `price` decimal(6,2) NOT NULL,
  PRIMARY KEY (`id`)

);

-- корзина --
CREATE TABLE IF NOT EXISTS cart (
  `user_id` bigint(20) unsigned,
  `hash` char(32) NOT NULL,
  `product_id` bigint(20) unsigned,
  KEY `user_id` (`user_id`),
  KEY `product_id` (`product_id`),
  FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
    	ON DELETE SET NULL
		ON UPDATE CASCADE,
  FOREIGN KEY (`product_id`) REFERENCES `products` (`id`)
    	ON DELETE SET NULL
		ON UPDATE CASCADE

);

-- история покупок --
CREATE TABLE IF NOT EXISTS purchase_history ( 
  `user_id` bigint(20) unsigned,
  `product_id` bigint(20) unsigned,
  `name` varchar(100) NOT NULL,
  `price` decimal(6,2) NOT NULL,
  `pucrchase_date` timestamp NOT NULL DEFAULT current_timestamp(),
  KEY `user_id` (`user_id`),
  KEY `product_id` (`product_id`),
  FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
    	ON DELETE SET NULL
		ON UPDATE CASCADE,
  FOREIGN KEY (`product_id`) REFERENCES `products` (`id`)
    	ON DELETE SET NULL
		ON UPDATE CASCADE

);

