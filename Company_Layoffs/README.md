
# Company Layoffs Analysis

This repository contains the data cleaning and exploratory data analysis (EDA) processes performed on a dataset of company layoffs. The project aims to provide insights into trends and patterns in layoffs across various industries, locations, and company stages.

## Table of Contents
1. [Overview](https://github.com/Siddhishastri/Python_Projects/tree/main/Zomato_Data_Analysis#project-overview)
2. Dataset Description
3. Goals and Objectives
4. SQL Workflow

### Overview

In recent times, company layoffs have made headlines globally, impacting various industries and economies. This project explores a dataset detailing layoffs to uncover key insights and trends using SQL for data cleaning and EDA. The focus is to analyze the effects of layoffs on industries, locations, and company performance indicators like funds raised.

### Dataset Description

The dataset contains the following attributes:

+ company - Name of the company that conducted layoffs
+ location - City/region where the layoffs occurred
+ industry - Industry of the company
+ total_laid - Total number of employees laid off
+ percentage_laid_off - Percentage of the workforce laid off
+ date - Date of the layoffs
+ stage - Stage of the company (e.g., startup, established, unicorn)
+ country - Country where the layoffs occurred
+ funds_raised_millions - Total funding raised by the company (in millions of USD)

### Goals and Objectives
+ Clean the dataset: Handle missing values, remove duplicates, standardize columns, and address inconsistencies.

+ Perform EDA:
  + Identify trends in layoffs over time.
  + Analyze layoffs by industry, company stage, and location.
  + Explore the relationship between layoffs and funding raised.

### SQL Workflow
1. Data Cleaning:
+ Remove duplicates.
+ Handle missing or inconsistent values (e.g., funds raised missing for certain companies).
+ Standardize date formats.

2. EDA Steps:
+ Trends in layoffs over time (date analysis).
+ Top industries and companies affected by layoffs.
+ Relationship between funding raised and layoff percentage.
+ Geographical distribution of layoffs by country and location.
+ Insights and Visualizations
