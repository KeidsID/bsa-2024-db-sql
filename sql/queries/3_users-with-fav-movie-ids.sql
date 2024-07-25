/*
 * Retrieve a list of all users along with their favorite movies as 
 * an array of identifiers
 */
SELECT u.id,
  u.username,
  JSON_AGG(fm.movie_id) AS favorite_movies
FROM users AS u
  LEFT JOIN favorite_movies AS fm ON fm.user_id = u.id
GROUP BY u.id;