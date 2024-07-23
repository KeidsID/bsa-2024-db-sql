CREATE TABLE "user" (
  username VARCHAR(50) PRIMARY KEY,
  first_name TEXT NOT NULL,
  last_name TEXT,
  email TEXT NOT NULL UNIQUE,
  password TEXT NOT NULL
);
CREATE TABLE file (
  id VARCHAR(50) PRIMARY KEY,
  file_name TEXT NOT NULL,
  mime_type TEXT NOT NULL,
  source_url TEXT NOT NULL
);
CREATE TABLE movie (
  id VARCHAR(50) PRIMARY KEY,
  title TEXT NOT NULL,
  description TEXT DEFAULT 'No description',
  budget INTEGER DEFAULT 0,
  release_date DATE DEFAULT CURRENT_DATE,
  duration INTEGER DEFAULT 0
);
CREATE TYPE CHARACTER_ROLE AS ENUM ('leading', 'supporting', 'background');
CREATE TABLE "character" (
  id VARCHAR(50) PRIMARY KEY,
  name TEXT NOT NULL,
  description TEXT DEFAULT 'No description',
  role CHARACTER_ROLE DEFAULT 'background'
);
CREATE TYPE GENDER AS ENUM ('male', 'female', 'other');
CREATE TABLE person (
  id VARCHAR(50) PRIMARY KEY,
  first_name TEXT NOT NULL,
  last_name TEXT,
  biography TEXT DEFAULT 'No biography',
  birth_date DATE DEFAULT CURRENT_DATE,
  gender GENDER NOT NULL
);