-- Таблица фильмов
CREATE TABLE IF NOT EXISTS movies (
    movieId INTEGER PRIMARY KEY,
    title TEXT NOT NULL,
    genres TEXT
);

-- Таблица рейтингов  
CREATE TABLE IF NOT EXISTS ratings (
    userId INTEGER,
    movieId INTEGER,
    rating REAL,
    timestamp INTEGER,
    PRIMARY KEY (userId, movieId),
    FOREIGN KEY (movieId) REFERENCES movies(movieId)
);

-- Таблица тегов
CREATE TABLE IF NOT EXISTS tags (
    userId INTEGER,
    movieId INTEGER, 
    tag TEXT,
    timestamp INTEGER,
    FOREIGN KEY (movieId) REFERENCES movies(movieId)
);

-- Таблица ссылок
CREATE TABLE IF NOT EXISTS links (
    movieId INTEGER PRIMARY KEY,
    imdbId TEXT,
    tmdbId TEXT,
    FOREIGN KEY (movieId) REFERENCES movies(movieId)
);