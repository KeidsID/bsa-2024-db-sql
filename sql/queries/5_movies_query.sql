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