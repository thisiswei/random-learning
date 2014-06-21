-- http://users.cis.fiu.edu/~yuanj/cop4540_f00/lecture17_2.pdf
-- a)
SELECT address FROM Studio WHERE name = "MGM";

-- b)
SELECT birthdate FROM MovieStar WHERE name = "Sandra Bullock";

-- c)
SELECT * FROM MovieStar WHERE name in (SELECT starName FROM StarsIn WHERE movieTitle in (SELECT title from Movie WHERE title LIKE "%Love%" or year = 1980));

-- d)
SELECT * FROM MovieExec WHERE netWorth >= 10000000

-- e)
SELECT * FROM MovieStar WHERE gender = "male" or address LIKE "%Miami%";

-- part 2
-- a ?)
-- SELECT starName from StarsIn where movieTitle = "Terms of Endearment" and gender = "male" on
SELECT name FROM MovieStar, StarsIn WHERE gender = "male" and name = starName AND movieTitle = "blahblah"

-- b)
SELECT starName FROM StarsIn, Movie WHERE movieTitle = title AND movieYear = year AND StudioName = "MGM" AND year = 1995;

-- c ?)
-- SELECT * FROM Movie WHERE length > ANY (SELECT length FROM Movie WHERE title = "Gone With the Wind");
SELECT m1.title FROM Movie as m1, Movie as m2 Where m2.title = "Gone With the Wind" and m1.length > m2.length

-- d)
SELECT e1.name FROM MovieExec as e1, MovieExec as e2 WHERE e2.name = "Merv Griffin" AND e1.netWorth > e2.netWorth;


---  exercises 3
-- a ?) Find countries whose ships had the largest number of guns
SELECT country from Classes WHERE numGuns = (SELECT MAX(numGuns) FROM Classes);

-- b ?) Find the classes of ships at least one of which was sunk in a battle
SELECT class FROM Ships WHERE name IN (SELECT ship FROM Outcomes WHERE result = "sunk");

-- c ?)
SELECT name FROM Ships, Classes WHERE ships.class = classes.class AND bore = "16";

-- d ?)
SELECT DISTINCT battle FROM Ships, Outcomes WHERE Outcomes.ship = Ships.name AND Ships.class = "Kango";

-- e  Find the names of the ships whose number of guns was the largest for those ships of the same bore.?)
SELECT name FROM Ships, Classes WHERE Ships.class = Classes.class AND numGuns = (SELECT MAX(numGuns) FROM Classes GROUP BY bore);


--- exercises 4
-- a) find the number of battleship classes
SELECT count(*) FROM classes where type = "bc";
SELECT avg(numGuns) FROM classes where type = "bc";

-- d? )
SELECT class, launched FROM Ships as S1 where launched <= ALL ( SELECT year FROM ships As S2 WHERE s2.class = s1.class );

-- e?)
SELECT count(*) FROM Outcomes, Ships, Classes WHERE Outcomes.result = "sunk" AND Ships.class = Classes.class AND ship = name GROUP BY classes.class;
