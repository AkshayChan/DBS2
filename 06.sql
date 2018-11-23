SELECT foo.a1, MAX(foo.p2-foo.p1)
FROM ((SELECT alb1.artist AS a1, alb2.artist AS a2, alb1.year AS p1, MIN(alb2.year) AS p2
       FROM (SELECT * 
             FROM albums
             ORDER BY artist, year) AS alb1,
            (SELECT * 
             FROM albums
             ORDER BY artist, year) AS alb2
       WHERE alb1.artist = alb2.artist
       AND alb1.title <> alb2.title 
       AND alb2.year > alb1.year
       GROUP BY alb1.artist, alb2.artist, alb1.year)

     UNION

     (SELECT alb1.artist AS a1, alb2.artist AS a2, alb1.year AS p1, MIN(alb2.year) AS p2
      FROM (SELECT * 
            FROM albums
            ORDER BY artist, year) AS alb1,
           (SELECT * 
            FROM albums
            ORDER BY artist, year) AS alb2
      WHERE alb1.artist = alb2.artist
      AND alb1.title <> alb2.title 
      AND alb2.year = alb1.year
      GROUP BY alb1.artist, alb2.artist, alb1.year)) AS foo
GROUP BY a1
ORDER BY a1;