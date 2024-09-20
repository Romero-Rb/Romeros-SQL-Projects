/*
Dataset: Custom Tables 
Source: Provided on github, but also made from these sql satements
Queried using: MySQL Workbench


This code was created to aid me in learning how to use tables, UPDATE statements and Aggregate functions

#Create a Table for Inventory at seperate supplies store

*/
CREATE TABLE store_location1(
		product_id int,
        product_type varchar(255),
        product_name varchar(255),
        company_name varchar(225),
        amount_purchased int,
        amount_sold int,
        consumer_cost double,
        cost_to_buy double,
        continued_use varchar(255));
      
INSERT INTO store_location1 (product_id, product_type, product_name, company_name, amount_purchased, amount_sold, consumer_cost, cost_to_buy, continued_use)
	VALUES
    (102210,'Paper','500 Sheets','Kapler',300,275,9,7.40,'yes'),
    (102211,'Paper','500 Sheets','Terrace',250,223,11,9.00,'yes'),
    (102212,'Paper','500 Sheets','GreenWell',0,0,10.4,8.60,'no'),
    (NULL,NULL,NULL, NULL, NULL, 0,0,0,NULL),
    (101510,'Pens','8 Ballpoint Pens','Terrace',175,154,2.25,1.40,'yes'),
	(101511,'Pens','8 Ballpoint Pens','GreenWell',0,0,2.5,1.55,'no'),
    (101512,'Pens','4 Fountain Pens','Kapler',40,25,5.5,4.75,'yes'),
    (101513,'Pens','4 Fountain Pens','Terrace',50,39,5.7,5.10,'yes'),
    (104310,'Stapler','Classic Stapler','Kapler',250,146,6.5,4.34,'yes'),
    (104311,'Stapler','Classic Stapler','Korwell',130,90,7,4.50,'yes'),
    (104510,'White-Out','Classic White-out','GreenWell',0,0,4.3,3.20,'no'),
    (104511,'White-Out','Classic White-out','Korwell',230,185,4,3.00,'yes'),
    (106310,'Pencil','12 Classic Pencil','Terrace',125,20,1.25,0.60,'no'),
    (106311,'Pencil','12 Classic Pencil','Kapler',245,210,1.45,0.70,'yes'),
    (106312,'Pencil','12 Classic Pencil','Korwell',150,135,1.5,0.72,'yes'),
    (106313,'Pencil','8 Mechanical Pencil','GreenWell',0,0,1.5,1.20,'no'),
    (106314,'Pencil','8 Mechanical Pencil','Mantor',240,200,2.3,1.10,'yes'),
    (107210,'Permanent Marker','Multi Colour Pack','Mantor',200,175,2.75,2.20,'yes'),
    (107211,'Permanent Marker','Black','Mantor',165,120,2.2,1.40,'yes'),
    (107212,'Permanent Marker','Black','Korwell',155,135,2.6,1.60,'yes');
    
    
#Overviewing the Submitted Data
SELECT * FROM
	store_location1;



#Clearing out Data With Null references
DELETE FROM store_location1
WHERE
	company_name IS NULL;
    
    
    
# The ficticious Mantor company was a previous name for the Terrace company, so i'll update all Mantor entries to Terrace
UPDATE 
	store_location1
SET 
	company_name = 'Terrace'
WHERE 
	company_name LIKE 'Mantor';


#All GreenWell Products have been discontinued, and thus have their continued value set at no, 
#Any continued_use values containing no, should be removed as the data is not needed anymore

DELETE FROM
	store_location1
WHERE
	continued_use = 'no';


#Creating a column that calculates the profit of each item
ALTER TABLE store_location1 ADD profit DOUBLE;
UPDATE 
	store_location1
SET 
	profit = consumer_cost - cost_to_buy;



#Calculating Gross Profit and Net Income provided by each product
ALTER TABLE store_location1 ADD gross_profit DOUBLE;
ALTER TABLE store_location1 ADD costs DOUBLE;

UPDATE 
	store_location1
SET
	gross_profit = consumer_cost * amount_sold;
UPDATE
	store_location1
SET
	costs = cost_to_buy * amount_purchased;



#Finally Return the Income of each product
ALTER TABLE store_location1 ADD net_income DOUBLE;
UPDATE
	store_location1
SET
	net_income = gross_profit - costs;
   
#Which Product generates produces the highest net_income
SELECT product_type, product_name, company_name, net_income FROM store_location1
ORDER BY net_income DESC
LIMIT 1;

	