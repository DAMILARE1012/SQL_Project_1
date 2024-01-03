SELECT TOP 10 * FROM Portfolio_Project..CovidDeaths$
ORDER BY 3, 4

SELECT TOP 10 * FROM Portfolio_Project..CovidVaccinations$

-- Select only the needed dataset to be used...
SELECT location, date, total_cases, new_cases, total_deaths, population
FROM CovidDeaths$
ORDER BY 1,2 ASC

-- Looking at the Total Cases vs Total Death
-- Shows the likelihood of dying if you contract COVID in your country...
SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases) * 100 AS 'Death Percentage' FROM CovidDeaths$
WHERE location like '%Nigeri%'
ORDER BY 'Death Percentage' DESC

-- Looking at the Total Cases vs Population...
SELECT location, date, total_cases, population, (total_cases/population) * 100 AS 'Death Percentage' 
FROM CovidDeaths$
-- WHERE location LIKE '%states%'
ORDER BY 1,2

SELECT * INTO #temp_table FROM CovidDeaths$
WHERE continent IS NOT NULL
ORDER BY continent ASC

SELECT * FROM #temp_table


-- Looking at Countries with Highest Infection Rate Compared to Population
SELECT location, population, MAX(total_cases) as HighestInfectionCount, MAX((total_cases/population)*100) AS PercentPopulationInfected
FROM CovidDeaths$
GROUP BY location, population
ORDER BY PercentPopulationInfected DESC

-- Looking at Countries with Highest Infection Rate Compared to Population
SELECT location, population, MAX(CAST(total_deaths as int)) as HighestDeathCount, MAX((total_deaths/population)*100) AS PercentPopulationDeath
FROM #temp_table
GROUP BY location, population
ORDER BY HighestDeathCount DESC

-- Let's break things down by continent...
SELECT continent, SUM(total_cases) as 'Total Case Count', SUM(CAST(total_deaths as int))as 'Total Death Count' FROM #temp_table
GROUP BY continent
ORDER BY 3 DESC

-- Global Numbers--
SELECT date, SUM(total_cases) AS Total_Cases, SUM(cast(total_deaths as int)) as Total_Deaths, (SUM(cast(total_deaths as int))/SUM(total_cases)) * 100 as Death_Percent FROM CovidDeaths$
WHERE total_cases IS NOT NULL OR total_deaths IS NOT NULL
GROUP BY date
ORDER BY date ASC


SELECT date, SUM(new_cases) AS New_Cases, SUM(cast(new_deaths as int)) as New_Deaths, (SUM(cast(new_deaths as int))/SUM(new_cases)) * 100 AS Death_Percent FROM CovidDeaths$
WHERE continent IS NOT NULL
GROUP BY date
ORDER BY date ASC

SELECT SUM(new_cases) AS New_Cases, SUM(cast(new_deaths as int)) as New_Deaths, (SUM(cast(new_deaths as int))/SUM(new_cases)) * 100 AS Death_Percent FROM CovidDeaths$
WHERE continent IS NOT NULL


SELECT TOP 10 * FROM CovidDeaths$

SELECT TOP 10 * FROM CovidVaccinations$


-- Join the two tables together...
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(cast(vac.new_vaccinations as int)) OVER (Partition by dea.Location  Order by dea.location, dea.date) as RollingPeoplevaccinated
FROM CovidDeaths$ AS dea
JOIN CovidVaccinations$ AS vac
ON dea.location = vac.location 
AND dea.date = vac.date
WHERE dea.continent IS NOT NULL
ORDER BY 2,3

-- Create views to store data for later visualization...