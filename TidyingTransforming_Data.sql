-- Drop tables if they already exist
DROP TABLE IF EXISTS FlightData;
DROP TABLE IF EXISTS Airlines;
DROP TABLE IF EXISTS Destinations;
DROP TABLE IF EXISTS Statuses;

-- Create Airlines table
CREATE TABLE Airlines (
    AirlineId INT PRIMARY KEY AUTO_INCREMENT,
    AirlineName VARCHAR(300)
);

-- Insert data into Airlines table
INSERT INTO Airlines (AirlineName) VALUES 
('ALASKA'),
('AMWEST');

-- Create Destinations table
CREATE TABLE Destinations (
    DestId INT PRIMARY KEY AUTO_INCREMENT,
    DestName VARCHAR(300)
);

-- Insert data into Destinations table
INSERT INTO Destinations (DestName) VALUES
('Los Angeles'),
('Phoenix'),
('San Diego'),
('San Francisco'),
('Seattle');

-- Create Statuses table
CREATE TABLE Statuses (
    StatusId INT PRIMARY KEY AUTO_INCREMENT,
    StatusName VARCHAR(300)
);

-- Insert data into Statuses table
INSERT INTO Statuses (StatusName) VALUES
('on time'),
('delayed');

CREATE TABLE FlightData (
    FlId INT PRIMARY KEY AUTO_INCREMENT,
    AirlineId INT,
    DestId INT,
    StatusId INT,
    FlightCount INT,
    FOREIGN KEY (AirlineId) REFERENCES Airlines(AirlineId),
    FOREIGN KEY (DestId) REFERENCES Destinations(DestId),
    FOREIGN KEY (StatusId) REFERENCES Statuses(StatusId)
);

-- Insert data into FlightData table
INSERT INTO FlightData (AirlineId, DestId, StatusId, FlightCount) VALUES 
(1, 1, 1, 497),
(1, 1, 2, 62),  
(1, 2, 1, 221), 
(1, 2, 2, 12), 
(1, 3, 1, 212),
(1, 3, 2, 20),  
(1, 4, 1, 503), 
(1, 4, 2, 102),  
(1, 5, 1, 1841), 
(1, 5, 2, 305),  
(2, 1, 1, 694), 
(2, 1, 2, 117),  
(2, 2, 1, 4840), 
(2, 3, 1, 383), 
(2, 3, 2, 65),  
(2, 4, 1, 320), 
(2, 4, 2, 129),  
(2, 5, 1, 201), 
(2, 5, 2, 61);  


-- Query to get .csv file data:
SELECT 
    a.AirlineName AS 'Airline',
    s.StatusName AS 'Status',
    SUM(IF(d.DestName = 'Los Angeles', fd.FlightCount, 0)) AS 'Los Angeles',
    SUM(IF(d.DestName = 'Phoenix', fd.FlightCount, 0)) AS 'Phoenix',
    SUM(IF(d.DestName = 'San Diego', fd.FlightCount, 0)) AS 'San Diego',
    SUM(IF(d.DestName = 'San Francisco', fd.FlightCount, 0)) AS 'San Francisco',
    SUM(IF(d.DestName = 'Seattle', fd.FlightCount, 0)) AS 'Seattle'
FROM FlightData fd
JOIN Airlines a ON fd.AirlineId = a.AirlineId
JOIN Destinations d ON fd.DestId = d.DestId
JOIN Statuses s ON fd.StatusId = s.StatusId
GROUP BY a.AirlineName, s.StatusName;

