

  SELECT* FROM [dbo].[Viewership]
  SELECT* FROM [dbo].[userprocsv]
--- TABLES JOIN
  SELECT*
  FROM [dbo].[Viewership] as V
  FULL JOIN [dbo].[userprocsv] as U
  ON V.UserID = U.USERID

----user viewership
  SELECT 
    v.*,
    u.Name,
    u.Gender,
    u.Province
FROM 
    [dbo].[Viewership] as V
LEFT JOIN 
    [dbo].[userprocsv] as U
    ON V.UserID = U.USERID


 
--Most Watched Channels
 SELECT 
  Channel,
  SUM(DATEDIFF(SECOND, 0, [Duration])) / 60.0 AS Total_Watch_Minutes
FROM [dbo].[Viewership]
GROUP BY Channel
ORDER BY Total_Watch_Minutes DESC


---Number of Viewers
SELECT COUNT(DISTINCT USERID) AS NUMBER_OF_VIEWERSHIP 
FROM [dbo].[Viewership]

---NUMBER OF VIEWS
SELECT COUNT(*) AS NUMBER_OF_VIEWERSHIP 
FROM [dbo].[Viewership]

---LEAST VIEWS
SELECT TOP 10 
    U.Province, 
    COUNT(*) AS Number_of_Views
FROM 
    [dbo].[Viewership] AS V
INNER JOIN 
    [dbo].[userprocsv] AS U ON V.UserID = U.UserID
GROUP BY 
    U.Province
ORDER BY 
    Number_of_Views DESC;


	---RANK BY PERCENTAGE OF VIEWS
	SELECT TOP 10
    U.Province, 
    COUNT(*) AS Number_of_Views,
    CAST(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER () AS DECIMAL(5,2)) AS Percentage_of_Total_Views
FROM 
    [dbo].[Viewership] AS V
INNER JOIN 
   [dbo].[userprocsv] AS U ON V.UserID = U.UserID
WHERE 
    V.RecordDate >= '2016-01-01' AND V.RecordDate < '2025-01-01'

GROUP BY 
    U.Province
ORDER BY 
    Number_of_Views DESC;

---Total Users
SELECT COUNT(DISTINCT UserID) AS Total_Users
FROM [dbo].[userprocsv] ;

---Top Province by user
SELECT TOP 6 Province, COUNT(*) AS User_Count
FROM [dbo].[userprocsv]
GROUP BY Province
ORDER BY User_Count DESC;

---3. Age Group  (25–34 most active)
SELECT 
    CASE 
        WHEN Age BETWEEN 18 AND 24 THEN '18-24'
        WHEN Age BETWEEN 25 AND 34 THEN '25-34'
        WHEN Age BETWEEN 35 AND 44 THEN '35-44'
        WHEN Age BETWEEN 45 AND 54 THEN '45-54'
        ELSE '55+' 
    END AS Age_Group,
    COUNT(*) AS User_Count
FROM [dbo].[userprocsv]
GROUP BY 
    CASE 
        WHEN Age BETWEEN 18 AND 24 THEN '18-24'
        WHEN Age BETWEEN 25 AND 34 THEN '25-34'
        WHEN Age BETWEEN 35 AND 44 THEN '35-44'
        WHEN Age BETWEEN 45 AND 54 THEN '45-54'
        ELSE '55+' 
    END
ORDER BY User_Count DESC;


---find the gender
SELECT Gender, COUNT(*) AS User_Count
FROM [dbo].[userprocsv]
GROUP BY Gender;

----

