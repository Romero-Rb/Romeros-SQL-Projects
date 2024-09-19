/*
Dataset: IMDb 5000+ Movies & Multiple Genres Dataset
Source: https://www.kaggle.com/datasets/rakkesharv/imdb-5000-movies-multiple-genres-dataset
Queried with: MySQL 




QUICK NOTES
These queries are simply for practicing basic sql statements


There are a number of movies with an uknown gross value, so in statements that require that field, I will exclude those values
Not using the DELETE statement, to keep datatable intact. This practice focuses on smaller queiries without manipulating the original set
*/


#Display top 10 movies with the highest total grossing value
#Cast and replace statements used to make Total_Gross eligible to be cast to a double

SELECT 
	Total_Gross, Movie_Title 
FROM 
	imdb_all_genres_etf_clean1 	
WHERE NOT 
	Total_Gross = 'Gross Unkown'
ORDER BY CAST(REPLACE(REPLACE(Total_Gross, 'M', ''),'$', '') AS DOUBLE) DESC;


	
#Checking the Possible Values of Side_genre

SELECT DISTINCT 
	side_genre 
FROM 
	imdb_all_genres_etf_clean1;


#Displaying Top 5 Action movies with the highest total grossing value and their ratings


SELECT
	Movie_title, 
    Total_Gross, 
    Rating
FROM 
	Imdb_all_genres_etf_clean1
WHERE 
	side_genre
	LIKE 
		'%Action%'
ORDER BY CAST(REPLACE(REPLACE(Total_Gross, 'M', ''),'$', '') AS DOUBLE) DESC
LIMIT 5;




#Getting the Average Rating all Action Movies

SELECT
	AVG(Rating) 
FROM 
	imdb_all_genres_etf_clean1
WHERE
	side_genre 
	LIKE 
		'%Action%';


#Showing all action movies that have a rating above the average action movie rating


SELECT 
	Movie_Title,
	Rating 
FROM 
	imdb_all_genres_etf_clean1

WHERE 
	side_genre 
	LIKE 
		'%ACTION%' 
	AND 
		Rating > (SELECT 
					AVG(Rating) 
				FROM 
					imdb_all_genres_etf_clean1
				WHERE 
					side_genre 
					LIKE 
						'%Action%');
                     
                        
#Finding the average Rating of Movies that have a Total_Gross value above the average


SELECT
	AVG(Rating)
FROM
	imdb_all_genres_etf_clean1
WHERE
	CAST(REPLACE(REPLACE(Total_Gross, 'M', ''),'$', '') AS DOUBLE) >
    (SELECT AVG(CAST(REPLACE(REPLACE(Total_Gross, 'M', ''),'$', '') AS DOUBLE)) FROM imdb_all_genres_etf_clean1);
    


#Ordering side_genre by the the average rating of each side_genre
SELECT
	side_genre,
	AVG(Rating)
FROM
imdb_all_genres_etf_clean1
GROUP BY
	side_genre;
    



    
    