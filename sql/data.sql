-- Main entities
CREATE TABLE files (
  id VARCHAR(50) PRIMARY KEY,
  file_name TEXT NOT NULL,
  mime_type TEXT NOT NULL,
  source_url TEXT NOT NULL
);
CREATE TABLE countries (
  id VARCHAR(50) PRIMARY KEY,
  iso_3166_1 VARCHAR(3) UNIQUE NOT NULL,
  name TEXT NOT NULL
);
CREATE TYPE GENDER AS ENUM ('male', 'female', 'other');
CREATE TABLE persons (
  id VARCHAR(50) PRIMARY KEY,
  first_name TEXT NOT NULL,
  last_name TEXT,
  biography TEXT DEFAULT 'No biography',
  birth_date DATE DEFAULT CURRENT_DATE,
  gender GENDER NOT NULL,
  nationality VARCHAR(50) NOT NULL REFERENCES countries ON DELETE RESTRICT,
  photo VARCHAR(50) REFERENCES files ON DELETE
  SET NULL
);
CREATE TABLE movies (
  id VARCHAR(50) PRIMARY KEY,
  title TEXT NOT NULL,
  description TEXT DEFAULT 'No description',
  budget INTEGER DEFAULT 0,
  release_date DATE DEFAULT CURRENT_DATE,
  duration INTEGER DEFAULT 0,
  director VARCHAR(50) NOT NULL REFERENCES persons ON DELETE RESTRICT,
  production VARCHAR(50) NOT NULL REFERENCES countries ON DELETE RESTRICT,
  poster VARCHAR(50) REFERENCES files ON DELETE
  SET NULL
);
CREATE TYPE CHARACTER_ROLE AS ENUM ('leading', 'supporting', 'background');
CREATE TABLE characters (
  id VARCHAR(50) PRIMARY KEY,
  name TEXT NOT NULL,
  description TEXT DEFAULT 'No description',
  role CHARACTER_ROLE NOT NULL
);
CREATE TABLE users (
  id VARCHAR(50) PRIMARY KEY,
  username VARCHAR(50) NOT NULL,
  first_name TEXT NOT NULL,
  last_name TEXT NOT NULL,
  email TEXT NOT NULL,
  password TEXT NOT NULL,
  UNIQUE(username, email)
);
-- Relations
CREATE TABLE favorite_movies (
  id VARCHAR(50) PRIMARY KEY,
  user_id VARCHAR(50) NOT NULL REFERENCES users ON DELETE CASCADE,
  movie_id VARCHAR(50) NOT NULL REFERENCES movies ON DELETE CASCADE
);
CREATE TABLE movie_characters (
  id VARCHAR(50) PRIMARY KEY,
  movie_id VARCHAR(50) NOT NULL REFERENCES movies ON DELETE CASCADE,
  character_id VARCHAR(50) NOT NULL REFERENCES characters ON DELETE CASCADE,
  UNIQUE(character_id)
);
CREATE TABLE character_actors (
  id VARCHAR(50) PRIMARY KEY,
  character_id VARCHAR(50) NOT NULL REFERENCES characters ON DELETE CASCADE,
  person_id VARCHAR(50) NOT NULL REFERENCES persons ON DELETE CASCADE
);
CREATE TABLE person_images (
  id VARCHAR(50) PRIMARY KEY,
  person_id VARCHAR(50) NOT NULL REFERENCES persons ON DELETE CASCADE,
  file_id VARCHAR(50) NOT NULL REFERENCES files ON DELETE CASCADE
);