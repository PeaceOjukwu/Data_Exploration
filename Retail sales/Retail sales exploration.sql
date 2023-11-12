---Exploration of Retails sales Dataset
--CUSTOMER SALES ANALYSIS
--1. How does Customer gender affect sales?
select Gender,Count([Total Amount]) as NumberOfSales
from [Data exploration]..retailSales
group by Gender
order by NumberOfSales desc

select Gender,sum([Total Amount]) as TotalSales
from [Data exploration]..retailSales
group by Gender
order by TotalSales desc

select Gender, [Product Category], sum([Total Amount]) as TotalSales
from [Data exploration]..retailSales
where Gender = 'female'
group by Gender, [Product Category]
order by TotalSales desc

select Gender, [Product Category], sum([Total Amount]) as TotalSales
from [Data exploration]..retailSales
where Gender = 'male'
group by Gender, [Product Category]
order by TotalSales desc
-------

--2. How does customer age affect Sales?
select AgeGroup, Count([Total Amount]) as NumberOfSales
from [Data exploration]..retailSales
group by AgeGroup
order by NumberOfSales desc
-------
select AgeGroup, sum([Total Amount]) as Total_sales
from [Data exploration]..retailSales
group by AgeGroup
order by Total_sales desc

--3. Which product are choosen by more customers?
select [Product Category], count([Customer ID]) as NumberOfCustomers
from [Data exploration]..retailSales
group by [Product Category]
--4. Relationship between Age groups and product preference.
----------clothing
select AgeGroup,[Product Category], count([Customer ID]) as NumberOfCustomers
from [Data exploration]..retailSales
where [Product Category] = 'Clothing'
group by AgeGroup, [Product Category]
order by NumberOfCustomers DESC
---------Beauty
select AgeGroup,[Product Category], count([Customer ID]) as NumberOfCustomers
from [Data exploration]..retailSales
where [Product Category] = 'Beauty'
group by AgeGroup, [Product Category]
order by NumberOfCustomers DESC
---------Electronics
select AgeGroup,[Product Category], count([Customer ID]) as NumberOfCustomers
from [Data exploration]..retailSales
where [Product Category] = 'Electronics'
group by AgeGroup, [Product Category]
order by NumberOfCustomers DESC

--5. Customer shopping trends
select Month, sum([Total Amount]) as TotalSales
from [Data exploration]..retailSales
group by Month
order by TotalSales

select Year, sum([Total Amount]) as TotalSales
from [Data exploration]..retailSales
group by Year