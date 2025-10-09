-- 1. Топ-10 фильмов по рейтингу (минимум 1000 оценок)
SELECT 
    m.title,
    ROUND(AVG(r.rating), 2) as avg_rating,
    COUNT(r.rating) as num_ratings
FROM movies m
JOIN ratings r ON m.movieId = r.movieId
GROUP BY m.movieId, m.title
HAVING COUNT(r.rating) >= 1000
ORDER BY avg_rating DESC
LIMIT 10;

-- 2. Самые популярные фильмы по количеству оценок
SELECT 
    m.title,
    COUNT(r.rating) as num_ratings,
    ROUND(AVG(r.rating), 2) as avg_rating
FROM movies m
JOIN ratings r ON m.movieId = r.movieId
GROUP BY m.movieId, m.title
ORDER BY num_ratings DESC
LIMIT 10;

-- 3. Распределение рейтингов по жанрам
WITH genre_expanded AS (
    SELECT 
        m.movieId,
        trim(unnest(string_to_array(m.genres, '|'))) as genre
    FROM movies m
)
SELECT 
    ge.genre,
    ROUND(AVG(r.rating), 2) as avg_rating,
    COUNT(r.rating) as num_ratings
FROM genre_expanded ge
JOIN ratings r ON ge.movieId = r.movieId
GROUP BY ge.genre
ORDER BY avg_rating DESC;

-- 4. Самые противоречивые фильмы (высокое стандартное отклонение)
SELECT 
    m.title,
    ROUND(AVG(r.rating), 2) as avg_rating,
    ROUND(STDDEV(r.rating), 2) as rating_stddev,
    COUNT(r.rating) as num_ratings
FROM movies m
JOIN ratings r ON m.movieId = r.movieId
GROUP BY m.movieId, m.title
HAVING COUNT(r.rating) >= 500
ORDER BY rating_stddev DESC
LIMIT 10;