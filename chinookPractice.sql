
-- 1 - Display all Sales Support Agents with their first name and last name
select FirstName, LastName from Employee
    where Title like "sales support agent";

-- 2 - Display all employees hired between 2002 and 2003, and display their first name and last name
select FirstName, LastName from Employee
    where year(HireDate) >=2002 AND year(HireDate)<=2003;

-- 3 - Display all artists that have the word 'Metal' in their name
select * from Artist where Name like "$Metal$";

-- 4 - Display all employees who are in sales (sales manager, sales rep etc.)
select * from Employee where Title like "sales%";
-- 5 - Display the titles of all tracks which has the genre "easy listening"
select Track.name, Genre.name 
    from Track join Genre on Track.GenreId = Genre.GenreId 
    where Genre.name="easy listening";

-- 6 - Display all the tracks from all albums along with the genre of each track
select Track.name, Genre.name 
    from Track join Genre on Track.GenreId = Genre.GenreId;

-- 7 - Using the Invoice table, show the average payment made for each country
select BillingCountry, AVG(Total)
    from Invoice
    group by BillingCountry;

-- 8 - Using the Invoice table, show the average payment made for each country, 
-- but only for countries that paid more than $5.50 in total average
select BillingCountry, AVG(Total) as totalAVG from Invoice group by BillingCountry having totalAVG > 5.5;



-- 9 - Using the Invoice table, show the average payment made for each customer, 
--but only for customer reside in Germany and only if that customer has paid more than 10 in total
select CustomerId, avg(Total), BillingCountry from Invoice
    where BillingCountry = "Germany"
    group by CustomerId
    ;

select CustomerId, sum(Total), BillingCountry from Invoice
    where BillingCountry = "Germany"
    group by CustomerId
    ;
-- 10 - Display the average length of Jazz song (that is, the genre of the song is Jazz) for each album

select Track.AlbumId, Title, avg(Milliseconds) from Track
    join Album on Track.AlbumId = Album.AlbumId
    where Track.GenreId=

    (select distinct(Track.GenreId)
    from Track join Genre on Track.GenreId = Genre.GenreId 
    where Genre.name="Jazz")

    group by AlbumId, Title
    ;

-- below is hardcoded 2
select Track.AlbumId, Title, avg(Milliseconds) from Track
    join Album on Track.AlbumId = Album.AlbumId
    where Track.GenreId=2
    group by AlbumId, Title
    ;

-- 3 way join
select avg(Milliseconds), Genre.Name, Album.Title from Track join Album on Track.AlbumId = Album.AlbumId
 join Genre on Track.GenreId = Genre.GenreId
 where Genre.Name = "Jazz"
 group by Genre.Name, Album.Title;

-- short cut alias - caution against using it
 select avg(Milliseconds), g.Name, a.Title from Track as t join Album as a on t.AlbumId = a.AlbumId
 join Genre as g on t.GenreId = g.GenreId
 where g.Name = "Jazz"
 group by g.Name, a.Title;
