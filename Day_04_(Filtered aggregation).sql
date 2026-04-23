CREATE TABLE users (
    user_id INT PRIMARY KEY,
    username VARCHAR(50),
    country VARCHAR(50)
);

CREATE TABLE movies (
    movie_id INT PRIMARY KEY,
    title VARCHAR(100),
    genre VARCHAR(50)
);

CREATE TABLE watch_history (
    watch_id INT PRIMARY KEY,
    user_id INT,
    movie_id INT,
    watch_time_minutes INT,
    watch_date DATE
);

INSERT INTO users VALUES
(1, 'alex', 'South Africa'),
(2, 'maya', 'South Africa'),
(3, 'john', 'UK'),
(4, 'li', 'China');

INSERT INTO movies VALUES
(101, 'Inception', 'Sci-Fi'),
(102, 'Titanic', 'Romance'),
(103, 'Interstellar', 'Sci-Fi'),
(104, 'The Notebook', 'Romance');

INSERT INTO watch_history VALUES
(1, 1, 101, 120, '2026-04-01'),
(2, 1, 103, 90,  '2026-04-02'),
(3, 2, 102, 200, '2026-04-02'),
(4, 2, 104, 180, '2026-04-03'),
(5, 3, 101, 60,  '2026-04-03'),
(6, 3, 103, 300, '2026-04-04'),
(7, 4, 104, 150, '2026-04-04');

SELECT * FROM users;
SELECT * FROM movies;
SELECT * FROM watch_history;

-- total watch time is greater than the average total watch time per user
SELECT 
    username,
    total_watch_time
FROM (
    SELECT 
        u.username,
        SUM(w.watch_time_minutes) AS total_watch_time
    FROM users u
    JOIN watch_history w 
        ON u.user_id = w.user_id
    GROUP BY u.username
) user_totals
WHERE total_watch_time > (
    SELECT AVG(total_watch_time)
    FROM (
        SELECT 
            u.username,
            SUM(w.watch_time_minutes) AS total_watch_time
        FROM users u
        JOIN watch_history w 
            ON u.user_id = w.user_id
        GROUP BY u.username
    ) t
);


-- total watch time per movie > average movie watch time
SELECT 
    title,
    total_watch_time
FROM (
    SELECT 
        m.title,
        SUM(w.watch_time_minutes) AS total_watch_time
    FROM movies m
    JOIN watch_history w 
        ON m.movie_id = w.movie_id
    GROUP BY m.title
) movie_totals
WHERE total_watch_time > (
    SELECT AVG(total_watch_time)
    FROM (
        SELECT 
            m.movie_id,
            SUM(w.watch_time_minutes) AS total_watch_time
        FROM movies m
        JOIN watch_history w 
            ON m.movie_id = w.movie_id
        GROUP BY m.movie_id
    ) t
);


-- Find users whose watch time is in the top 25%
SELECT 
    username,
    total_watch_time
FROM (
    SELECT 
        u.username,
        SUM(w.watch_time_minutes) AS total_watch_time
    FROM users u
    JOIN watch_history w 
        ON u.user_id = w.user_id
    GROUP BY u.username
) user_totals
WHERE total_watch_time >= (
    SELECT MIN(top_users.total_watch_time)
    FROM (
        SELECT 
            SUM(w.watch_time_minutes) AS total_watch_time
        FROM users u
        JOIN watch_history w 
            ON u.user_id = w.user_id
        GROUP BY u.username
        ORDER BY total_watch_time DESC
        LIMIT (
            SELECT CEIL(COUNT(*) * 0.25)
            FROM users
        )
    ) top_users
);

