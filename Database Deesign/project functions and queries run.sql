SELECT * FROM music.song;

Select a.name, s.name, l.year
From artist a join album l
on (a.id = l.artist_id)
join song s on (s.album_id = l.id)
Where s.duration>(Select Avg(duration)
From song g
where s.album_id = g.album_id);

Select s.name, l.name From song s left Join album l on (s.album_id = l.id)
Where year = 1988 Union
Select s.name, l.name From song s left Join album l on (s.album_id = l.id)
Where year = 2009; 

Select s.name, s.duration, s.duration- M.a Diff From song s, (select Avg(duration)as a 
from song) M; 

Select l.year, Count(*)
From album l
group by l.year;

Select l.name, a.name, l.year
FROM  album l inner join artist a     
on a.id = l.artist_id
and year>2000;


DELIMITER $$
CREATE function get_duration(dura int) 
RETURNS DOUBLE

READS SQL DATA
DETERMINISTIC

   BEGIN 
   DECLARE dur DOUBLE;
      SELECT duration 
      INTO dur 
      FROM song 
      WHERE id = dura; 
      RETURN(dur); 
    END$$
DELIMITER ; 

DELIMITER $$
CREATE TRIGGER TR_INS
before INSERT ON album
for each row
begin 
	set new.year = new.year +1; 
end$$
DELIMITER ;

INSERT INTO album VALUES(26, 1, 'No one is here' , 1987);

drop trigger if exists TR_INS;
DROP FUNCTION get_duration;

SELECT get_duration(2) 
DELETE FROM album WHERE id = 26


