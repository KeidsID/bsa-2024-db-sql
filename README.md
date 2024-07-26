# BSA 2024 DB SQL

Binary Studio Academy "Javascript: Database and SQL" Lecture Homework.

- [Data Definiton](sql/data.sql)
- [Queries](sql/queries/)

## Entity Relationship Diagram

NOTE: Every tables has `created_at` and `updated_at` columns.

```mermaid
---
title: Simple Entity Relationship Diagram
---
erDiagram
  users }o--|{ favorite_movies : has
  favorite_movies }|--o{ movies : contains

  movies }|--|| persons : director
  movies }|--|| countries : production
  movies }|--o| files : poster
  movies }|--|{ movie_characters : has
  movie_characters }|--|{ characters : contains
  movies }|--|{ movie_genres : has
  movie_genres }|--|{ genres : contains

  persons }|--|| countries : home
  persons }|--o| files : photo
  persons }o--|{ person_images: has
  person_images }|--o{ files : contains

  characters }o--|{ character_actors : has
  character_actors }|--|{ persons : contains
```

```mermaid
---
title: Detailed Entity Relationship Diagram
---
erDiagram
  users }o--|{ favorite_movies : has
  favorite_movies }|--o{ movies : contains

  movies }|--|| persons : director
  movies }|--|| countries : production
  movies }|--o| files : poster
  movies }|--|{ movie_characters : has
  movie_characters }|--|{ characters : contains
  movies }|--|{ movie_genres : has
  movie_genres }|--|{ genres : contains

  persons }|--|| countries : home
  persons }|--o| files : photo
  persons }o--|{ person_images: has
  person_images }|--o{ files : contains

  characters }o--|{ character_actors : has
  character_actors }|--|{ persons : contains

  users {
    VARCHAR(50) id PK
    VARCHAR(50) username UK "NOT NULL"
    TEXT first_name "NOT NULL"
    TEXT last_name "NOT NULL"
    TEXT email UK "NOT NULL"
    TEXT password "NOT NULL"
  }
  favorite_movies {
    VARCHAR(50) id PK
    VARCHAR(50) user_id FK "users ON DELETE CASCADE"
    VARCHAR(50) movie_id FK "movies ON DELETE CASCADE"
  }

  files {
    VARCHAR(50) id PK
    TEXT file_name "NOT NULL"
    TEXT mime_type "NOT NULL"
    TEXT source_url "NOT NULL"
  }

  movies {
    VARCHAR(50) id PK
    TEXT title "NOT NULL"
    TEXT description
    INTEGER budget
    DATE release_date
    INTEGER duration
    VARCHAR(50) director FK "persons ON DELETE RESTRICT, NOT NULL"
    VARCHAR(50) production FK "countries ON DELETE RESTRICT, NOT NULL"
    VARCHAR(50) poster FK "files ON DELETE SET NULL"
  }
  movie_characters {
    VARCHAR(50) id PK
    VARCHAR(50) movie_id FK "movies ON DELETE CASCADE, NOT NULL"
    VARCHAR(50) character_id FK,UK "characters ON DELETE CASCADE, NOT NULL"
  }
  movie_genres {
    VARCHAR(50) id PK
    VARCHAR(50) movie_id FK "movies ON DELETE CASCADE, NOT NULL"
    VARCHAR(50) genre_id FK,UK "genres ON DELETE CASCADE, NOT NULL"
  }

  enum_cr[CHARACTER_ROLE_enum] {
    _ leading
    _ supporting
    _ background
  }
  characters {
    VARCHAR(50) id PK
    TEXT name "NOT NULL"
    TEXT description
    CHARACTER_ROLE_enum role "NOT NULL"
  }
  characters }|..|| enum_cr : has
  character_actors {
    VARCHAR(50) id PK
    VARCHAR(50) character_id FK "characters ON DELETE CASCADE, NOT NULL"
    VARCHAR(50) person_id FK "persons ON DELETE CASCADE, NOT NULL"
  }

  enum_g[GENDER_enum] {
    _ male
    _ female
    _ other
  }
  persons {
    VARCHAR(50) id PK
    TEXT first_name "NOT NULL"
    TEXT last_name "NOT NULL"
    TEXT biography
    DATE birth_date
    GENDER_enum gender "NOT NULL"
    VARCHAR(50) nationality FK "countries ON DELETE RESTRICT, NOT NULL"
    VARCHAR(50) photo FK "files ON DELETE SET NULL"
  }
  persons }|..|| enum_g : has
  person_images {
    VARCHAR(50) id PK
    VARCHAR(50) person_id FK "persons ON DELETE CASCADE, NOT NULL"
    VARCHAR(50) file_id FK "files ON DELETE CASCADE, NOT NULL"
  }

  countries {
    VARCHAR(50) id PK
    VARCHAR(3) iso_3166_1 UK "NOT NULL"
    TEXT name "NOT NULL"
  }

  genres {
    VARCHAR(50) id PK
    TEXT name "NOT NULL"
  }
```
