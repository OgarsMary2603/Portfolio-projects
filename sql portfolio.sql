SELECT * 
FROM sql_portfolioproject.coviddeathssql
order by 3,4;

SELECT location,date,total_cases,total_deaths, new_cases,population
FROM sql_portfolioproject.coviddeathssql
order by 1,2;

--looking at totaldeaths /totalcases
-- rate of deaths in Africa as a location

SELECT location,date,total_cases,total_deaths,(total_deaths/total_cases)*100 as Dealthpercentage
FROM sql_portfolioproject.coviddeathssql
where location like '%Africa%'
order by 1,2;

--looking at cases vs population
-- shows percentage of population got covid

SELECT location,date,total_cases,population,(total_cases/population)*100 as Casespopulation
FROM sql_portfolioproject.coviddeathssql
where location like '%Africa%'
order by 1,2;

--looking at highest infected rate compared to population
--showing highest population and cases
SELECT location,population,date,max(total_cases) as hightestinfectioncount, max((total_cases/population))*100 as percentpopulationinfected
FROM sql_portfolioproject.coviddeathssql
where location like '%Africa%'
group by location,population
order by percentpopulationinfected desc;

--showing continent with highest death per population 
SELECT location, population, date, max(total_deaths) as Totaldeathcount
FROM sql_portfolioproject.coviddeathssql
where continent is not null
group by location,population
order by Totaldeathcount desc;

-- lets break it down using continent
SELECT continent, max(total_deaths) as Totaldeathcount
FROM sql_portfolioproject.coviddeathssql
where continent is not null
group by location,population
order by Totaldeathcount desc;

--Global Numbers 
SELECT date,total_cases,total_deaths,(total_deaths/total_cases)*100 as Dealthpercentage
FROM sql_portfolioproject.coviddeathssql
where location like '%Africa%'
order by 1,2;

SELECT date,sum(total_cases)  
FROM sql_portfolioproject.coviddeathssql
where location like '%Africa%'
group by date
order by 1,2;

SELECT date,sum(total_cases) ,sum(total_deaths) 
FROM sql_portfolioproject.coviddeathssql
where location like '%Africa%'
group by date
order by 1,2;

SELECT date,sum(total_cases)  ,sum(total_deaths) + sum(new_deaths) as Totaldeath, sum(total_cases) + sum(new_cases) as Totalcases
FROM sql_portfolioproject.coviddeathssql
where location like '%Africa%'
group by date
order by 1,2;

  select *
  from coviddeathssql dea
  join covidvaccinesql vac
  on dea.location = vac.location
  and dea.location = vac.location
  

  select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
  from coviddeathssql dea
  join covidvaccinesql vac
  on dea.location = vac.location
  and dea.location = vac.location
  where dea.continent is not null
  order by 1,2,3
  
  select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
  sum(vac.new_vaccinations) over (partition by dea.location order by dea.location, dea.date) as rollingpeoplevaccinated
  from sql_portfolioproject.coviddeathssql dea
  join sql_portfolioproject.covidvaccinesql vac
  on dea.location = vac.location
  and dea.date = vac.date
  where dea.continent is not null
  order by 2,3
  
