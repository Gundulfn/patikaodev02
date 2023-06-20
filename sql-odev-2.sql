-- 1. Table Creations --------------------------------------------------------------------------------------------------------------------------------------------------------------------

CREATE TABLE users(
	user_id SERIAL PRIMARY KEY,
	username VARCHAR(50) UNIQUE NOT NULL,
	email VARCHAR(100) UNIQUE NOT NULL,
	creation_date TIMESTAMP DEFAULT LOCALTIMESTAMP(0),
	is_active BOOLEAN
);

CREATE TABLE categories(
	category_id SERIAL PRIMARY KEY,
	name VARCHAR(50) UNIQUE NOT NULL,
	creation_date TIMESTAMP DEFAULT LOCALTIMESTAMP(0)
);

CREATE TABLE posts(
	post_id SERIAL PRIMARY KEY,
	user_id INTEGER NOT NULL, FOREIGN KEY (user_id) REFERENCES users(user_id),
	category_id INTEGER, FOREIGN KEY (category_id) REFERENCES categories(category_id),
	title VARCHAR(50) NOT NULL,
	content VARCHAR(50) NOT NULL,
	view_count INTEGER DEFAULT 0,
	creation_date TIMESTAMP DEFAULT LOCALTIMESTAMP(0),
	is_published BOOLEAN
);

CREATE TABLE comments(
	comment_id SERIAL PRIMARY KEY,
	post_id INTEGER NOT NULL, FOREIGN KEY (post_id) REFERENCES posts(post_id),
	user_id INTEGER, FOREIGN KEY (user_id) REFERENCES users(user_id),
	comment TEXT NOT NULL,
	creation_date TIMESTAMP DEFAULT LOCALTIMESTAMP(0),
	is_confirmed BOOLEAN
);

-- Extra: REPLACE TRIGGER for null insertion made on purpose like VALUES(null)
CREATE OR REPLACE FUNCTION set_default_creation_date()
  RETURNS TRIGGER AS $$
BEGIN
  NEW.creation_date := COALESCE(NEW.creation_date, LOCALTIMESTAMP(0));
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER replace_null_date_with_default
  BEFORE INSERT ON users // also added for categories, comments and posts by applying this trigger for these tables
  FOR EACH ROW
  WHEN (NEW.creation_date IS NULL)
  EXECUTE FUNCTION set_default_creation_date();


-- 2. Data Insertions --------------------------------------------------------------------------------------------------------------------------------------------------------------------

--- Users
insert into users (username, email, creation_date, is_active) values ('ssmeed0', 'gbricklebank0@cmu.edu', '2019-05-23 08:32:50', false);
insert into users (username, email, creation_date, is_active) values ('gstruan1', 'dvane1@wix.com', '2014-05-26 01:04:10', false);
insert into users (username, email, creation_date, is_active) values ('vrubinlicht2', 'gcarvill2@smugmug.com', '2015-03-05 13:35:41', false);
insert into users (username, email, creation_date, is_active) values ('dearley3', 'vcostanza3@auda.org.au', null, false);
insert into users (username, email, creation_date, is_active) values ('ijurisch4', 'nilyukhov4@alibaba.com', '2019-10-18 09:01:29', false);
insert into users (username, email, creation_date, is_active) values ('cbaggaley5', 'gcunio5@yellowbook.com', null, true);
insert into users (username, email, creation_date, is_active) values ('hsleeman6', 'dkleinplatz6@unc.edu', '2019-01-01 16:23:39', false);
insert into users (username, email, creation_date, is_active) values ('gruzek7', 'gkarolewski7@icq.com', null, true);
insert into users (username, email, creation_date, is_active) values ('brizzotto8', 'lpenburton8@list-manage.com', '2022-03-30 07:56:30', true);
insert into users (username, email, creation_date, is_active) values ('tgarfath9', 'dmichiel9@netvibes.com', '2015-09-17 20:35:37', false);

--- Categories
insert into categories (name, creation_date) values ('Funny', null);
insert into categories (name, creation_date) values ('News', null);
insert into categories (name, creation_date) values ('Opinion', '2015-03-14 19:16:03');
insert into categories (name, creation_date) values ('Sports', '2023-03-16 04:21:47');

