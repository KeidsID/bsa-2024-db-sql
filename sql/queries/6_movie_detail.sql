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
 * - genres => {id, name}
 *
 * * Person Object: {id, first_name, last_name, photo: {
 *     id, file_name, mime_type, source_url
 *     }
 *   }
 */