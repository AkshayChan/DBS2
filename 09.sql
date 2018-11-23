SELECT foo1.title, foo1.artist, foo1.hours, (foo1.sum - foo1.hours*3600)/60 AS minutes, (foo1.sum - foo1.hours*3600) % 60 AS seconds 
FROM (SELECT foo.title, foo.artist, foo.sum,  foo.sum/3600 AS hours
      FROM (SELECT albums.title, albums.artist, SUM(tracks.length) 
            FROM tracks, albums
            WHERE albums.title = tracks.album
            AND albums.artist = tracks.artist
            GROUP BY albums.title, albums.artist, albums.tracks
            HAVING albums.tracks = COUNT(tracks.artist)
            ORDER BY albums.title) AS foo) AS foo1 
ORDER BY title, artist;