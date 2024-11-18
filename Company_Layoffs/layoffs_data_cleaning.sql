-- Data Cleaning --
SELECT 
    *
FROM
    layoffs;

-- 1. Remove Duplicates
-- 2. Standardize the Data
-- 3. Null Values and Blank Values
-- 4. Remove any Columns

CREATE TABLE layoffs_staging LIKE layoffs;

SELECT 
    *
FROM
    layoffs_staging;

insert layoffs_staging
select * from layoffs;

-- 1. Remove Duplicates

select *, 
ROW_NUMBER() OVER(
PARTITION BY company, industry, total_laid_off, percentage_laid_off, 'date'
) AS row_num
from layoffs_staging;
---------------------------------------------------------------------------------------------------
with duplicate_cte AS
(
select *, 
ROW_NUMBER() OVER(
PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, 
'date', stage, country) AS row_num
from layoffs_staging
)
select * 
from duplicate_cte
WHERE row_num > 1;
---------------------------------------------------------------------------------------------------
SELECT 
    *
FROM
    layoffs_staging
WHERE
    company = 'oda';
---------------------------------------------------------------------------------------------------
with duplicate_cte AS
(
select *, 
ROW_NUMBER() OVER(
PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, 'date', stage, country) AS row_num
from layoffs_staging
)
delete 
from duplicate_cte
where row_num > 1;
---------------------------------------------------------------------------------------------------
CREATE TABLE `layoffs_staging2` (
    `company` TEXT,
    `location` TEXT,
    `industry` TEXT,
    `total_laid_off` INT DEFAULT NULL,
    `percentage_laid_off` TEXT,
    `date` TEXT,
    `stage` TEXT,
    `country` TEXT,
    `funds_raised_millions` INT DEFAULT NULL,
    `row_num` INT
)  ENGINE=INNODB DEFAULT CHARSET=UTF8MB4 COLLATE = UTF8MB4_0900_AI_CI;
---------------------------------------------------------------------------------------------------
SELECT 
    *
FROM
    layoffs_staging2;
---------------------------------------------------------------------------------------------------
INSERT INTO layoffs_staging2
SELECT *, 
ROW_NUMBER() OVER(
PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, 'date', 
stage, country) AS row_num
from layoffs_staging;
---------------------------------------------------------------------------------------------------
SET SQL_SAFE_UPDATES = 0;
DELETE FROM layoffs_staging2 
WHERE
    row_num > 1;

select * from layoffs_staging2
where row_num > 1;
---------------------------------------------------------------------------------------------------
-- 2. Standardize the Data

select company, trim(company)
from layoffs_staging2;
---------------------------------------------------------------------------------------------------
UPDATE layoffs_staging2 
SET 
    company = TRIM(company);
---------------------------------------------------------------------------------------------------
SELECT DISTINCT
    industry
FROM
    layoffs_staging2
ORDER BY 1;
---------------------------------------------------------------------------------------------------
SELECT 
    *
FROM
    layoffs_staging2
WHERE
    industry LIKE 'crypto%';
---------------------------------------------------------------------------------------------------
UPDATE layoffs_staging2 
SET 
    industry = 'Crypto'
WHERE
    industry LIKE 'Crypto%';
---------------------------------------------------------------------------------------------------
SELECT DISTINCT
    industry
FROM
    layoffs_staging2;
---------------------------------------------------------------------------------------------------
SELECT DISTINCT
    location
FROM
    layoffs_staging2
ORDER BY 1;
---------------------------------------------------------------------------------------------------
SELECT DISTINCT
    country
FROM
    layoffs_staging2
ORDER BY 1;
---------------------------------------------------------------------------------------------------
SELECT DISTINCT
    country, TRIM(TRAILING '.' FROM country)
FROM
    layoffs_staging2
ORDER BY 1;
---------------------------------------------------------------------------------------------------
UPDATE layoffs_staging2 
SET 
    country = TRIM(TRAILING '.' FROM country)
WHERE
    country LIKE 'United States%';
---------------------------------------------------------------------------------------------------
-- date --

SELECT 
    `date`, STR_TO_DATE(`date`, '%m/%d/%Y')
FROM
    layoffs_staging2;

UPDATE layoffs_staging2 
SET 
    `date` = STR_TO_DATE(`date`, '%m/%d/%Y');
---------------------------------------------------------------------------------------------------
SELECT 
    `date`
FROM
    layoffs_staging2;

alter table layoffs_staging2 
modify column `date` DATE;
---------------------------------------------------------------------------------------------------
-- 3. Null Values and Blank Values

UPDATE layoffs_staging2 
SET 
    industry = NULL
WHERE
    industry = '';
---------------------------------------------------------------------------------------------------
SELECT 
    *
FROM
    layoffs_staging2
WHERE
    industry IS NULL OR industry = '';
---------------------------------------------------------------------------------------------------
SELECT 
    *
FROM
    layoffs_staging2
WHERE
    company = 'Airbnb';
---------------------------------------------------------------------------------------------------
SELECT 
    t1.industry, t2.industry
FROM
    layoffs_staging2 t1
        JOIN
    layoffs_staging2 t2 ON t1.company = t2.company
        AND t1.location = t2.location
WHERE
    (t1.industry IS NULL OR t1.industry = '')
        AND t2.industry IS NOT NULL;
---------------------------------------------------------------------------------------------------
UPDATE layoffs_staging2 t1
        JOIN
    layoffs_staging2 t2 ON t1.company = t2.company 
SET 
    t1.industry = t2.industry
WHERE
    (t1.industry IS NULL OR t1.industry = '')
        AND t2.industry IS NOT NULL;
---------------------------------------------------------------------------------------------------
UPDATE layoffs_staging2 t1
        JOIN
    layoffs_staging2 t2 ON t1.company = t2.company 
SET 
    t1.industry = t2.industry
WHERE
    t1.industry IS NULL
        AND t2.industry IS NOT NULL;
---------------------------------------------------------------------------------------------------
-- 4. Remove any Columns

SELECT 
    *
FROM
    layoffs_staging2
WHERE
    total_laid_off IS NULL
        AND percentage_laid_off IS NULL;
---------------------------------------------------------------------------------------------------
DELETE FROM layoffs_staging2 
WHERE
    total_laid_off IS NULL
    AND percentage_laid_off IS NULL;
---------------------------------------------------------------------------------------------------
alter table layoffs_staging2
drop column row_num;
