-- Exploratory Data Analysis

SELECT 
    *
FROM
    layoffs_staging2;
---------------------------------------------------------------------------------------------------
--- maximum total laid off ---
 
SELECT 
    MAX(total_laid_off), MAX(percentage_laid_off)
FROM
    layoffs_staging2;
---------------------------------------------------------------------------------------------------
SELECT 
    *
FROM
    layoffs_staging2
WHERE
    percentage_laid_off = 1
ORDER BY funds_raised_millions DESC;
---------------------------------------------------------------------------------------------------
SELECT 
    company, SUM(total_laid_off)
FROM
    layoffs_staging2
GROUP BY company
ORDER BY 2 DESC;
---------------------------------------------------------------------------------------------------
SELECT 
    MIN(`date`), MAX(`date`)
FROM
    layoffs_staging2;
---------------------------------------------------------------------------------------------------
SELECT 
    industry, SUM(total_laid_off)
FROM
    layoffs_staging2
GROUP BY industry
ORDER BY 2 DESC;
---------------------------------------------------------------------------------------------------
SELECT 
    country, SUM(total_laid_off)
FROM
    layoffs_staging2
GROUP BY country
ORDER BY 2 DESC;
---------------------------------------------------------------------------------------------------
SELECT 
    YEAR(`date`), SUM(total_laid_off)
FROM
    layoffs_staging2
GROUP BY YEAR(`date`)
ORDER BY 1 DESC;
---------------------------------------------------------------------------------------------------
SELECT 
    stage, SUM(total_laid_off)
FROM
    layoffs_staging2
GROUP BY stage
ORDER BY 2 DESC;
---------------------------------------------------------------------------------------------------
SELECT 
    company, SUM(percentage_laid_off)
FROM
    layoffs_staging2
GROUP BY company
ORDER BY 2 DESC;
---------------------------------------------------------------------------------------------------
SELECT 
    SUBSTRING(`date`, 1, 7) AS `MONTH`, SUM(total_laid_off)
FROM
    layoffs_staging2
WHERE
    SUBSTRING(`date`, 1, 7) IS NOT NULL
GROUP BY `MONTH`
ORDER BY 1 ASC;

--- CTE process for rollling total ---

with Rolling_Total as
(
select substring(`date`,1,7) as `MONTH`,sum(total_laid_off) as total_off
from layoffs_staging2
where substring(`date`,1,7) IS NOT NULL
group by `MONTH`
order by 1 asc
)
select `MONTH`,total_off,sum(total_off) over(order by `MONTH`) as rolling_total
from Rolling_Total;
---------------------------------------------------------------------------------------------------
select company, sum(total_laid_off)
from layoffs_staging2
group by company
order by 2 desc;

SELECT 
    company, YEAR(`date`), SUM(total_laid_off)
FROM
    layoffs_staging2
GROUP BY company , YEAR(`date`);

with Company_Year (company, years, total_laid_off) as
(
select company, year(`date`), sum(total_laid_off)
from layoffs_staging2
group by company, year(`date`)
), Company_Year_Rank as 
(select *, dense_rank() over (partition by years order by total_laid_off desc) as ranking
from Company_Year
where years is not null
order by ranking asc
)
select * from Company_Year_Rank
where ranking >= 5;