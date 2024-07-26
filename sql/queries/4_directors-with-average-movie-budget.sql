/*
 * Select directors along with the average budget of the movies 
 * they have directed.
 * 
 * Output columns:
 * - id => person_id
 * - fullname => person first_name and last_name
 * - average_budget => average budget of the movies they have directed
 */
SELECT p.id,
  CONCAT(p.first_name, ' ', p.last_name) AS fullname,
  ROUND(AVG(m.budget), 2) AS average_budget
FROM persons AS p
  JOIN movies AS m ON m.director = p.id
GROUP BY p.id;