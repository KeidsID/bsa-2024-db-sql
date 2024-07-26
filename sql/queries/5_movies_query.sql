/*
 * Select detailed information about movies that meet criteria below:
 * 
 * - Belong to a country with ID of 1.
 * - Were released in 2022 or later.
 * - Have a duration of more than 2 hours and 15 minutes.
 * - Include at least one of the genres: Action or Drama.
 *
 * Output columns:
 * - id
 * - title
 * - release_date
 * - duration
 * - description
 * - poster => {id, file_name, mime_type, source_url}
 * - director => {id, first_name, last_name}
 */
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
    p.last_name
  ) AS director
FROM movies AS m
  LEFT JOIN files AS f ON f.id = m.poster
  JOIN countries AS c ON c.id = m.production
  JOIN persons AS p ON p.id = m.director
  JOIN movie_genres AS mg ON mg.movie_id = m.id
  JOIN genres AS g ON g.id = mg.genre_id
WHERE 1 = 1
  AND c.id = '1'
  AND m.release_date >= '2022-01-01'
  AND MAKE_INTERVAL(secs => m.duration / 1000) > INTERVAL '2 hours 15 minutes'
  AND g.name IN ('Action', 'Drama')
GROUP BY m.id,
  f.id,
  p.id;