SELECT alb.artist, alb.year
FROM (SELECT a1.artist, a1.year  
      FROM albums AS a1
      WHERE type = 'STUDIO'
      AND a1.year = (SELECT MIN(a2.year) FROM albums AS a2 WHERE a1.artist = a2.artist AND a2.type = 'STUDIO')
      AND a1.rating = 5
      ORDER BY a1.artist, a1.year) AS alb,
      artists AS at
WHERE alb.artist = at.name
AND at.type = 'BAND'
AND at.country = 'USA';
