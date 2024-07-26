/*
 * Movies released in the last 5 years with the number of 
 * actors who have appeared in each movie
 */
SELECT m.id,
  m.title,
  COUNT(DISTINCT ca.person_id) AS actors_count
FROM movies AS m
  JOIN movie_characters AS mc ON m.id = mc.movie_id
  JOIN character_actors AS ca ON mc.character_id = ca.character_id
WHERE m.release_date > CURRENT_DATE - INTERVAL '5 years'
GROUP BY m.id;