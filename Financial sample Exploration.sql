---Financial Sample Report


select Year
from [Data exploration]..[Financial Sample]
Group by Year----Financial Sample Report between 2013 and 2014
----Financial sales report between 5 countires, 5segments and 6 products
----Total Sales at 118,726,350.26 Dollars
----Profit at 16,893,702.26 Dollars
----Total Discount 9,205,248.24 Dollars
----USA showing Highest sales  but with France as Highest Profit Made by country
	--This is because of the high difference of Cost of Goods sold
		--Therefore reducing the profit made despite the high sales.

select Segment
from [Data exploration]..[Financial Sample]
group by Segment  ----------------------Total of 5 Segments within 5 countries

select Country
from [Data exploration]..[Financial Sample]
group by Country--------------------Total of 5 countries

select Product
from [Data exploration]..[Financial Sample]
group by Product--------------------Total of 6 Products

----------------------------------- Total Sales at 118,726,350.26 Dollars
select Sum ([ Sales]) as TotalSales
from [Data exploration]..[Financial Sample]

-----------------------------------Total Profit at 16,893,702.26 Dollars
select Sum (Profit) as TotalProfit
from [Data exploration]..[Financial Sample]

-----Sales by segment, Year, Country and Products

----Total sales by Year

select Segment,Sum ([ Sales]) as TotalSales
from [Data exploration]..[Financial Sample]
where year=2013
group by Segment
order by TotalSales desc---Sales by Segment in 2013

select Segment,Sum ([ Sales]) as TotalSales
from [Data exploration]..[Financial Sample]
where year=2014
group by Segment
order by TotalSales desc---Sales by Segment in 2014

select year,Sum ([ Sales]) as TotalSales
from [Data exploration]..[Financial Sample]
group by Year
order by TotalSales desc------With Highest Sales made in 2014; 92,311,094.75Dollars

-----Total Sales by Country
select Country,Sum ([ Sales]) as TotalSales
from [Data exploration]..[Financial Sample]
group by Country
order by TotalSales desc-----with Highest sales made in the United States of America

select Country,year,Sum ([ Sales]) as TotalSales
from [Data exploration]..[Financial Sample]
group by Country, Year
order by TotalSales desc----USA having the highest sales in 2014 and Germany having highest Sales in 2013


----Total sales by Product
select Product,Sum ([ Sales]) as TotalSales
from [Data exploration]..[Financial Sample]
group by Product
order by TotalSales desc-----with highest sales made with the product Paseo

select Product,year,Sum ([ Sales]) as TotalSales
from [Data exploration]..[Financial Sample]
group by Product, Year
order by TotalSales desc---2014;Paseo has the highest sales while Velo has the highest sales in 2013

---Total sales by Segments
select Segment,Sum ([ Sales]) as TotalSales
from [Data exploration]..[Financial Sample]
group by Segment
order by TotalSales desc----Government having the Total highest sales

select Segment,Product,Sum ([ Sales]) as TotalSales
from [Data exploration]..[Financial Sample]
where Segment='government'
group by Segment,Product
order by TotalSales desc---Total sales in government sector with its highest in product Paseo and least in Montana

select Country,product,Sum ([ Sales]) as TotalSales
from [Data exploration]..[Financial Sample]
group by Country, Product
order by TotalSales desc
---Per product, Mexico has the largest sale of Paseo, 
---USA has the highest sales of VTT and montana
---France has the highest sale of Amarilla and Carretera
---Germerny has then highest sales of Velo
-----------------------------------------------------------------

-----Total Profit by Year, Country,segment and Product 
--By Year
select Year, sum(profit) as Total_Profit
from [Data exploration]..[Financial Sample]
group by Year
order by Total_Profit desc---Total profit in 2013-3,878,464.51 and 2014-13,015,237.75
---with 2014 having the highest profit.
select Year, sum([ Sales])as Total_Sales,sum(profit) as Total_Profit
from [Data exploration]..[Financial Sample]
group by Year
order by Total_Profit desc
---Therefore Increase in Yearly sales is proportional to increase in Profit

--By Segment
select Segment, sum(profit) as Total_Profit
from [Data exploration]..[Financial Sample]
group by Segment
order by Total_Profit desc-----Just like sales Govenment has the highest Profit

--By Country
select Country,Sum ([ Sales]) as TotalSales,sum(profit) as Total_Profit
from [Data exploration]..[Financial Sample]
group by Country
order by Total_Profit desc
--USA showing Highest sales  but with France as Highest Profit Made
	select Country,sum(COGS)as Total_COGS, sum([Sale Price]) as Total_SalePrice,Sum ([ Sales]) as TotalSales,sum(profit) as Total_Profit
	from [Data exploration]..[Financial Sample]
	group by Country
	order by Total_Profit desc
---This is because of the high difference between Total Sales and Total Cost of Goods sold
		--Therefore reducing the profit made despite the high sales


----Discount
Select SUM(Discounts) as Total_Discount
from [Data exploration]..[Financial Sample]

--Discount increase
select Segment,Sum([ Sales]) as Total_Sales,Sum(Discounts) as Total_Discount
from [Data exploration]..[Financial Sample]
group by Segment
order by Total_Discount desc----Discount increase is proportional to sales increase