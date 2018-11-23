SELECT title, artist, year
FROM albums AS alb, artists AS at
WHERE alb.type = 'LIVE'
AND alb.artist = at.name
AND at.country = 'GBR'
AND alb.rating > (SELECT AVG(RATING) FROM albums WHERE year = alb.year)
ORDER BY year;
