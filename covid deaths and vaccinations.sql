select*
from [Data exploration Covid]..['COVID DEATHS']
order by 3,4
select*
from [Data exploration Covid]..COVID_VACCINATIONS
order by 3,4

select location, date, total_cases, new_cases, total_deaths, population
from [Data exploration Covid]..['COVID DEATHS']
order by 1,2


--Converting total deaths, total case, new case to integer data type

alter table [Data exploration Covid]..['COVID DEATHS']
add Total_casesConvert int
update [Data exploration Covid]..['COVID DEATHS']
set Total_casesConvert=convert(int, total_cases)

alter table [Data exploration Covid]..['COVID DEATHS']
add Total_deathConvert int
update [Data exploration Covid]..['COVID DEATHS']
set Total_deathConvert=convert(int, total_deaths)


alter table [Data exploration Covid]..['COVID DEATHS']
add new_casesConvert int
update [Data exploration Covid]..['COVID DEATHS']
set new_casesConvert=convert(int, new_cases)


--Total cases vs Total death
select location, date, total_casesConvert, total_deathConvert
from [Data exploration Covid]..['COVID DEATHS']
order by 1,2
--Percentage of deaths
--liklihood of contamination by country
select location, date, Total_casesConvert, Total_deathConvert,cast(Total_deathConvert as decimal)/(Total_casesConvert)*100 as PercentageDeath
from [Data exploration Covid]..['COVID DEATHS']
where location like 'nigeria%'
order by 1,2


--Total cases vs population
select location, date, total_casesConvert, population
from [Data exploration Covid]..['COVID DEATHS']
order by 1,2
--Percentage of cases per population
select location, date, Total_casesConvert,cast(Total_casesConvert as decimal)/(population)*100 as percentageCases
from [Data exploration Covid]..['COVID DEATHS']
where location like 'nigeria%'
order by 1,2


--Countries with highest infection rate per population
select location,max(Total_casesConvert) as HighestInfectionRate, population,max(cast(Total_casesConvert as decimal)/(population)*100) as percentageCases
from [Data exploration Covid]..['COVID DEATHS']
group by population, location
order by percentageCases desc

---Countries with highest death count per population
select location,max(Total_deathConvert) as HighestDeathRate, population
from [Data exploration Covid]..['COVID DEATHS']
where continent is not null
group by population, location
order by HighestDeathRate desc
--continent with the highest death count
select continent,max(Total_deathConvert) as HighestDeathRate
from [Data exploration Covid]..['COVID DEATHS']
where continent is not null
group by continent
order by HighestDeathRate desc



---New cases and new deaths across the world
select date, location,sum(new_cases) as TotalNewCases, sum(new_deaths) as TotalNewDeaths
from [Data exploration Covid]..['COVID DEATHS']
where continent is not null
group by date, location
order by date desc



----COVID VACCINATIONS
SELECT*
FROM [Data exploration Covid]..COVID_VACCINATIONS

--Areas with new vaccinations and count of vaccinations
SELECT CD.continent, CD.location, CD.date, CD.population, cv.new_vaccinations
FROM [Data exploration Covid]..COVID_VACCINATIONS AS CV
JOIN [Data exploration Covid]..['COVID DEATHS'] AS CD
ON CV.date=CD.date
AND CV.location=CD.location
where cd.continent is not null
order by continent, location, date

--Rolling New Vaccinations
SELECT CD.continent, CD.location, CD.date, CD.population, cv.new_vaccinations,
sum(cast(cv.new_vaccinations as int)) over (partition by CD.location order by CD.location, CD.date) as RollingNewVaccinations
FROM [Data exploration Covid]..COVID_VACCINATIONS AS CV
JOIN [Data exploration Covid]..['COVID DEATHS'] AS CD
ON CV.date=CD.date
AND CV.location=CD.location
where cd.continent is not null
order by continent, location, date


--Percentage of Rolling Vaccination

with RollVacc (continent, location, date,population, new_vaccinations, RollingNewVaccinations) as 
(SELECT CD.continent, CD.location, CD.date, CD.population, cv.new_vaccinations,
sum(cast(cv.new_vaccinations as int)) over (partition by CD.location order by CD.location, CD.date) as RollingNewVaccinations
FROM [Data exploration Covid]..COVID_VACCINATIONS AS CV
JOIN [Data exploration Covid]..['COVID DEATHS'] AS CD
ON CV.date=CD.date
AND CV.location=CD.location
where cd.continent is not null)
Select*, (RollingNewVaccinations/population)*100 as percentRollingVaccine
from RollVacc