SELECT at.country, CAST(SUM(CASE WHEN alb.type = 'STUDIO' THEN alb.count ELSE 0 END)/COUNT(DISTINCT at.name) AS decimal(3,1)) AS Studio,
CAST(SUM(CASE WHEN alb.type = 'LIVE' THEN alb.count ELSE 0 END)/COUNT(DISTINCT at.name) AS decimal(3,1)) AS Live,
CAST(SUM(CASE WHEN alb.type = 'COMPILATION' THEN alb.count ELSE 0 END)/COUNT(DISTINCT at.name) AS decimal(3,1)) AS Compilation
FROM (SELECT artist, type, COUNT(type)
      FROM albums
      GROUP BY artist, type
      ORDER BY artist, type) AS alb,
      artists as at
WHERE at.name = alb.artist
GROUP BY at.country
ORDER BY at.country;
