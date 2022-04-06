USE game_server_bd;

-- Поиск забаненных пользователей, процедура принимает количество строк, которое нужно отобразить --

DROP PROCEDURE IF EXISTS banned_users;
DELIMITER //
CREATE PROCEDURE banned_users(IN how_many INT)
BEGIN

	SELECT users.id, 
	  users.nickname, 
	  profiles.profile_pic, 
	  profiles.last_online,
	  profiles.page_url AS 'user_url'
	  FROM users LEFT OUTER JOIN profiles ON id = user_id 
	 WHERE is_banned = '1'
	 ORDER BY
		 id;

END //
DELIMITER ;
--
CALL banned_users(20);
--


-- Поиск пользователей по стране, процедура принимает название страны --

DROP PROCEDURE IF EXISTS user_from_country_find;
DELIMITER //
CREATE PROCEDURE user_from_country_find(IN from_country VARCHAR(100))
BEGIN

	SELECT users.id, 
	  users.nickname, 
	  profiles.profile_pic, 
	  profiles.last_online,
	  profiles.page_url AS 'user_url'
	 FROM users LEFT OUTER JOIN profiles ON id = user_id
	 WHERE profiles.country_id = (SELECT id FROM countries WHERE country = from_country)
	 GROUP BY
		 id;

END //
DELIMITER ;
-- 
#CALL user_from_country_find('Russia');
-- 


-- Поиск пользователей по никнейму, процедура принимает как часть ника, так и его целиком --

DROP PROCEDURE IF EXISTS user_find;
DELIMITER //
CREATE PROCEDURE user_find(IN nick varchar(30))
BEGIN

SELECT users.id, 
	  users.nickname, 
	  profiles.profile_pic, 
	  profiles.last_online,
	  profiles.page_url AS 'user_url',
	  user_stats.kills,
	  user_stats.deaths,
	  user_stats.lvl
	 FROM users 
	 LEFT OUTER JOIN profiles ON id = user_id
	 LEFT OUTER JOIN user_stats ON id = user_stats.user_id
	 WHERE nickname LIKE concat('%', `nick`, '%')
	 GROUP BY
		 id;


END //
DELIMITER ;
-- 
#CALL user_find('sin');
-- 

-- Запись нового пользователя в БД --

DROP PROCEDURE IF EXISTS add_user;
DELIMITER //
CREATE PROCEDURE add_user(  `nickname` varchar(30),
  							`email` varchar(100),
  							`password_hash` varchar(255))
BEGIN
	DECLARE _rollback BOOL DEFAULT 0;
	DECLARE err_code VARCHAR(100);
	DECLARE error VARCHAR(100);
	DECLARE last_user_id INT;

	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
		BEGIN
			SET _rollback = 1;
			GET STACKED DIAGNOSTICS CONDITION 1
				err_code = RETURNED_SQLSTATE, error = MESSAGE_TEXT;
			SET @user_add_status := concat('Ошибка, операция не завершена. Код ошибки: ', err_code, '. Текст: ', error);
		END;

	START TRANSACTION;
	INSERT INTO users
		(`nickname`, `email`, `password_hash`)
	VALUES
		(`nickname`, `email`, `password_hash`);

	SELECT last_insert_id() INTO @last_user_id;

	INSERT INTO profiles
		(user_id)
	VALUES
		(@last_user_id);

	IF _rollback THEN
		ROLLBACK;
	ELSE
		SET @user_add_status := 'OK';
		COMMIT;
	END IF;

END //
DELIMITER ;

-- 
/*
CALL add_user('gfherwr',
			  'wetfy@example.com',
			  MD5('numwsas21'));
SELECT @user_add_status;
*/
-- 