--- Posts
insert into posts (user_id, category_id, title, content, view_count, creation_date, is_published) values (1, 4, 'Hunting of the President, The', 'Endless Night Sky', 64, '2017-12-23 20:54:10', true);
insert into posts (user_id, category_id, title, content, view_count, creation_date, is_published) values (6, 4, 'Kremlin Letter', 'Shattered Illusions', 72, '2016-07-17 13:28:22', true);
insert into posts (user_id, category_id, title, content, view_count, creation_date, is_published) values (1, 3, 'Helen', 'Shattered Dreams', 7, '2016-05-15 23:54:29', true);
insert into posts (user_id, category_id, title, content, view_count, creation_date, is_published) values (7, 1, 'Stick It', 'Fading Memories', 54, '2023-04-08 21:23:06', false);
insert into posts (user_id, category_id, title, content, view_count, creation_date, is_published) values (3, 3, 'Drawn Together Movie: The Movie!', 'Broken Dreams', 60, '2016-07-11 06:52:30', false);
insert into posts (user_id, category_id, title, content, view_count, creation_date, is_published) values (10, 2, 'Ouija', 'Fading Memories', 49, '2017-03-16 10:53:54', true);
insert into posts (user_id, category_id, title, content, view_count, creation_date, is_published) values (9, 2, 'Theory of Everything, The', 'Love Lost Hope', 91, '2021-06-18 19:59:37', true);
insert into posts (user_id, category_id, title, content, view_count, creation_date, is_published) values (10, 3, 'Nas: Time Is Illmatic', 'Lonely Hearts Club', 29, '2019-05-29 23:16:26', true);
insert into posts (user_id, category_id, title, content, view_count, creation_date, is_published) values (2, 2, 'Spanish Apartment,', 'Shattered Illusions', 29, null, null);
insert into posts (user_id, category_id, title, content, view_count, creation_date, is_published) values (10, 4, 'Blood from the Mummy''s Tomb', 'Echoes of You', 17, '2016-06-10 12:06:20', true);
insert into posts (user_id, category_id, title, content, view_count, creation_date, is_published) values (6, 4, 'Breakfast of Terror', 'Whispers in Wind', 21, '2022-03-23 10:16:34', true);
insert into posts (user_id, category_id, title, content, view_count, creation_date, is_published) values (10, 4, 'Sweet Sixteen', 'Whispers in Dark', 36, '2021-09-16 10:13:39', true);
insert into posts (user_id, category_id, title, content, view_count, creation_date, is_published) values (5, 3, 'Heimat - A Chronicle of Germany', 'Fading Echoes', 76, null, null);
insert into posts (user_id, category_id, title, content, view_count, creation_date, is_published) values (9, 4, 'Matchmaker, The', 'Fading Sunlight', 100, '2022-11-06 17:44:17', false);
insert into posts (user_id, category_id, title, content, view_count, creation_date, is_published) values (4, 2, 'Heroes for Sale', 'Broken Promises', 92, '2014-07-26 03:20:29', false);
insert into posts (user_id, category_id, title, content, view_count, creation_date, is_published) values (6, 1, 'Marmaduke', 'Echoes of You', 65, null, null);
insert into posts (user_id, category_id, title, content, view_count, creation_date, is_published) values (5, 4, 'Talking Picture', 'Bittersweet Goodbye', 63, '2020-02-21 23:36:31', true);
insert into posts (user_id, category_id, title, content, view_count, creation_date, is_published) values (1, 2, 'Tales of Manhattan', 'Fading Memories', 5, '2021-09-13 03:24:44', true);
insert into posts (user_id, category_id, title, content, view_count, creation_date, is_published) values (10, 2, 'Creature', 'Endless Raindrops', 38, null, null);
insert into posts (user_id, category_id, title, content, view_count, creation_date, is_published) values (2, 4, 'Wicker Man, The', 'Endless Raindrops', 91, '2018-11-11 22:50:10', true);
insert into posts (user_id, category_id, title, content, view_count, creation_date, is_published) values (6, 4, 'Holiday, The', 'Whispers in Dark', 10, '2018-05-24 07:04:45', false);
insert into posts (user_id, category_id, title, content, view_count, creation_date, is_published) values (3, 1, 'Prince & Me, The', 'Echoes of You', 60, '2021-09-28 06:57:44', true);
insert into posts (user_id, category_id, title, content, view_count, creation_date, is_published) values (6, 3, 'Open Windows', 'Silent Whispers', 19, '2017-06-25 16:43:31', true);
insert into posts (user_id, category_id, title, content, view_count, creation_date, is_published) values (7, 4, 'One Trick Pony', 'Whispers in Dark', 22, '2016-07-29 14:30:13', true);
insert into posts (user_id, category_id, title, content, view_count, creation_date, is_published) values (1, 1, 'It''s a Gift', 'Echoes of Love', 94, '2015-12-20 19:09:09', false);
insert into posts (user_id, category_id, title, content, view_count, creation_date, is_published) values (3, 3, 'Lola (Twinky) (London Affair)', 'Endless Night Sky', 78, '2018-05-02 19:22:43', false);
insert into posts (user_id, category_id, title, content, view_count, creation_date, is_published) values (7, 1, 'Hard Way, The', 'Whispers in Wind', 84, null, null);
insert into posts (user_id, category_id, title, content, view_count, creation_date, is_published) values (2, 1, 'Dopamine', 'Broken Dreams', 45, '2016-02-10 21:43:57', false);
insert into posts (user_id, category_id, title, content, view_count, creation_date, is_published) values (6, 4, 'Assassination', 'Fading Memories', 55, '2019-10-27 01:26:36', false);
insert into posts (user_id, category_id, title, content, view_count, creation_date, is_published) values (7, 3, 'Woman of Affairs, A', 'Broken Promises', 64, '2022-05-29 01:00:57', false);
insert into posts (user_id, category_id, title, content, view_count, creation_date, is_published) values (1, 1, 'Buried Alive', 'Silent Whispers', 94, '2021-10-11 18:51:11', true);
insert into posts (user_id, category_id, title, content, view_count, creation_date, is_published) values (2, 1, 'Empire of Dreams', 'Silent Whispers', 5, '2016-10-29 08:25:10', false);
insert into posts (user_id, category_id, title, content, view_count, creation_date, is_published) values (3, 4, 'Entertaining Angels', 'Echoes of You', 8, '2020-10-29 09:22:14', true);
insert into posts (user_id, category_id, title, content, view_count, creation_date, is_published) values (7, 1, 'Final Conflict', 'Shattered Illusions', 82, '2019-01-16 16:04:10', false);
insert into posts (user_id, category_id, title, content, view_count, creation_date, is_published) values (6, 1, 'Arsenic and Old Lace', 'Broken Promises', 63, '2018-09-27 09:29:38', false);
insert into posts (user_id, category_id, title, content, view_count, creation_date, is_published) values (4, 1, 'Gleason', 'Silent Tears Fall', 31, '2015-08-27 07:49:47', true);
insert into posts (user_id, category_id, title, content, view_count, creation_date, is_published) values (10, 4, 'Rasen', 'Lonely Hearts Club', 77, null, null);
insert into posts (user_id, category_id, title, content, view_count, creation_date, is_published) values (2, 4, 'Smashing Pumpkins: Vieuphoria', 'Broken Promises', 91, '2018-03-29 15:56:08', false);
insert into posts (user_id, category_id, title, content, view_count, creation_date, is_published) values (4, 1, 'Iceberg, L', 'Echoes of Love', 71, '2020-09-04 16:27:24', true);
insert into posts (user_id, category_id, title, content, view_count, creation_date, is_published) values (2, 1, 'Fighting Prince of Donegal', 'Fading Echoes', 31, '2019-02-17 03:07:38', false);
insert into posts (user_id, category_id, title, content, view_count, creation_date, is_published) values (2, 1, 'Stand Up and Fight', 'Shattered Dreams', 39, null, null);
insert into posts (user_id, category_id, title, content, view_count, creation_date, is_published) values (6, 2, 'Rendez-vous d''Anna', 'Broken Dreams', 64, '2014-10-31 13:05:55', false);
insert into posts (user_id, category_id, title, content, view_count, creation_date, is_published) values (7, 2, 'Best Little Texas', 'Broken Dreams', 10, '2017-03-13 20:03:05', false);
insert into posts (user_id, category_id, title, content, view_count, creation_date, is_published) values (7, 4, 'Love on the Run', 'Dancing Shadows', 87, '2018-07-10 00:40:36', true);
insert into posts (user_id, category_id, title, content, view_count, creation_date, is_published) values (10, 4, 'Bruce Almighty', 'Silent Whispers', 12, '2016-08-22 22:34:32', false);
insert into posts (user_id, category_id, title, content, view_count, creation_date, is_published) values (5, 3, 'Human Nature', 'Echoes of You', 18, '2017-05-10 14:02:42', true);
insert into posts (user_id, category_id, title, content, view_count, creation_date, is_published) values (6, 1, 'Wrong Cops', 'Broken Promises', 41, '2020-09-27 11:03:27', true);
insert into posts (user_id, category_id, title, content, view_count, creation_date, is_published) values (9, 3, 'Sands of Iwo Jima', 'Shattered Dreams', 1, null, null);
insert into posts (user_id, category_id, title, content, view_count, creation_date, is_published) values (6, 2, 'Rendezvous in Paris', 'Whispers in Wind', 46, '2018-12-26 22:55:53', true);
insert into posts (user_id, category_id, title, content, view_count, creation_date, is_published) values (3, 2, 'Mon Paradis - Der Winterpalast', 'Fading Memories', 28, '2017-08-02 02:37:01', false);

