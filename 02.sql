SELECT at.country, SUM(CASE WHEN alb.type = 'STUDIO' THEN alb.count ELSE 0 END) AS Studio,
SUM(CASE WHEN alb.type = 'LIVE' THEN alb.count ELSE 0 END) AS Live,
SUM(CASE WHEN alb.type = 'COMPILATION' THEN alb.count ELSE 0 END) AS Compilation
FROM (SELECT artist, type, COUNT(type)
      FROM albums
      GROUP BY artist, type
      ORDER BY artist, type) AS alb,
      artists as at
WHERE at.name = alb.artist
GROUP BY at.country
ORDER BY at.country;
