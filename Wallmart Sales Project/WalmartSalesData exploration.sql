--Walmart Sales Analysis
-----

---Modifying table to give time of day; Morning, afternoon and night

update [Walmart Sales]..WalmartSalesData
set Time= cast(time as time)

select 
 time,
    (case 
  when time between '00:00:00' and '12:00:00' then 'Morning'
  when time between '12:01:00' and '16:00:00' then 'Afternoon'
  else  'Evening' end) As time_of_day
from [Walmart Sales]..WalmartSalesData 

alter table [Walmart Sales]..WalmartSalesData 
add time_of_day varchar (30)
update [Walmart Sales]..WalmartSalesData
set time_of_day= ( case 
  when time between '00:00:00' and '12:00:00' then 'Morning'
  when time between '12:01:00' and '16:00:00' then 'Afternoon'
        else  'Evening' end)

----setting Date as Date only
select Date, cast(Date as date) as Date
from [Walmart Sales]..WalmartSalesData
update [Walmart Sales]..WalmartSalesData
set Date=cast(date as date)

----Adding new column that shows month name
select Date, DateName(Month,date) as MonthName
from [Walmart Sales]..WalmartSalesData
alter table [Walmart Sales]..WalmartSalesData 
add MonthName varchar (30)
update [Walmart Sales]..WalmartSalesData
set MonthName= DateName(Month,date)

----Adding new column that shows Day name
select Date, DateName(WEEKDAY,date) as DayName
from [Walmart Sales]..WalmartSalesData
alter table [Walmart Sales]..WalmartSalesData 
add DayName varchar (30)
update [Walmart Sales]..WalmartSalesData
set DayName= DateName(WEEKDAY,date)

----Exploratory Data Analysis

--cities
select distinct City
from [Walmart Sales]..WalmartSalesData

---Braches in city
select distinct Branch, City
from [Walmart Sales]..WalmartSalesData

---Customer Type
select distinct [Customer type]
from [Walmart Sales]..WalmartSalesData

---Prouct line
select distinct [Product line]
from [Walmart Sales]..WalmartSalesData


--------PRODUCT AND SALES ANALYSIS

---Total sales
select sum(Total) as TotalSales
from [Walmart Sales]..WalmartSalesData

----Most used Payment method
select Payment, Count(Payment) as CountPayment
from [Walmart Sales]..WalmartSalesData
group by Payment

----Most selling product line
select [Product line], Count([Product line]) as CountProduct
from [Walmart Sales]..WalmartSalesData
group by [Product line]
order by CountProduct desc

---Quantity of Product sold
select [Product line], sum([Quantity]) as TotalQuantity
from [Walmart Sales]..WalmartSalesData
group by [Product line]
order by [TotalQuantity] desc

----Sales by product
select [Product line], sum([Total]) as TotalSales
from [Walmart Sales]..WalmartSalesData
group by [Product line]
order by TotalSales desc

----Sales by City
select [City], sum([Total]) as TotalSales
from [Walmart Sales]..WalmartSalesData
group by [City]
order by [TotalSales] desc

-----Sales by Time of day
select time_of_day,sum([Total]) as TotalSales
from [Walmart Sales]..WalmartSalesData
Group by time_of_day
order by TotalSales desc

----Sales by Month of year
select MonthName,sum([Total]) as TotalSales
from [Walmart Sales]..WalmartSalesData
Group by MonthName
order by TotalSales desc

---Sales by  MonthName and DayName
select MonthName,DayName,sum([Total]) as TotalSales
from [Walmart Sales]..WalmartSalesData
Group by MonthName, DayName
order by MonthName

----Number of Sales per day
select time_of_day,count([Total]) as SalesNumber
from [Walmart Sales]..WalmartSalesData
where DayName = 'Friday'
Group by time_of_day
order by SalesNumber desc

------City with the most vat
select
 city,
    round(avg([Tax 5%]), 2) as value_added_tax
from [Walmart Sales]..WalmartSalesData
group by city
order by value_added_tax desc;

------------CUSTOMER ANALYSIS----------------------------------

---Customer Type
select distinct [Customer type]
from [Walmart Sales]..WalmartSalesData

----Most Cutomer type 
select [Customer type], Count([Customer type]) as CountCustomer
from [Walmart Sales]..WalmartSalesData
group by [Customer type]
order by CountCustomer desc

-------Gender of most Customers
select [Gender], Count([Gender]) as CntGender
from [Walmart Sales]..WalmartSalesData
group by [Gender]

----Most Sales by gender
select [Gender], Sum([Total]) as TotalSales
from [Walmart Sales]..WalmartSalesData
group by [Gender]
order by TotalSales desc


--------------------PROFIT--------------
select sum([Tax 5%]+cogs) as total_grass_sales
from  [Walmart Sales]..WalmartSalesData

----- gross profit-----------
SELECT  SUM(Total - COGS) AS Profit 
FROM [Walmart Sales]..WalmartSalesData

----Profit by City and branch
SELECT  City,[Product line],SUM(Total - COGS) AS Profit 
FROM [Walmart Sales]..WalmartSalesData
group by City, [Product line]
order by City
