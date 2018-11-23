(SELECT albums.title, albums.artist, albums.tracks, COUNT(tracks.artist), CAST((100 -(COUNT(tracks.artist) * 100.0)/albums.tracks) AS decimal(4, 1)), CAST((AVG(length) * albums.tracks) AS int)
 FROM tracks, albums
 WHERE albums.title = tracks.album
 AND albums.artist = tracks.artist
 AND albums.type = 'COMPILATION'
 GROUP BY albums.title, albums.artist, albums.tracks
 ORDER BY albums.title)

UNION

(SELECT title, artist, tracks, 0, 100.0, CAST(NULL AS int)
 FROM albums
 WHERE NOT EXISTS (SELECT *
                   FROM tracks
                   WHERE tracks.album = albums.title
                   AND tracks.artist = albums.artist) 
 AND albums.type = 'COMPILATION')
ORDER BY title;		