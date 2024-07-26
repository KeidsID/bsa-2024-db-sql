/*
 * Retrieve a list of all users along with their favorite movies as 
 * an array of identifiers
 */
SELECT u.id,
  u.username,
  CASE
    WHEN fm.user_id = u.id THEN JSON_AGG(fm.movie_id)
    ELSE NULL
  END AS favorite_movies
FROM users AS u
  LEFT JOIN favorite_movies AS fm ON fm.user_id = u.id
GROUP BY u.id,
  fm.user_id;