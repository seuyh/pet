USE game_server_bd;

-- выводит инфорамацию о всех пользователях включая их статистику --
CREATE OR REPLACE VIEW user_profiles_view AS
 SELECT users.id, 
	  users.nickname, 
	  profiles.profile_pic, 
	  profiles.last_online,
	  profiles.page_url AS 'user_url',
	  user_stats.kills,
	  user_stats.deaths,
	  user_stats.lvl
	  FROM users 
	  LEFT OUTER JOIN profiles ON id = profiles.user_id
	  LEFT OUTER JOIN user_stats ON id = user_stats.user_id
	 ORDER BY
		 id;
-- 	 
#SELECT * FROM user_profiles
-- 
	 
-- выводит инфорамацию о командах и состоящих в них пользователях --
CREATE OR REPLACE VIEW teams_view AS
 SELECT teams.id AS team_id,
 	  teams.user1,
 	  u1.nickname AS user1_nickname,
 	  teams.user2,
 	  u2.nickname AS user2_nickname
 	  FROM teams 
 	  LEFT OUTER JOIN users u1 ON u1.id = teams.user1 
 	  LEFT OUTER JOIN users u2 ON u2.id = teams.user2
	  
	 ORDER BY
		 team_id;
		 
-- 
#SELECT * FROM teams_view
-- 
	 