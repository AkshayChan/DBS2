SELECT tot.country, ban.count, noban.count, tot.count, CAST(((ban.count*100.0)/tot.count) AS decimal(3,0)), CAST(((noban.count*100.0)/tot.count) AS decimal(3,0))
FROM (SELECT COUNT(name), country
      FROM artists
      WHERE type = 'BAND'
      GROUP BY country
      ORDER BY country) AS ban,
     (SELECT COUNT(name), country
      FROM artists
      WHERE type <> 'BAND'
      GROUP BY country
      ORDER BY country) AS noban,
     (SELECT COUNT(name), country
      FROM artists
      GROUP BY country
      ORDER BY country) AS tot
WHERE ban.country = noban.country AND noban.country = tot.country;
