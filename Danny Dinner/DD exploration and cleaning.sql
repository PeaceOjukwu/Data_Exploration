---Viewing the tables
Select*
From DD..members as A
inner join sales as B
on A.customer_id=B.customer_id
inner join menu as C
on C.product_id=B.product_id
------Data Cleaning
----Convertion of dates from nvarchar to date and prices from nvarchar to money
Alter table DD..sales
Alter Column Prices money

Alter table DD..sales
Alter Column Order_date date

Alter table DD..members
Alter Column join_date date

Alter table DD..menu
Alter Column Price money


----Exploration
--What is the total amount esch customer spent at the restuarant
Select customer_id,sum(Prices) as Total_price
From DD..sales
group by customer_id

--Number of days each customer visited
Select customer_id, count(Distinct order_date) as Number_of_days
From DD..sales
group by customer_id

---First item purchased by each customer
Select A.customer_id,B.product_name, 
(	Select Min(order_date)
	From DD..sales) as First_day
From DD..sales as A
inner join menu as B
on A.product_id=B.product_id 
group by customer_id, product_name

---Most purchased item on the menu and number of times the items was purchased
Select product_name, count(order_date) as Number_of_Days
From DD..menu as M
inner join sales as S
on S.product_id= M.product_id
group by product_name
order by Number_of_Days desc

--Most popular Item for each customer
Select customer_id,product_name, count(order_date) as Number_of_Purchases
From DD..menu as M
inner join sales as S
on S.product_id= M.product_id
group by customer_id,product_name
order by Number_of_Purchases desc

---Which Item was purchased first by customers when they became members
WITH customer_membership AS (
    SELECT
        M.customer_id,
        mm.product_name,
        MIN(S.order_date) AS first_order,
        Row_number() OVER (PARTITION BY M.customer_id ORDER BY MIN(S.order_date)) AS Row_no
    FROM DD..members AS M
        JOIN sales AS S ON M.customer_id = S.customer_id
        JOIN menu AS mm ON mm.product_id = S.product_id
	where join_date<order_date
    GROUP BY
        M.customer_id,
        mm.product_name,
        S.order_date,order_date
)
SELECT customer_id, product_name, first_order
FROM customer_membership
WHERE Row_no = 1

---Which Item was purchased by customers before they became members
WITH customer_membership AS (
    SELECT
        M.customer_id,
        mm.product_name,
        Max(S.order_date) AS first_order,
        Dense_rank() OVER (PARTITION BY M.customer_id ORDER BY MIN(S.order_date)) AS rank_no
    FROM DD..members AS M
        JOIN sales AS S ON M.customer_id = S.customer_id
        JOIN menu AS mm ON mm.product_id = S.product_id
	where join_date>order_date
    GROUP BY
        M.customer_id,
        mm.product_name,
        S.order_date,order_date
)
SELECT customer_id, product_name, first_order
FROM customer_membership

--Total items and amount spent for each memeber before they became members
Select M.customer_id,Count(mm.product_name) as No_product, 
		sum(mm.price) as Total_price
FROM DD..members AS M
        JOIN sales AS S ON M.customer_id = S.customer_id
        JOIN menu AS mm ON mm.product_id = S.product_id
		where join_date>order_date
		Group by M.customer_id

--If each 1dollar spent equates 10 points and sushi has a 2x points multiplier, how many points would each customer have?
Select s.customer_id,
	sum(case when m.product_name= 'sushi' then s.Prices *2*10
	else s.prices *10 end) as Points
From DD..sales as S
Right join menu as m
on m.product_id=s.product_id
Group by customer_id


--In the first week after a customer joins the program(including their join date)

--they earn 2x points on all items, not just sushi-How many points do customer A and B have at the end of January




---Creat new table that has customer id,order date, product name,price and memebership

Select S.customer_id, S.order_date, MM.product_name, S.Prices
into Danny_resturant
from DD..members as M
Right join sales as S on M.customer_id= S.customer_id
Join menu as MM on MM.product_id=s.product_id 

-- Add the membership column to the existing table
ALTER TABle Danny_resturant
ADD membership VARCHAR(255) -- Specify the appropriate data type and length

-- Update the values in the membership column
UPDATE[Danny_resturant]
SET membership = 
(
Case when join_date > order_date then 'No'
	 when join_date < order_date then 'Yes'
	 else 'No' end)
From DD..Danny_resturant as dany
LEFT join members as mm
on mm.customer_id=dany.customer_id

Select*
from DD..Danny_resturant


