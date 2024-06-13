--select * 
--from [data analyst profo].dbo.covidDeath

-- looking at Total Cases vs Total Deaths

--looking at the death rate
--Select continent,Location , date , total_cases, total_deaths, COALESCE(total_deaths/NULLIF(total_cases,0),0)*100 as DeathRates
--from [data analyst profo].dbo.covidDeath

--look at Countries with Highest Infection Rate compared to population
--Select location, population, MAX(total_cases)as Highest_case, Max((total_cases/population))*100 as infectRate
--from [data analyst profo].dbo.covidDeath
--Group by location, population
--order by infectRate desc

--showing Countries with Highest Death Count per Population
--Select Location, Max(total_deaths) as TotalDeathCount
--from [data analyst profo].dbo.covidDeath
--where continent is not null 
--Group by location
--order by TotalDeathCount desc

--break down by continent
--Select continent, Max(cast(total_deaths as int)) as TotalDeathCount
--from [data analyst profo].dbo.covidDeath
--where continent is not null
--Group by continent
--order by TotalDeathCount desc
--offset 1 rows

--daily case and death
--select date , SUM(total_cases)as dailyCase ,SUM(total_deaths) as dailyDeath , COALESCE(SUM(total_deaths)/NULLIF(SUM(total_cases),0),0) as daily_death
--From [data analyst profo].dbo.covidDeath
--where continent is not null
--Group by  date

--total total population vs vaccinations
--select dea.continent, dea.location,dea.date, dea.population, vac.new_vaccinations,
--SUM(CONVERT(INT, vac.new_vaccinations)) OVER(Partition by dea.Location Order by dea.location, dea.Date) as RollingPplVacc
--from [data analyst profo].dbo.covidDeath dea
--join [data analyst profo].dbo.covidVcc vac
--		on dea.location = vac.location
--		and dea.date = vac.date
--where dea.continent is not null
--order by 2,3, 5,6


--CTE
--With PopvsVac(Continent, Location, Date,Poplulation ,New_vaccinations, RollingPplVacc)
--as
--(
--select dea.continent, dea.location,dea.date, dea.population, vac.new_vaccinations,
--SUM(CONVERT(INT, vac.new_vaccinations)) OVER(Partition by dea.Location Order by dea.location, dea.Date) as RollingPplVacc
--from [data analyst profo].dbo.covidDeath dea
--join [data analyst profo].dbo.covidVcc vac
--		on dea.location = vac.location
--		and dea.date = vac.date
--where dea.continent is not null
----order by 2,3, 5,6
--)
--select * , (RollingPplVacc/Poplulation) *100 
--from PopvsVac


--TEMP Table
--DROP table if exists #PercentPopulationVaccinated
--create table #PercentPopulationVaccinated
--(
--continent nvarchar(255),
--location nvarchar(255),
--Date datetime,
--Population numeric,
--new_vaccinations numeric,
--RollingPeopleVaccinated numeric
--)

--Insert into  #PercentPopulationVaccinated
--select dea.continent, dea.location,dea.date, dea.population, vac.new_vaccinations,
--SUM(CONVERT(INT, vac.new_vaccinations)) OVER(Partition by dea.Location Order by dea.location, dea.Date) as RollingPplVacc
--from [data analyst profo].dbo.covidDeath dea
--join [data analyst profo].dbo.covidVcc vac
--		on dea.location = vac.location
--		and dea.date = vac.date
--where dea.continent is not null
--order by 2,3, 5,6


--select * , (RollingPeopleVaccinated/Population) *100 
--from #PercentPopulationVaccinated

--create view 
--Create View PercentPopulationVaccinatedVW as 
--select dea.continent, dea.location,dea.date, dea.population, vac.new_vaccinations,
--SUM(CONVERT(INT, vac.new_vaccinations)) OVER(Partition by dea.Location Order by dea.location, dea.Date) as RollingPplVacc
--from [data analyst profo].dbo.covidDeath dea
--join [data analyst profo].dbo.covidVcc vac
--		on dea.location = vac.location
--		and dea.date = vac.date
--where dea.continent is not null

select * from PercentPopulationVaccinatedVW 

--Vaccinated Rate 
--select dea.continent, MAX(dea.population) as population, MAX(vac.total_vaccinations) as totalVacc, MAX(vac.total_vaccinations)/ MAX(dea.population)*100 as VaccRate
--from [data analyst profo].dbo.covidDeath dea
--join [data analyst profo].dbo.covidVcc vac
--		on dea.location = vac.location
--		and dea.date = vac.date
--where dea.continent is not null
--Group by dea.continent