--- Comments
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (42, 1, 'I loved this movie!', '2020-03-19 11:46:51', false);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (26, 4, 'It was okay', '2018-08-10 03:54:12', false);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (17, 4, 'but not my favorite.', '2018-06-04 06:36:32', false);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (39, 10, 'I didn''t really like this one.', '2021-07-30 07:52:26', false);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (6, 5, 'This movie was terrible!', '2016-06-16 15:52:40', true);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (32, null, 'One of the best movies I''ve ever seen!', null, null);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (14, 9, 'I wouldn''t recommend this movie.', '2017-02-24 19:31:09', false);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (6, 9, 'It was good', '2018-08-20 11:18:08', false);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (27, 2, 'but not great.', '2021-07-16 12:23:33', false);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (44, 6, 'This movie was so boring.', '2018-12-20 11:47:23', true);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (40, 9, 'I laughed so much during this movie!', '2018-04-18 07:17:17', true);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (44, 1, 'I cried during this movie.', '2021-05-15 02:18:32', true);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (19, 4, 'I loved this movie!', '2017-02-03 08:39:04', false);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (11, 5, 'It was okay', '2023-04-05 05:00:16', true);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (12, 10, 'but not my favorite.', '2017-01-29 00:30:39', false);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (4, 6, 'I didn''t really like this one.', '2017-01-28 23:04:20', true);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (40, null, 'This movie was terrible!', null, null);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (3, 8, 'One of the best movies I''ve ever seen!', '2020-07-08 18:34:12', true);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (2, 5, 'I wouldn''t recommend this movie.', '2016-06-28 02:54:57', true);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (45, 8, 'It was good', '2018-08-27 02:10:14', true);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (16, null, 'but not great.', null, null);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (38, 7, 'This movie was so boring.', '2022-10-28 16:51:55', false);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (21, null, 'I laughed so much during this movie!', null, null);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (16, 5, 'I cried during this movie.', '2022-05-28 13:44:55', false);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (30, 1, 'I loved this movie!', '2017-07-27 23:09:28', false);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (14, 3, 'It was okay', '2014-08-20 18:23:54', true);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (30, 1, 'but not my favorite.', '2017-06-05 00:36:00', false);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (16, null, 'I didn''t really like this one.', null, null);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (16, null, 'This movie was terrible!', null, null);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (50, 7, 'One of the best movies I''ve ever seen!', '2017-07-14 05:43:01', true);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (46, 6, 'I wouldn''t recommend this movie.', '2021-05-04 22:50:08', false);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (27, 7, 'It was good', '2017-10-04 10:24:07', true);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (19, 7, 'but not great.', '2022-08-22 21:33:36', true);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (43, 5, 'This movie was so boring.', '2014-08-30 15:12:23', false);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (48, null, 'I laughed so much during this movie!', null, null);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (23, 7, 'I cried during this movie.', '2021-05-18 09:47:58', true);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (49, 9, 'I loved this movie!', '2020-07-06 04:22:55', false);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (45, 3, 'It was okay', '2022-11-21 20:24:39', false);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (12, 9, 'but not my favorite.', '2020-11-08 15:01:24', true);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (46, 3, 'I didn''t really like this one.', '2017-12-22 16:41:46', true);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (47, 7, 'This movie was terrible!', '2016-03-02 23:06:55', true);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (47, 7, 'One of the best movies I''ve ever seen!', '2021-11-08 23:32:17', false);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (42, 8, 'I wouldn''t recommend this movie.', '2021-01-22 19:49:43', false);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (28, 1, 'It was good', '2020-05-19 11:51:32', true);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (47, 5, 'but not great.', '2021-08-19 23:30:49', true);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (31, 4, 'This movie was so boring.', '2022-08-11 07:23:15', true);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (42, 8, 'I laughed so much during this movie!', '2017-02-18 16:34:58', true);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (36, null, 'I cried during this movie.', null, null);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (8, null, 'I loved this movie!', null, null);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (27, 5, 'It was okay', '2020-11-28 05:44:31', false);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (45, 8, 'but not my favorite.', '2015-05-13 04:28:33', false);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (22, null, 'I didn''t really like this one.', null, null);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (39, 4, 'This movie was terrible!', '2023-01-08 20:45:30', false);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (11, 7, 'One of the best movies I''ve ever seen!', '2019-10-22 13:23:49', true);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (28, 4, 'I wouldn''t recommend this movie.', '2020-10-20 03:46:22', false);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (45, 10, 'It was good', '2014-08-07 20:24:17', false);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (24, null, 'but not great.', null, null);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (18, 7, 'This movie was so boring.', '2019-03-04 10:23:58', true);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (30, 5, 'I laughed so much during this movie!', '2023-01-01 19:48:42', false);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (22, 2, 'I cried during this movie.', '2021-05-07 05:12:28', true);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (3, 8, 'I loved this movie!', '2019-01-26 08:29:05', true);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (40, 2, 'It was okay', '2017-04-29 09:39:11', false);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (48, 8, 'but not my favorite.', '2020-02-07 16:42:16', false);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (4, 4, 'I didn''t really like this one.', '2023-01-31 05:16:43', true);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (16, null, 'This movie was terrible!', null, null);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (15, 6, 'One of the best movies I''ve ever seen!', '2018-12-30 22:06:19', true);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (2, 5, 'I wouldn''t recommend this movie.', '2017-11-07 08:13:47', true);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (16, null, 'It was good', null, null);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (23, 9, 'but not great.', '2020-03-12 08:23:29', true);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (36, 7, 'This movie was so boring.', '2021-01-18 06:11:47', true);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (7, 6, 'I laughed so much during this movie!', '2015-02-08 20:35:18', false);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (44, 9, 'I cried during this movie.', '2023-01-25 21:11:49', true);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (41, 5, 'I loved this movie!', '2014-10-25 23:27:01', true);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (23, 3, 'It was okay', '2019-07-01 14:12:21', false);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (8, 7, 'but not my favorite.', '2016-07-27 20:41:55', false);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (17, 5, 'I didn''t really like this one.', '2021-10-31 13:38:05', true);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (46, 4, 'This movie was terrible!', '2018-05-21 00:35:43', true);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (26, 5, 'One of the best movies I''ve ever seen!', '2019-03-22 05:35:44', true);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (21, 7, 'I wouldn''t recommend this movie.', '2019-01-11 11:36:55', false);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (50, 3, 'It was good', '2019-12-13 23:46:31', true);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (38, 10, 'but not great.', '2015-10-15 23:28:43', true);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (42, 1, 'This movie was so boring.', '2015-05-23 21:40:13', false);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (44, 3, 'I laughed so much during this movie!', '2021-02-24 17:18:41', true);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (43, 3, 'I cried during this movie.', '2015-02-27 07:11:14', false);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (39, 9, 'I loved this movie!', '2023-02-06 18:30:14', false);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (50, 5, 'It was okay', '2015-05-28 11:26:52', false);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (29, 2, 'but not my favorite.', '2015-08-26 17:50:25', true);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (39, 8, 'I didn''t really like this one.', '2018-10-27 12:46:45', false);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (32, null, 'This movie was terrible!', null, null);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (49, 7, 'One of the best movies I''ve ever seen!', '2023-05-10 09:04:44', false);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (13, 10, 'I wouldn''t recommend this movie.', '2016-02-12 14:36:23', true);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (4, null, 'It was good', null, null);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (16, null, 'but not great.', null, null);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (2, null, 'This movie was so boring.', null, null);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (7, 6, 'I laughed so much during this movie!', '2023-05-05 20:58:10', true);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (6, 8, 'I cried during this movie.', '2021-06-29 16:48:26', true);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (42, 7, 'I loved this movie!', '2019-02-17 00:39:45', false);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (7, 2, 'It was okay', '2016-07-30 12:17:21', false);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (30, 5, 'but not my favorite.', '2018-08-28 01:58:59', true);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (19, 4, 'I didn''t really like this one.', '2020-08-20 01:50:48', true);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (17, 4, 'This movie was terrible!', '2015-05-02 03:55:34', false);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (7, 1, 'One of the best movies I''ve ever seen!', '2018-04-28 07:09:34', true);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (50, 6, 'I wouldn''t recommend this movie.', '2021-02-24 15:43:10', false);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (40, 1, 'It was good', '2016-10-11 06:49:58', false);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (12, 7, 'but not great.', '2022-08-23 20:53:21', false);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (15, 3, 'This movie was so boring.', '2022-04-16 21:31:29', true);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (35, 9, 'I laughed so much during this movie!', '2020-05-11 09:06:57', true);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (17, 4, 'I cried during this movie.', '2019-03-30 14:56:08', false);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (7, 3, 'I loved this movie!', '2016-06-19 04:52:37', true);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (46, 4, 'It was okay', '2023-01-09 13:47:01', true);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (27, 3, 'but not my favorite.', '2022-12-27 08:34:08', false);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (43, 10, 'I didn''t really like this one.', '2022-07-11 06:25:59', true);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (35, 5, 'This movie was terrible!', '2015-04-29 01:19:39', true);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (49, 1, 'One of the best movies I''ve ever seen!', '2018-06-17 07:10:12', false);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (11, null, 'I wouldn''t recommend this movie.', null, null);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (18, 2, 'It was good', '2015-05-16 22:28:04', false);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (36, null, 'but not great.', null, null);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (40, null, 'This movie was so boring.', null, null);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (50, 4, 'I laughed so much during this movie!', '2023-06-04 21:41:05', false);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (31, 2, 'I cried during this movie.', '2019-05-21 00:04:12', true);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (12, 5, 'I loved this movie!', '2020-09-15 16:50:57', true);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (9, 6, 'It was okay', '2018-07-26 04:43:57', false);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (22, 10, 'but not my favorite.', '2022-06-29 02:35:15', true);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (10, null, 'I didn''t really like this one.', null, null);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (40, null, 'This movie was terrible!', null, null);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (1, 10, 'One of the best movies I''ve ever seen!', '2014-12-12 03:41:26', true);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (24, null, 'I wouldn''t recommend this movie.', null, null);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (9, 5, 'It was good', '2014-11-12 02:22:33', true);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (32, 5, 'but not great.', '2017-03-09 01:49:24', true);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (45, 9, 'This movie was so boring.', '2022-01-24 10:45:13', false);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (46, 5, 'I laughed so much during this movie!', '2017-03-08 00:38:32', true);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (33, 10, 'I cried during this movie.', '2017-05-28 06:23:30', true);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (20, 6, 'I loved this movie!', '2020-10-10 15:56:39', true);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (11, null, 'It was okay', null, null);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (22, null, 'but not my favorite.', null, null);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (7, 8, 'I didn''t really like this one.', '2022-10-12 20:24:39', false);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (50, 1, 'This movie was terrible!', '2014-10-04 00:47:57', true);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (3, 1, 'One of the best movies I''ve ever seen!', '2017-06-26 03:25:06', true);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (35, 5, 'I wouldn''t recommend this movie.', '2023-02-21 01:54:31', false);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (11, 10, 'It was good', '2021-07-07 10:43:24', false);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (33, null, 'but not great.', null, null);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (32, null, 'This movie was so boring.', null, null);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (26, 6, 'I laughed so much during this movie!', '2019-05-29 11:09:14', true);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (11, 2, 'I cried during this movie.', '2017-02-28 10:36:48', true);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (17, 7, 'I loved this movie!', '2022-11-15 22:55:27', true);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (25, 4, 'It was okay', '2016-06-12 00:00:30', false);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (44, null, 'but not my favorite.', null, null);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (42, 1, 'I didn''t really like this one.', '2023-03-06 09:39:18', true);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (8, 5, 'This movie was terrible!', '2019-08-19 12:38:10', false);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (9, 10, 'One of the best movies I''ve ever seen!', '2018-07-13 23:36:15', false);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (14, 8, 'I wouldn''t recommend this movie.', '2018-05-12 06:28:58', true);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (22, 2, 'It was good', '2021-11-19 12:32:15', false);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (45, null, 'but not great.', null, null);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (33, null, 'This movie was so boring.', null, null);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (24, 1, 'I laughed so much during this movie!', '2018-03-04 19:57:09', true);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (12, 3, 'I cried during this movie.', '2021-06-30 17:14:58', false);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (43, 4, 'I loved this movie!', '2022-03-24 09:44:58', false);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (5, 3, 'It was okay', '2022-01-13 12:15:35', false);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (32, 2, 'but not my favorite.', '2018-01-24 06:40:29', true);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (22, null, 'I didn''t really like this one.', null, null);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (35, 10, 'This movie was terrible!', '2017-03-02 02:08:39', false);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (26, 9, 'One of the best movies I''ve ever seen!', '2018-03-24 01:13:24', true);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (11, 5, 'I wouldn''t recommend this movie.', '2018-11-24 10:40:11', false);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (33, 5, 'It was good', '2015-03-20 08:52:07', true);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (43, null, 'but not great.', null, null);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (43, null, 'This movie was so boring.', null, null);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (2, null, 'I laughed so much during this movie!', null, null);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (20, 5, 'I cried during this movie.', '2016-03-09 17:35:31', false);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (27, 6, 'I loved this movie!', '2017-10-04 23:53:19', false);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (9, 9, 'It was okay', '2021-10-18 21:58:24', false);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (7, 9, 'but not my favorite.', '2020-04-20 20:03:32', true);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (48, 4, 'I didn''t really like this one.', '2019-12-05 08:44:54', false);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (47, 2, 'This movie was terrible!', '2016-09-13 17:50:21', true);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (27, null, 'One of the best movies I''ve ever seen!', null, null);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (8, 4, 'I wouldn''t recommend this movie.', '2022-03-07 08:24:58', false);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (42, 7, 'It was good', '2022-06-09 12:01:58', true);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (49, null, 'but not great.', null, null);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (30, null, 'This movie was so boring.', null, null);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (19, 8, 'I laughed so much during this movie!', '2023-06-13 08:54:19', true);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (13, 7, 'I cried during this movie.', '2015-05-27 10:41:03', false);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (48, null, 'I loved this movie!', null, null);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (10, 4, 'It was okay', '2021-12-19 18:02:13', false);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (17, 4, 'but not my favorite.', '2019-11-19 04:20:09', false);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (21, 3, 'I didn''t really like this one.', '2018-12-05 20:56:05', true);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (20, 3, 'This movie was terrible!', '2016-07-03 22:13:26', true);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (26, 4, 'One of the best movies I''ve ever seen!', '2020-05-13 07:11:38', false);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (30, 6, 'I wouldn''t recommend this movie.', '2020-05-09 00:06:50', false);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (32, 8, 'It was good', '2016-03-14 17:46:26', false);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (21, 5, 'but not great.', '2021-09-04 02:12:28', false);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (43, 8, 'This movie was so boring.', '2019-04-09 03:48:45', true);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (26, 1, 'I laughed so much during this movie!', '2017-05-26 15:45:56', true);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (38, 7, 'I cried during this movie.', '2020-01-15 03:00:22', true);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (49, 2, 'I loved this movie!', '2021-05-28 01:35:41', false);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (9, 4, 'It was okay', '2015-02-01 07:34:24', true);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (43, 9, 'but not my favorite.', '2016-08-17 02:18:00', false);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (42, 6, 'I didn''t really like this one.', '2021-11-11 12:36:56', false);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (25, 6, 'This movie was terrible!', '2022-10-08 18:18:22', true);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (6, null, 'One of the best movies I''ve ever seen!', null, null);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (10, null, 'I wouldn''t recommend this movie.', null, null);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (22, 10, 'It was good', '2018-05-13 06:54:22', true);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (34, null, 'but not great.', null, null);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (8, 6, 'This movie was so boring.', '2018-06-02 12:38:16', true);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (50, 5, 'I laughed so much during this movie!', '2014-12-29 01:37:53', true);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (12, 6, 'I cried during this movie.', '2022-07-21 06:52:19', true);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (19, 8, 'I loved this movie!', '2020-09-02 02:34:15', false);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (16, null, 'It was okay', null, null);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (27, 8, 'but not my favorite.', '2020-07-14 11:03:33', false);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (49, null, 'I didn''t really like this one.', null, null);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (11, null, 'This movie was terrible!', null, null);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (32, 4, 'One of the best movies I''ve ever seen!', '2017-01-07 09:26:37', true);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (38, null, 'I wouldn''t recommend this movie.', null, null);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (4, null, 'It was good', null, null);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (18, 10, 'but not great.', '2016-04-06 14:43:29', false);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (30, 10, 'This movie was so boring.', '2022-11-07 18:02:20', true);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (48, 5, 'I laughed so much during this movie!', '2023-06-09 10:32:40', true);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (50, 5, 'I cried during this movie.', '2015-05-24 00:22:46', true);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (19, 4, 'I loved this movie!', '2017-04-16 15:00:42', false);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (18, null, 'It was okay', null, null);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (14, 9, 'but not my favorite.', '2020-04-22 03:23:45', true);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (10, null, 'I didn''t really like this one.', null, null);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (33, 9, 'This movie was terrible!', '2020-12-09 05:06:15', true);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (18, 8, 'One of the best movies I''ve ever seen!', '2016-03-06 19:12:47', true);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (4, 4, 'I wouldn''t recommend this movie.', '2014-08-18 06:12:25', false);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (31, 7, 'It was good', '2021-02-22 07:02:45', true);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (29, 6, 'but not great.', '2020-11-05 22:26:31', false);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (6, 9, 'This movie was so boring.', '2023-02-02 12:25:06', false);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (4, 6, 'I laughed so much during this movie!', '2020-05-20 09:19:36', false);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (36, null, 'I cried during this movie.', null, null);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (40, null, 'I loved this movie!', null, null);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (21, null, 'It was okay', null, null);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (14, 3, 'but not my favorite.', '2020-04-20 22:42:24', true);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (20, 10, 'I didn''t really like this one.', '2020-02-23 00:57:41', false);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (33, 8, 'This movie was terrible!', '2017-07-19 15:06:57', false);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (18, 7, 'One of the best movies I''ve ever seen!', '2016-09-09 05:47:13', true);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (47, 1, 'I wouldn''t recommend this movie.', '2018-06-02 14:01:24', false);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (34, 1, 'It was good', '2017-05-13 12:44:53', true);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (21, 7, 'but not great.', '2016-02-12 19:47:25', false);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (35, 5, 'This movie was so boring.', '2017-02-11 16:19:56', true);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (49, 6, 'I laughed so much during this movie!', '2015-08-08 01:24:42', false);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (44, 6, 'I cried during this movie.', '2019-02-02 23:48:30', true);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (10, 5, 'I loved this movie!', '2022-02-02 08:48:28', false);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (24, 2, 'It was okay', '2015-07-04 06:00:00', false);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (17, 5, 'but not my favorite.', '2021-09-12 14:31:24', true);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (35, null, 'I didn''t really like this one.', null, null);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (7, 6, 'This movie was terrible!', '2019-03-12 12:31:10', true);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (4, null, 'One of the best movies I''ve ever seen!', null, null);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (16, 9, 'I wouldn''t recommend this movie.', '2019-04-27 09:36:23', false);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (13, 8, 'It was good', '2020-12-13 20:53:46', true);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (41, 6, 'but not great.', '2017-05-26 15:25:10', false);
insert into comments (post_id, user_id, comment, creation_date, is_confirmed) values (47, null, 'This movie was so boring.', null, null);

