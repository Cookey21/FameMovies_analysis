--QUESTION 1:Ranking of the movie genres over different decades
SELECT [genre], [year]/ 10 * 10 AS 'decade',
COUNT (*) AS 'num_movies',
RANK() OVER(PARTITION BY [year]/ 10 *10 ORDER BY COUNT(*) DESC) AS 'ranking'
FROM [dbo].[Fame's movies]
GROUP BY [genre], [year]/ 10 * 10;

--QUESTION 2:The overall ratings for each movie genre.

SELECT [genre],
AVG ([score]) AS 'overall_rating'
FROM[dbo].[Fame's movies]
GROUP BY [genre]
ORDER BY [overall_rating] DESC;

--QUESTION 3: Retrieve all records from the table
SELECT *
FROM [dbo].[Fame's movies];

--QUESTION 4: Find the highest-grossing movie
SELECT [name], [gross]
FROM [dbo].[Fame's movies]
ORDER BY [gross] DESC;

--QUESTION 5: Find the top 5 movies with the highest IMDb user rating
SELECT TOP(5) [name],[score]
FROM [dbo].[Fame's movies]
ORDER BY [score]DESC;

--QUESTION 6: Calculate the total revenue generated from all movies
SELECT SUM([gross]) AS 'total_revenue'
FROM [dbo].[Fame's movies];

--QUESTION 7: Find the movie with the most user votes
SELECT [name], [votes]
FROM [dbo].[Fame's movies]
ORDER BY [votes] DESC;

--QUESTION 8: Calculate the total runtime of all movies
SELECT SUM([runtime]) AS  'total_runtime'
FROM [dbo].[Fame's movies];

--QUESTION 9: Find the top 5 genres with the highest average gross revenue
SELECT TOP(5) [genre],
AVG([gross]) AS 'highest_revenue'
FROM [dbo].[Fame's movies]
GROUP BY [genre]
ORDER BY [highest_revenue] DESC;

--QUESTION 10: Calculate the average IMDb user rating for movies released in each country
SELECT DISTINCT [country] ,AVG([score]) AS 'avg_rating'
FROM [dbo].[Fame's movies]
GROUP BY [country];

--QUESTION 11:Retrieve movies with a budget greater than the average budget across all movies
SELECT[name] , [budget]
FROM [dbo].[Fame's movies]
WHERE [budget] > (SELECT AVG([budget]) FROM [dbo].[Fame's movies])
ORDER BY [budget] DESC;

--QUESTION 12: Find the movie with the highest gross revenue in each country
WITH highest_gross_rev AS (
SELECT[name],[country], [gross],
ROW_NUMBER()
OVER(PARTITION BY [country] ORDER BY [gross] DESC) AS Rank
FROM[dbo].[Fame's movies]
)
SELECT[name], [country], [gross]
FROM highest_gross_rev
WHERE Rank=1
ORDER BY [gross] DESC

--QUESTION 13: Calculate the percentage of total revenue contributed by each genre
SELECT[genre], SUM([gross]) AS 'totalrevenue', (SUM([gross]) / (SELECT SUM([gross]) FROM [dbo].[Fame's movies]) * 100) AS PERCENTAGE
FROM [dbo].[Fame's movies]
GROUP BY [genre]
ORDER BY SUM([gross]) DESC

--QUESTION 14: Retrieve movies released by directors who have more than 3 movies in the
dataset
SELECT [director], COUNT(*) AS 'movie_count'
FROM [dbo].[Fame's movies]
GROUP BY [director]
HAVING COUNT(*) > 3
ORDER BY [movie_count] DESC

--QUESTION 15: Calculate the average number of user votes for movies with a rating of 'PG-13'
SELECT[rating], [name] , AVG([votes]) AS 'avg_votes'
FROM [dbo].[Fame's movies]
WHERE [rating]= 'PG-13'
GROUP BY [rating],[name]
ORDER BY [avg_votes] DESC

--QUESTION 16: Find the most common main actor/actress (star) across all movies
SELECT TOP 1 [star], COUNT(*) AS 'Movie_count'
FROM [dbo].[Fame's movies]
GROUP BY [star]
ORDER BY 'Movie_count' DESC

--QUESTION 17: Calculate the number of movies released each year and sort them in descending
order
SELECT [year], COUNT(*) AS 'Num_movies'
FROM [dbo].[Fame's movies]
GROUP BY [year]
ORDER BY [Num_movies] DESC

--QUESTION 18: Retrieve movies with a rating of 'R' and a runtime of more than 120 minutes
SELECT [name],[rating],[runtime]
FROM [dbo].[Fame's movies]
WHERE [rating]= 'R' AND [runtime] > 120
