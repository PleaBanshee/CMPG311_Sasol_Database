-- EXPORT VIEWS --
CREATE VIEW Trans_Status
AS SELECT Transporter, Transporter_Stat AS Status 
   FROM Export;

CREATE VIEW Export_Profits
AS SELECT Sales_Price AS Revenue, Export_Cost AS Export Cost, (Sales_Price - Export_Cost) AS Profit
   FROM Export
   WHERE Sales_Price > Export_Cost;
   
CREATE VIEW Export_Losses
AS SELECT Sales_Price AS Revenue, Export_Cost AS Export Cost, (Sales_Price - Export_Cost) AS Loss
   FROM Export
   WHERE Sales_Price < Export_Cost;

CREATE VIEW Total_Profit
AS SELECT SUM(Sales_Price - Export_Cost) AS "Total Profit" 
   FROM Export;

CREATE VIEW Total_Export_Costs
AS SELECT SUM(Export_Cost) AS "Total Costs" 
   FROM Export; 

CREATE VIEW Total_Revenue
AS SELECT SUM(Sales_Price) AS "Total Revenue" 
   FROM Export; 

CREATE VIEW Export_Destinations
AS SELECT Transporter, Dest_Name AS Destination
   FROM Export, Destination
   INNER JOIN Dest_ID ON
        Destination.Dest_ID = Export.Dest_ID
    ORDER BY 
        Transporter ASC;

CREATE VIEW Transporter_Loads
AS SELECT Transporter, Quantity AS "Quantity in Tons"
   FROM Export;

CREATE VIEW Export_Period
AS SELECT Transporter, Ship_Date AS "Shipping Date", Arrival_Date AS "Arrival Date"
   FROM Export
   WHERE Arrival_Date BETWEEN TO_DATE('2021/05/15','YYYY/MM/DD') AND  TO_DATE('2021/06/15','YYYY/MM/DD')
   ORDER BY Arrival_Date ASC;


CREATE VIEW Shippings_Per_Period
AS SELECT (Transporter,Quantity, Ship_Date AS "Shipping Date", Arrival_Date AS "Arrival Date", ( SELECT COUNT(Ship_Date) FROM EXPORT) AS "Total Shippings"
   FROM Export
   WHERE Ship_Date BETWEEN TO_DATE('2021/06/01','YYYY/MM/DD') AND TO_DATE('2021/06/30','YYYY/MM/DD')
   ORDER BY Ship_Date ASC;