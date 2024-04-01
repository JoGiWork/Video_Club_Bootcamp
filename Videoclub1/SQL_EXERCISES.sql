--1 .Devuelve todas las películas

SELECT * 
FROM MOVIES

--2. Devuelve todos los géneros existentes

SELECT * 
FROM GENRES

--3. Devuelve la lista de todos los estudios de grabación que estén activos

SELECT STUDIO_NAME, STUDIO_ACTIVE
FROM PUBLIC.STUDIOS

WHERE STUDIO_ACTIVE > 0;

--4. Devuelve una lista de los 20 últimos miembros en anotarse al videoclub

SELECT MEMBER_NAME, MEMBER_ID
FROM PUBLIC.MEMBERS
ORDER BY MEMBER_EXPIRATION_DATE  DESC
LIMIT 20;

-- 5. Devuelve las 20 duraciones de películas más frecuentes, ordenados de mayor a menor.

SELECT MOVIE_DURATION, COUNT(*) AS frecuencia  
FROM MOVIES
GROUP BY MOVIE_DURATION 
ORDER BY frecuencia DESC 
LIMIT 20;

-- 6. Devuelve las películas del año 2000 en adelante que empiecen por la letra A.

SELECT * FROM PUBLIC.MOVIES 
WHERE MOVIE_LAUNCH_DATE > '1999-12-31'
AND MOVIE_NAME LIKE 'A%';

-- 7. Devuelve los actores nacidos un mes de Junio

SELECT * FROM PUBLIC.ACTORS 
WHERE MONTH(ACTOR_BIRTH_DATE)= 6;

-- 8. Devuelve los actores nacidos cualquier mes que no sea Junio y que sigan vivos.

SELECT * 
FROM PUBLIC.ACTORS 
WHERE MONTH(ACTOR_BIRTH_DATE)<> 6
AND ACTOR_DEAD_DATE IS NULL;

-- 9. Devuelve el nombre y la edad de todos los directores menores o iguales de 50 años que estén vivos

SELECT
	DIRECTOR_NAME, EDAD
FROM
	(
	SELECT
		director_name,
		DIRECTOR_DEAD_DATE,
		DATEDIFF(YEAR, DIRECTOR_BIRTH_DATE, CURRENT_DATE) AS edad
	FROM
		DIRECTORS)
WHERE
	edad >= 50
AND DIRECTOR_DEAD_DATE IS NULL
;

-- 10. Devuelve el nombre y la edad de todos los actores menores de 50 años que hayan fallecido

SELECT * FROM PUBLIC.ACTORS;

SELECT
	ACTOR_NAME, EDAD
FROM
	(
	SELECT
		ACTOR_NAME,
		ACTOR_DEAD_DATE,
		DATEDIFF(YEAR, ACTOR_BIRTH_DATE, CURRENT_DATE) AS edad
	FROM
		ACTORS)
WHERE
	edad < 50
AND ACTOR_DEAD_DATE IS NOT NULL
;

-- 11. Devuelve el nombre de todos los directores menores o iguales de 40 años que estén vivos

SELECT
	DIRECTOR_NAME, EDAD
FROM
	(
	SELECT
		director_name,
		DIRECTOR_DEAD_DATE,
		DATEDIFF(YEAR, DIRECTOR_BIRTH_DATE, CURRENT_DATE) AS edad
	FROM
		DIRECTORS)
WHERE
	edad < 40
AND DIRECTOR_DEAD_DATE IS NULL
;

-- 12. Indica la edad media de los directores vivos

SELECT AVG(DATEDIFF(YEAR,DIRECTOR_BIRTH_DATE,CURRENT_DATE)) AS edad_media 
FROM DIRECTORS
WHERE DIRECTOR_DEAD_DATE IS NOT NULL;

-- 13. Indica la edad media de los actores que han fallecido

SELECT AVG(DATEDIFF(YEAR,ACTOR_BIRTH_DATE,CURRENT_DATE)) AS edad_media
FROM ACTORS
WHERE ACTOR_BIRTH_DATE IS NOT NULL;

-- 14. Devuelve el nombre de todas las películas y el nombre del estudio que las ha realizado

SELECT M.MOVIE_NAME, S.STUDIO_NAME
FROM MOVIES M
JOIN STUDIOS S ON M.STUDIO_ID = S.STUDIO_ID;

-- 15. Devuelve los miembros que alquilaron al menos una película entre el año 2010 y el 2015

SELECT * 
FROM PUBLIC.MEMBERS mem
JOIN PUBLIC.MEMBERS_MOVIE_RENTAL r ON mem.MEMBER_ID = r.MEMBER_MOVIE_RENTAL_ID
JOIN PUBLIC.MOVIES mov ON mem.MEMBER_ID = mov.MOVIE_ID
WHERE YEAR(r.MEMBER_RENTAL_DATE) BETWEEN 2010 AND 2015;

--16. Devuelve cuantas películas hay de cada país

SELECT COUNTRY, COUNT(*) AS NUM_PELICULAS
FROM MOVIES
GROUP BY COUNTRY;

--17. Devuelve todas las películas que hay de género documental

SELECT *
FROM MOVIES
WHERE GENRE = 'Documentary';

--18. Devuelve todas las películas creadas por directores nacidos a partir de 1980 y que todavía están vivos

SELECT M.*
FROM MOVIES M
JOIN DIRECTORS D ON M.DIRECTOR_ID = D.DIRECTOR_ID
WHERE D.YEAR_OF_BIRTH >= 1980 AND D.YEAR_OF_DEATH IS NULL;

--19. Indica si hay alguna coincidencia de nacimiento de ciudad (y si las hay, indicarlas) entre los miembros del videoclub y los directores.

SELECT DISTINCT MEMBER_TOWN
FROM MEMBERS
JOIN DIRECTORS ON MEMBER_TOWN = DIRECTOR_BIRTH_PLACE;


--20. Devuelve el nombre y el año de todas las películas que han sido producidas por un estudio que actualmente no esté activo

SELECT MOVIE_NAME, MOVIE_LAUNCH_DATE 
FROM MOVIES
JOIN STUDIOS ON STUDIO_ID = STUDIO_ID
WHERE STUDIO_ACTIVE = 0;

