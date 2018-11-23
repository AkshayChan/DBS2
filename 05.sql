((SELECT DISTINCT ans.a1
  FROM (SELECT alb1.artist AS a1, alb2.artist AS a2, alb1.year AS p1, MIN(alb2.year) AS p2
        FROM (SELECT * 
              FROM albums
              WHERE type = 'STUDIO'
              ORDER BY artist, year) AS alb1,
             (SELECT * 
              FROM albums
              WHERE type = 'STUDIO'
              ORDER BY artist, year) AS alb2
        WHERE alb1.artist = alb2.artist
        AND alb1.title <> alb2.title 
        AND alb2.year > alb1.year
        GROUP BY alb1.artist, alb2.artist, alb1.year) AS ans
  ORDER BY ans.a1)

 UNION 

 (SELECT DISTINCT ans.a1
  FROM (SELECT alb1.artist AS a1, alb2.artist AS a2, alb1.year AS p1, MIN(alb2.year) AS p2
        FROM (SELECT * 
              FROM albums
              WHERE type = 'STUDIO'
              ORDER BY artist, year) AS alb1,
             (SELECT * 
              FROM albums
              WHERE type = 'STUDIO'
              ORDER BY artist, year) AS alb2
        WHERE alb1.artist = alb2.artist
        AND alb1.title <> alb2.title 
        AND alb2.year = alb1.year
        GROUP BY alb1.artist, alb2.artist, alb1.year) AS ans
  ORDER BY ans.a1))

EXCEPT

((SELECT DISTINCT ans1.a1
  FROM (SELECT alb1.artist AS a1, alb2.artist AS a2, alb1.year AS p1, MIN(alb2.year) AS p2
        FROM (SELECT * 
              FROM albums
              WHERE type = 'STUDIO'
              ORDER BY artist, year) AS alb1,
             (SELECT * 
              FROM albums
              WHERE type = 'STUDIO'
              ORDER BY artist, year) AS alb2
        WHERE alb1.artist = alb2.artist
        AND alb1.title <> alb2.title
        AND alb2.year > alb1.year
        GROUP BY alb1.artist, alb2.artist, alb1.year) AS ans1
  WHERE ans1.p2 - ans1.p1 > 4
  ORDER BY ans1.a1)

 UNION 

 (SELECT DISTINCT ans.a1
  FROM (SELECT alb1.artist AS a1, alb2.artist AS a2, alb1.year AS p1, MIN(alb2.year) AS p2
        FROM (SELECT * 
              FROM albums
              WHERE type = 'STUDIO'
              ORDER BY artist, year) AS alb1,
             (SELECT * 
              FROM albums
              WHERE type = 'STUDIO'
              ORDER BY artist, year) AS alb2
        WHERE alb1.artist = alb2.artist
        AND alb1.title <> alb2.title 
        AND alb2.year = alb1.year
        GROUP BY alb1.artist, alb2.artist, alb1.year) AS ans
  WHERE ans.p1 - ans.p2 > 4 
  ORDER BY ans.a1))

UNION 

(SELECT name
 FROM artists
 WHERE name NOT IN (SELECT artist FROM albums)
 ORDER BY name)

UNION

(SELECT DISTINCT a1.artist 
 FROM albums AS a1
 WHERE 'STUDIO' NOT IN (SELECT type FROM albums AS a2 WHERE a1.artist = a2.artist)
 ORDER BY a1.artist)

UNION

(SELECT al1.artist
 FROM albums AS al1, (SELECT artist, type FROM albums WHERE type = 'STUDIO') AS al2
 WHERE al1.artist = al2.artist
 AND al1.type = 'STUDIO' 
 GROUP BY al1.artist
 HAVING COUNT(al2.type) = 1
 ORDER BY al1.artist)

ORDER BY a1;
