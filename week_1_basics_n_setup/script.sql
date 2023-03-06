-- join table to see actual location name
SELECT 
	tpep_pickup_datetime,
	tpep_dropoff_datetime,
	total_amount,
	CONCAT(zpu."Borough", '/', zpu."Zone") AS "pickup_loc",
	CONCAT(zdo."Borough", '/', zdo."Zone") AS "dropoff_loc"
FROM
	yellow_taxi_trips t,
	zones zpu,
	zones zdo
WHERE
	t."PULocationID" = zpu."LocationID" AND
	t."DOLocationID" = zdo."LocationID"
LIMIT 100

-- use INNER JOIN
SELECT 
	t."tpep_pickup_datetime",
	t."tpep_dropoff_datetime",
	t."total_amount",
	CONCAT(zpu."Borough", '/', zpu."Zone") AS "pickup_loc",
	CONCAT(zdo."Borough", '/', zdo."Zone") AS "dropoff_loc"
FROM
	yellow_taxi_trips t JOIN zones zpu
		ON t."PULocationID" = zpu."LocationID"
	JOIN zones zdo
		ON t."DOLocationID" = zdo."LocationID"
LIMIT 100

-- get date from datetime
SELECT 
	tpep_pickup_datetime,
	tpep_dropoff_datetime,
	DATE_TRUNC('DAY',tpep_dropoff_datetime),
	CAST(tpep_dropoff_datetime AS DATE) AS "day",
	total_amount
FROM
	yellow_taxi_trips t
LIMIT 100

-- group by
SELECT 
	CAST(tpep_dropoff_datetime AS DATE) as "day",
	"DOLocationID",
	count(1) as "count",
	MAX(total_amount) as "max_total_amount",
	MAX(passenger_count) as "max_passenger_count"
FROM
	yellow_taxi_trips t
GROUP BY
	1,2
ORDER BY 
	"day" ASC,
	"DOLocationID" DESC
