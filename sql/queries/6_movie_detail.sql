/*
 * Select detailed information about a movie with ID of 1.
 *
 * Output columns:
 * - id
 * - title
 * - release_date
 * - duration
 * - description
 * - poster => {id, file_name, mime_type, source_url}
 * - director => Person Object
 * - actors => Person Object[]
 * - genres => {id, name}[]
 *
 * * Person Object: {id, first_name, last_name, photo: {
 *     id, file_name, mime_type, source_url
 *     }
 *   }
 */
WITH movies_actors AS (
  SELECT m.id,
    JSON_AGG(
      JSON_BUILD_OBJECT(
        'id',
        p.id,
        'first_name',
        p.first_name,
        'last_name',
        p.last_name,
        'photo',
        CASE
          WHEN f.id = p.photo THEN JSON_BUILD_OBJECT(
            'id',
            f.id,
            'file_name',
            f.file_name,
            'mime_type',
            f.mime_type,
            'source_url',
            f.source_url
          )
          ELSE NULL
        END
      )
    ) AS actors
  FROM movies AS m
    JOIN movie_characters AS mc ON mc.movie_id = m.id
    JOIN character_actors AS ca ON ca.character_id = mc.character_id
    JOIN persons AS p ON p.id = ca.person_id
    LEFT JOIN files AS f ON f.id = p.photo
  GROUP BY m.id
),
movies_genres AS (
  SELECT m.id,
    JSON_AGG(JSON_BUILD_OBJECT('id', g.id, 'name', g.name)) AS genres
  FROM movies AS m
    JOIN movie_genres AS mg ON mg.movie_id = m.id
    JOIN genres AS g ON g.id = mg.genre_id
  GROUP BY m.id
)
SELECT m.id,
  m.title,
  m.release_date,
  m.duration,
  m.description,
  CASE
    WHEN f.id IS NULL THEN NULL
    ELSE JSON_BUILD_OBJECT(
      'id',
      f.id,
      'file_name',
      f.file_name,
      'mime_type',
      f.mime_type,
      'source_url',
      f.source_url
    )
  END AS poster,
  JSON_BUILD_OBJECT(
    'id',
    p.id,
    'first_name',
    p.first_name,
    'last_name',
    p.last_name,
    'photo',
    CASE
      WHEN f.id = p.photo THEN JSON_BUILD_OBJECT(
        'id',
        f.id,
        'file_name',
        f.file_name,
        'mime_type',
        f.mime_type,
        'source_url',
        f.source_url
      )
      ELSE NULL
    END
  ) AS director,
  ma.actors,
  mg.genres
FROM movies AS m
  JOIN persons AS p ON p.id = m.director
  LEFT JOIN files AS f ON f.id = m.poster
  JOIN movies_actors AS ma ON ma.id = m.id
  JOIN movies_genres AS mg ON mg.id = m.id
WHERE m.id = '1';