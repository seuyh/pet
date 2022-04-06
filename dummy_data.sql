USE game_server_bd;

INSERT INTO `countries` VALUES (1, 'Russia'), (2, 'Ukraine'), (3, 'USA'), (4, 'Germany'), (5, 'France'), (6, 'Grece'), (7, 'China');

INSERT INTO `weapons` VALUES (1,'AK-47'),(2,'M4A1'),(3,'P250'),(4,'Magnum'),(5,'Dragunov'),(6,'Desert Eagle'),(7,'Grenade M1');

INSERT INTO `users` VALUES (1,'sint','berta63@example.net','27051dc83e7853373018aafc53cd84ab4f605cc5','55.92.178.34','\0'),(2,'deleniti','bridie91@example.net','3530a6ba0ae9ca728b26aa8ec8795155f5eb8be3','142.152.170.224','\0'),(3,'ea','rspinka@example.com','71ee0b25add7382c6377d34c91e9ca212ef0433d','24.16.169.59','\0'),(4,'sit','reuben62@example.org','71bf9adfc9e472340ef2d0cef6773cb575ad226a','50.123.7.121',''),(5,'non','roger.marks@example.org','0e4695b68848f2875c79ee92ed0d4cb325219bd1','26.161.34.221','\0'),(6,'laudantium','kayla37@example.net','946ceda0e099f11b206c9967fb500a25f5448b7d','233.29.93.209',''),(7,'unde','gussie.jacobson@example.org','ee1fe8d8121fe9708c9b9d5ea15615e530257eae','236.134.96.149',''),(8,'quos','roob.wiley@example.com','09d3d96d99b5b11a9ff82e16828916b4944b4f03','158.214.165.151','\0'),(9,'nemo','ckovacek@example.net','dad75d4ebdc6f2669f95c1cbd758ee3939235e6e','222.116.164.174','\0'),(10,'iste','kjakubowski@example.org','0059cbeac7f1047ff464001b410da5bd0e1f5a3b','177.230.218.166','');

INSERT INTO `profiles` VALUES (1,'2018-01-01 00:19:41','2020-11-25 22:17:48','2005-06-15','http://lorempixel.com/640/480/','http://macejkovicokon.biz/',1),(2,'2005-01-20 06:01:38','1975-11-17 17:04:53','1999-09-08','http://lorempixel.com/640/480/','http://www.herzog.info/',2),(3,'1999-01-02 20:23:04','1996-04-18 12:52:42','2007-06-08','http://lorempixel.com/640/480/','http://www.stehr.com/',3),(4,'1989-11-29 07:51:16','1999-04-09 20:34:31','2011-07-16','http://lorempixel.com/640/480/','http://www.tremblay.net/',4),(5,'1991-03-07 12:24:54','2019-09-26 16:09:52','1976-05-08','http://lorempixel.com/640/480/','http://kessler.com/',5),(6,'1995-08-16 00:53:32','2004-12-31 22:15:08','1980-11-11','http://lorempixel.com/640/480/','http://www.dubuque.com/',6),(7,'1987-05-25 17:29:21','1984-09-11 04:34:51','1999-02-15','http://lorempixel.com/640/480/','http://www.mcclure.com/',7),(8,'2009-10-28 23:25:41','1993-04-17 03:31:03','1982-10-30','http://lorempixel.com/640/480/','http://www.hilll.net/',1),(9,'1985-06-01 07:45:10','1976-07-09 04:22:13','1993-03-16','http://lorempixel.com/640/480/','http://dubuque.com/',2),(10,'2002-11-07 10:17:15','2015-04-04 00:42:10','2011-02-25','http://lorempixel.com/640/480/','http://heidenreichernser.com/',3);

INSERT INTO `user_stats` VALUES (1,3,1,9,54),(2,0,0,6,93),(3,3,1,2,39),(4,1,0,10,45),(5,0,1,4,39),(6,1,1,2,71),(7,0,1,1,71),(8,1,0,0,93),(9,0,1,9,78),(10,1,1,4,14);

