/*
 * List of actors along with the total budget of the movies 
 * they have appeared in.
 */
SELECT p.id,
  p.first_name,
  p.last_name,
  SUM(m.budget) AS total_movies_budget
FROM persons AS p
  JOIN character_actors AS ca ON ca.person_id = p.id
  JOIN movie_characters AS mc ON mc.character_id = ca.character_id
  JOIN movies AS m ON m.id = mc.movie_id
GROUP BY p.id;