-- 3. Questions ------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Question 1
SELECT 
	posts.title, 
	users.username, 
	categories.name
FROM 
	posts
	INNER JOIN users ON users.user_id = posts.user_id
	INNER JOIN categories ON categories.category_id = posts.category_id;
	
-- Question 2
SELECT 
	posts.title, 
	users.username, 
	categories.name,
	posts.creation_date
FROM 
	posts
	INNER JOIN users ON users.user_id = posts.user_id
	INNER JOIN categories ON categories.category_id = posts.category_id
ORDER BY posts.creation_date DESC
LIMIT 5;

-- Question 3
SELECT 
	posts.title, 
	COUNT(comments) AS comment_count
FROM 
	posts
	INNER JOIN comments ON comments.post_id = posts.post_id
GROUP BY posts.title;

-- Question 4
SELECT username, email FROM users;

-- Question 5
SELECT 
	posts.title, 
	comments.comment
FROM 
	posts
	INNER JOIN comments ON comments.post_id = posts.post_id
ORDER BY comments.creation_date DESC
LIMIT 10;

-- Question 6
SELECT * FROM posts
WHERE user_id = 1;

-- Question 7
SELECT 
	users.username, 
	COUNT(posts) AS post_count
FROM 
	posts
	INNER JOIN users ON users.user_id = posts.user_id
