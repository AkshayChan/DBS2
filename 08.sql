(SELECT DISTINCT alb1.title, alb1.artist, alb1.year, alb1.rating 
 FROM (SELECT *
       FROM albums
       ORDER BY artist, year) AS alb1
 WHERE alb1.rating < (SELECT MIN(rating) 
                      FROM albums as alb2 
                      WHERE alb1.artist = alb2.artist
                      AND alb1.title <> alb2.title 
                      AND alb2.year > alb1.year)
 ORDER BY alb1.artist)

UNION

(SELECT a1.title, a1.artist, a1.year, a1.rating
 FROM albums as a1
 WHERE a1.year = (SELECT MAX(a2.year) FROM albums AS a2 WHERE a1.artist = a2.artist)
 AND a1.rating <> 5
 ORDER BY a1.artist)

ORDER BY artist, year;
