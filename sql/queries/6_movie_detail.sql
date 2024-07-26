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
WITH movies_info AS (
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
    ) AS director
  FROM movies AS m
    JOIN persons AS p ON p.id = m.director
    LEFT JOIN files AS f ON f.id = m.poster
),
movies_actors AS (
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
)
SELECT mi.id,
  mi.title,
  mi.release_date,
  mi.duration,
  mi.description,
  mi.poster,
  mi.director,
  ma.actors
FROM movies_info AS mi
  JOIN movies_actors AS ma ON ma.id = mi.id;