GROUP BY users.username;

-- Question 8
SELECT
	categories.name,
	COUNT(posts) AS post_count
FROM 
	posts
	INNER JOIN categories ON categories.category_id = posts.category_id
GROUP BY categories.name;

-- Question 9
SELECT name FROM categories
GROUP BY name
ORDER BY COUNT(name)
LIMIT 1;

-- Question 10
SELECT name FROM categories
WHERE category_id = (
	SELECT category_id FROM posts 
	ORDER BY view_count
	LIMIT 1);
	
-- Question 11
SELECT * FROM posts
WHERE post_id = (
	SELECT post_id FROM comments
	GROUP BY post_id
	ORDER BY COUNT(post_id) DESC
	LIMIT 1);

-- Question 12
SELECT users.username, users.email 
FROM 
	posts
	INNER JOIN users ON posts.user_id = users.user_id
WHERE post_id = 2;

-- Question 13
SELECT * FROM posts
WHERE title ILIKE '%the%' OR content ILIKE '%End%';

-- Question 14
SELECT comment FROM comments
WHERE user_id = 5
ORDER BY creation_date DESC
LIMIT 1;

-- Question 15
SELECT (SELECT COUNT(*) FROM comments) / COUNT(*) FROM posts;

-- Question 16
SELECT * FROM posts
WHERE creation_date >= NOW() - INTERVAL '30 DAYS'
ORDER BY creation_date DESC;

