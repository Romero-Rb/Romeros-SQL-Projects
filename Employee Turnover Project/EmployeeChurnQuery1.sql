SELECT * FROM dbo.turnover
-- Dataset Obtained from Kaggle  https://www.kaggle.com/datasets/davinwijaya/employee-turnover

--For this data set I will be answering a series of questions to practice basic sql queries
-- Creating a Table for Churned employees to use during the churned employee analysis section

 
--SELECT * INTO dbo.cturnover FROM dbo.turnover
--	WHERE event = 1

-- Percentage of Employees that Have Churned

DECLARE @churned FLOAT

SELECT
	@churned = (SUM(CASE WHEN event = 1 THEN 1 ELSE 0 END) * 100.0) / COUNT(*) 
FROM dbo.turnover

PRINT 'This is the percentage of churned employees ' + CAST(@churned as VARCHAR)

-- What are the top 5 participating professions
SELECT
	TOP 5 profession, count(*) AS freq
FROM dbo.turnover
GROUP BY profession
ORDER BY freq DESC

-- What are the top 3 methods that employees have used to find the job
SELECT
	TOP 3 traffic, count(*) AS traffic_freq 
FROM dbo.turnover
GROUP by traffic
ORDER by traffic_freq DESC

-- Average amount of experience across all employee's that participated
DECLARE @avg_exp FLOAT;

SELECT @avg_exp = AVG(stag)
FROM dbo.turnover

PRINT 'This is the average experience across all participating employees ' +  CAST(@avg_exp AS VARCHAR)

-- How many participants are above the average amount of experience

SELECT count(*) as participant_count
FROM dbo.turnover
WHERE stag > @avg_exp

-- Moving Onto Queries specifically for churned employees

-- List the top 3 professions with the most chruned employees

SELECT 
	TOP 3 profession, count(*) as freq

FROM dbo.cturnover
GROUP BY profession
ORDER BY freq DESC


-- What percentage of employees traveled by car compared to those who don't
DECLARE @cartravel FLOAT

SELECT @cartravel = count(*) 
	FROM dbo.cturnover
	WHERE way = 'car'

SELECT @cartravel / count(*) * 100.0  as percentage_car_travel
	FROM dbo.cturnover

-- What percentage of employees traveled by bus compared to those who don't
DECLARE @bustravel FLOAT

SELECT @bustravel = count(*)
	FROM dbo.cturnover
	WHERE way = 'bus'

SELECT @bustravel / count(*) * 100.0 as percentage_bus_travel
	FROM dbo.cturnover

-- Determing the average rating for independance of churned employees
DECLARE @avgindependance FLOAT

	SELECT @avgindependance = AVG(independ) FROM dbo.cturnover
	PRINT 'This is the average independance rating of churned employees ' + CAST(@avgindependance as VARCHAR)