INSERT INTO `products` VALUES (1,'harum','Dolorum nihil magni est voluptatibus occaecati dolores laborum sapiente. Reiciendis reiciendis qui et sit odit voluptatem. Et veniam in omnis expedita.',217.00),(2,'assumenda','Quis qui ipsam enim eius aliquid earum. Dolorem iusto ut dolores nisi. Et eius cumque aut asperiores rerum. Natus minima iure et minus ea similique sed.',9999.99),(3,'eius','Vero non consequuntur fuga et pariatur tenetur officiis rem. Laudantium et doloremque quos at. Consectetur reiciendis cum ex ut totam.',5286.00),(4,'sit','Necessitatibus quo quibusdam veniam cumque eos. Laboriosam officia doloribus est autem. Sit provident amet officia quod aliquam distinctio.',9999.99),(5,'laboriosam','Magnam consequatur non omnis quae architecto sit. Consectetur ut ex animi cupiditate et. Laudantium eum id est. Aut nobis culpa quia quam.',203.00),(6,'modi','Rerum itaque rerum enim in. Ullam illo libero fugit occaecati aut. Pariatur et ut aut et autem consequatur.',9999.99),(7,'quo','Voluptatem rem ut aut totam delectus ipsum velit esse. Sapiente qui ut ex neque repudiandae fuga. Quo cum et odit sint quia.',9999.99),(8,'quia','Enim sed nemo modi. Dignissimos ab libero quas quia nihil voluptas. Quod eius sint et. Debitis magnam et est id quaerat omnis perspiciatis et.',815.00),(9,'impedit','Commodi et aut voluptas sit. In est dolor et dolorum voluptates optio. Repellendus eum laboriosam sed aliquid vitae.',1218.00),(10,'autem','Maiores molestias ad asperiores repudiandae sunt accusantium est. Quis nam et et. Illum laudantium at corrupti. Quidem nihil aut voluptas quam.',854.00);

INSERT INTO `priveleges_list` VALUES (1,'provident'),(2,'consequuntur'),(3,'est'),(4,'commodi'),(5,'et'),(6,'sed'),(7,'ex'),(8,'impedit'),(9,'est'),(10,'modi');

INSERT INTO `kill_list` VALUES (6,1,4,923,'2006-11-04 05:53:30'),(8,3,1,920,'2004-11-15 01:39:41'),(4,5,5,579,'1982-02-10 19:14:25'),(1,6,4,815,'1995-10-26 09:03:30'),(10,7,1,855,'1974-09-24 03:33:32'),(1,9,1,18,'1981-02-03 19:00:16'),(1,10,1,918,'1990-12-07 07:39:48');

INSERT INTO `teams` VALUES (1,8,7),(2,5,1),(3,2,9),(4,6,3);

INSERT INTO `death_list` VALUES (1,6,4,923,'2006-11-04 05:53:30'),(3,8,1,920,'2004-11-15 01:39:41'),(5,4,5,579,'1982-02-10 19:14:25'),(6,1,4,815,'1995-10-26 09:03:30'),(7,10,1,855,'1974-09-24 03:33:32'),(9,1,1,18,'1981-02-03 19:00:16'),(10,1,1,918,'1990-12-07 07:39:48');

INSERT INTO `user_privelege` VALUES (1,8,'1997-04-15 08:30:00'),(2,6,'1970-02-04 17:06:43'),(3,1,'1981-04-06 21:35:51'),(4,1,'1975-02-04 03:41:21'),(5,1,'2011-01-10 07:22:16'),(6,4,'2016-12-17 06:15:31'),(7,6,'1986-09-18 01:22:13'),(8,2,'2019-03-16 11:22:18'),(9,5,'2000-07-30 17:41:07'),(10,1,'2013-01-02 02:14:02');

INSERT INTO `purchase_history` VALUES (9,1,'harum',217.00,'1987-08-07 02:22:03'),(5,2,'assumenda',9999.99,'1997-08-18 06:36:37'),(3,3,'eius',5286.00,'2005-12-14 13:17:00'),(8,7,'quo',9999.99,'2016-07-21 21:33:04'),(5,6,'modi',9999.99,'1982-10-10 17:34:47');

INSERT INTO `cart` VALUES (1,'f8b879408ddf1d9f582eae6942e8a582',1),(2,'1053e8cb65d1fc1e20c9c1c78d789cf4',2),(3,'c04556b54a86ff5a24891eff1c3aebc2',3),(4,'6e508f190380d3047af0b731185d864d',4),(5,'4e7c8a08e8d39f5f973ca84aa767d865',5),(6,'c27be451151c913b59b6b074d904a034',6),(7,'ffaedf04f35bf6a5a4356021642a0dd0',7),(8,'fbac2112452dcbc52d1f17cbd77b4a87',8),(9,'455e94b9413f39efd350511ca4b91a04',9),(10,'014cc0809f20cd063f421ed3a541e459',10);