-- Question 17
SELECT * FROM comments
WHERE user_id = 4;

-- Question 18
SELECT * FROM posts
WHERE category_id = 2;

-- Question 19, NOTE: Lowest post count by category is 9, therefore this will show no input 
SELECT 
	categories.name
FROM 
	posts
	JOIN categories ON categories.category_id = posts.category_id
GROUP BY categories.name
HAVING COUNT(posts) < 5;

-- Question 20, NOTE: A user who has one post and one comment does not exist
SELECT users.* 
FROM 
	users 
	JOIN posts ON posts.user_id = users.user_id
	JOIN comments ON comments.user_id = users.user_id
GROUP BY users.user_id
HAVING COUNT(posts) = 1 AND COUNT(comments) = 1;

-- Question 21
SELECT users.*
FROM 
	users 
	JOIN comments ON comments.user_id = users.user_id
GROUP BY users.user_id
HAVING COUNT(comments.post_id) >= 2;

-- Question 22, NOTE: Same reason with Question 19
SELECT categories.*
FROM 
	categories 
	JOIN posts ON posts.category_id = categories.category_id
GROUP BY categories.category_id
HAVING COUNT(posts.post_id) >= 3;

-- Question 23
SELECT users.*
FROM 
	users 
	JOIN posts ON posts.user_id = users.user_id
GROUP BY users.user_id
HAVING COUNT(posts.post_id) > 5;

-- Question 24
(
	SELECT email FROM users
	JOIN posts ON posts.user_id = users.user_id
	GROUP BY users.user_id
	HAVING COUNT(posts.post_id) >= 1
)
UNION
(
	SELECT email FROM users
	JOIN comments ON comments.user_id = users.user_id
	GROUP BY users.user_id
	HAVING COUNT(comments.comment_id) >= 1
);

-- Question 25, NOTE: All users have posts and comments
(
	SELECT email FROM users
	JOIN posts ON posts.user_id = users.user_id
	GROUP BY users.user_id
	HAVING COUNT(posts.post_id) >= 1
)
EXCEPT
(
	SELECT email FROM users
	JOIN comments ON comments.user_id = users.user_id
	GROUP BY users.user_id
	HAVING COUNT(comments.comment_id) >= 1
);
