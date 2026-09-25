select *
FROM `saas startup`;

RENAME  TABLE `saas startup`
TO saas_startup;

SHOW TABLES;

select *
FROM saas_startup;

SELECT monthlyRevenueUSD
FROM saas_startup
LIMIT 10;

#/-How many startups are in the dataset?

SELECT COUNT(*) AS total_startups
FROM saas_startup;
#Results:47 startups

#/-What is the total momthly revenue?
SELECT SUM(monthlyRevenueUSD) AS total_monthly_Revenue
FROM saas_startup;
#Results:$559867
-- Insight: This figure represents the combined monthly revenue of all startups
-- in the dataset and provides a baseline for evaluating overall market size.

#/- What is the average monthly revenue?
SELECT AVG(monthlyRevenueUSD) AS  avg_monthly_revenue
FROM saas_startup;
#Results:On average, each startup generates approximately $11,912 in monthly
-- revenue. However, this average may be influenced by a few high-revenue startups,
-- so it is worth comparing it with the median or examining the revenue distribution. 

#/- Which startups generate the highest monthly revenue?

SELECT name,
       monthlyRevenueUSD
FROM saas_startup
ORDER BY monthlyRevenueUSD DESC
LIMIT 10;
-- Insight:
-- Custom Software Development is the highest-earning startup in the dataset,
-- generating $500,000 in monthly revenue. The second-highest startup generates
-- $15,000 per month, indicating a significant gap between the top performer
-- and the rest of the startups. This suggests that revenue is highly concentrated
-- among a small number of businesses.

-- Question 5: Which industries do the top 10 highest-revenue startups belong to?

SELECT name,
       verticals,
       monthlyRevenueUSD
FROM saas_startup
ORDER BY monthlyRevenueUSD DESC
LIMIT 10;

-- Insight:
-- AI appears in most of the top-performing startups, either as the
-- primary industry or as one of the associated verticals. SaaS and
-- B2B business models are also common among the highest revenue
-- generators, suggesting these sectors have strong commercial
-- potential. This may indicate that AI-powered SaaS solutions are
-- attracting significant customer demand and generating substantial
-- recurring revenue.

-- Which revenue models are used by the highest revenue startups?


SELECT name,
       verticals,
       revenueModels,
       monthlyRevenueUSD
FROM saas_startup
ORDER BY monthlyRevenueUSD DESC
LIMIT 10;
-- Insight:
-- Consulting and subscription are the most common revenue models among
-- the highest-earning startups. The highest-revenue startup
-- (Custom Software Development) relies on consulting, while several
-- AI startups generate recurring revenue through subscriptions.
-- This suggests that both consulting services and subscription-based
-- business models can be effective strategies for generating revenue.

-- Question 5: Which industries do the top 10 lowest-revenue startups belong to?

SELECT verticals,
       COUNT(*) AS startup_count
FROM (
    SELECT verticals
    FROM saas_startup
    ORDER BY monthlyRevenueUSD ASC
    LIMIT 10
) AS lowest10
GROUP BY verticals
ORDER BY startup_count DESC;

#-Analysis:--The ten lowest-revenue startups span a wide range of industries. 

-- Majorityt are AI-related businesses combined with sectors 
--such as education, analytics, privacy, APIs, cryptocurrency, transportation, and SaaS
--Since the dataset stores multiple industries in a single field, 
--each startup has a unique combination of industry tags, 
--resulting in each combination appearing only once.

SELECT name,
       COUNT(*) AS occurrences
FROM saas_startup
GROUP BY name
HAVING COUNT(*) > 1;

SELECT *
FROM saas_startup
WHERE name = 'Revenue Multiplication Engine';

SHOW COLUMNS FROM saas_startup;
SELECT name,
       COUNT(*) AS occurrences
FROM saas_startup
GROUP BY name
HAVING COUNT(*) > 1;


SELECT productId,
    name,
    monthlyRevenueUSD,
    revenueModels,
    websiteUrl,
       COUNT(*) AS occurrences
FROM saas_startup
GROUP BY
    productId,
    name,
    monthlyRevenueUSD,
    revenueModels,
    websiteUrl
HAVING COUNT(*) > 1;

SELECT
    SUM(name IS NULL OR name = '') AS missing_name,
    SUM(productId IS NULL OR productId = '') AS missing_productId,
    SUM(verticals IS NULL OR verticals = '') AS missing_verticals,
    SUM(revenueModels IS NULL OR revenueModels = '') AS missing_revenueModels,
    SUM(monthlyRevenueUSD IS NULL) AS missing_monthlyRevenueUSD,
    SUM(websiteUrl IS NULL OR websiteUrl = '') AS missing_websiteUrl
FROM saas_startup;


#-Platform Analysis
#-Which platforms are most common?

SELECT monthlyRevenueUSD
FROM saas_startup
LIMIT 10;

SELECT *
FROM saas_startup;

SELECT platforms,
       name
FROM saas_startup;
-- Question: Which platform combinations are most common?


-- Result:
-- Web is the most common platform, used by 19 startups. Several startups
-- also support multiple platforms, including Android, iOS, desktop,
-- browser, and PC.

-- Business Insight:
-- Web is the dominant platform among startups in the dataset, suggesting
-- that most companies prioritize browser-based accessibility. A smaller
-- number of startups invest in multi-platform deployment, supporting
-- mobile, desktop, and web applications to reach a broader audience.
-- Question: Which platforms are most commonly used by startups?

SELECT 'Web' AS platform, COUNT(*) AS startup_count
FROM saas_startup
WHERE platforms LIKE '%web%'

UNION ALL

SELECT 'Mobile', COUNT(*)
FROM saas_startup
WHERE platforms LIKE '%mobile%'

UNION ALL

SELECT 'Android', COUNT(*)
FROM saas_startup
WHERE platforms LIKE '%android%'

UNION ALL

SELECT 'iOS', COUNT(*)
FROM saas_startup
WHERE platforms LIKE '%ios%'

UNION ALL

SELECT 'Desktop', COUNT(*)
FROM saas_startup
WHERE platforms LIKE '%desktop%'

UNION ALL

SELECT 'Browser', COUNT(*)
FROM saas_startup
WHERE platforms LIKE '%browser%'

UNION ALL

SELECT 'PC', COUNT(*)
FROM saas_startup
WHERE platforms LIKE '%pc%'

UNION ALL

SELECT 'Mac', COUNT(*)
FROM saas_startup
WHERE platforms LIKE '%mac%'

ORDER BY startup_count DESC;
-- VC Insight:
-- The dominance of web platforms suggests that startups prefer
-- browser-based applications because they are generally less expensive
-- to develop, easier to maintain, and can reach users across multiple
-- operating systems. As startups scale, many expand to Android and iOS
-- to increase market reach and improve customer engagement.

-- Question: Which platform combinations have the highest average monthly revenue?

SELECT platforms,
       AVG(monthlyRevenueUSD) AS average_monthly_revenue,
       COUNT(*) AS startup_count
FROM saas_startup
GROUP BY platforms
ORDER BY average_monthly_revenue DESC;


-- Result:
-- The platform combination "android,browser,desktop,ios,mac,mobile,pc,web"
-- has the highest average monthly revenue ($75,500), but it is based on
-- only two startups.

-- Business Insight:
-- Although the highest average revenue is associated with startups that
-- support every major platform, this finding is based on a very small
-- sample. In contrast, web-based startups have an average monthly revenue
-- of approximately $27,403 across 19 startups, making web the strongest
-- platform combination in terms of both revenue and representation.

#-AI Startup Analysis
SELECT COUNT(*)
FROM saas_startup
WHERE verticals LIKE  '%ai%';  
-- Result:
-- Out of 47 startups, 34 are AI-related.

-- Business Insight:
-- AI is the dominant technology theme in the dataset, representing
-- approximately 72% of all startups. This indicates a strong concentration
-- of innovation around artificial intelligence and suggests that AI
-- continues to be a major focus for startup founders and investors.   

SELECT 
COUNT(*) AS ai_startups,
SUM(monthlyRevenueUSD) AS total_ai_revenue,
AVG(monthlyRevenueUSD) AS average_ai_revenue
FROM saas_startup
WHERE verticals LIKE '%ai%'   
-- Result:
-- AI startups account for 34 of the 47 startups in the dataset.
-- Together, they generate $58,567 in monthly revenue, with an average
-- monthly revenue of approximately $1,723 per startup.

-- Business Insight:
-- Although AI startups represent the majority of startups in the dataset,
-- they contribute only about 10.5% of the total monthly revenue. This
-- suggests that many AI startups are still in the early stages of growth
-- or have not yet achieved significant commercial scale. 
 
-- Funding Analysis

#-Question: How many startups have received funding?
SELECT
    funding,
    COUNT(*) AS startup
FROM saas_startup
GROUP BY funding
ORDER BY startup DESC;


-- Business Insight:
-- Self-funding is the most common funding strategy, with 30 out of 47
-- startups (approximately 64%) relying entirely on founder capital.
--
-- Bootstrapping is the second most common funding approach, used by
-- 10 startups. Only a small number of startups have received seed
-- funding, accelerator support, or crowdfunding.
--
-- This suggests that most startups in the dataset are still in the
-- early stages of development and have not yet secured significant
-- external investment.


#-Which funding type generates the highest average monthly revenue?
SELECT funding,
       COUNT(*) AS startup_count,
       AVG(monthlyRevenueUSD) AS average_monthly_revenue,
       SUM(monthlyRevenueUSD) AS total_monthly_revenue
FROM saas_startup
GROUP BY funding
ORDER BY average_monthly_revenue DESC;

-- Business Insight:
-- Self-funded startups generate the highest average monthly revenue
-- ($17,667) and account for approximately $530,025 of the dataset's
-- total monthly revenue. This suggests that founder-funded businesses
-- currently dominate the commercial performance of the startups in
-- this dataset.
--
-- Although accelerator-backed startups show relatively strong revenue
-- ($12,000 per month), this result is based on only one startup and
-- should therefore be interpreted with caution.
--
-- Bootstrapped startups have much lower average revenue, indicating
-- that many are still in the early stages of growth and may be
-- reinvesting limited earnings to expand their businesses.

    #-Which self-funded startups generate the most revenue?
    --
SELECT name,
       funding,
       monthlyRevenueUSD
FROM saas_startup
WHERE funding = 'self'
ORDER BY monthlyRevenueUSD DESC;

-- Business Insight:
-- Self-funded startups appear to generate the highest average monthly
-- revenue in the dataset. However, this result is heavily influenced by
-- Custom Software Development, which alone generates $500,000 in monthly
-- revenue. Excluding this startup, the average revenue of self-funded
-- businesses would be substantially lower.
--
-- This highlights the importance of identifying outliers when interpreting
-- averages, as a single high-performing company can distort the overall
-- picture of a funding category.

-- Question: Are AI startups more likely to be self-funded than non-AI startups?

SELECT
    CASE
        WHEN verticals LIKE '%ai%' THEN 'AI Startup'
        ELSE 'Non-AI Startup'
    END AS startup_type,
    COUNT(*) AS total_startups,
    SUM(funding = 'self') AS self_funded_startups,
    ROUND(SUM(funding = 'self') * 100.0 / COUNT(*), 2) AS percent_self_funded
FROM saas_startup
GROUP BY startup_type;

-- Business Insight:
-- AI startups are only slightly more likely to be self-funded than
-- non-AI startups (64.71% vs. 61.54%). The small difference suggests
-- that self-funding is a common financing strategy regardless of
-- whether a startup operates in AI or another industry.
--
-- This indicates that many startups in the dataset are still in the
-- early stages of development and have not yet secured significant
-- external investment.

-- Question: Do funded startups earn more revenue than self-funded startups?

SELECT
 CASE 
 WHEN funding ='self' THEN  'Self-Funded'
ELSE 'Externally Funded'
END AS funding_type,

COUNT(*) AS startup_count,
    SUM(monthlyRevenueUSD) AS total_monthly_revenue,
    AVG(monthlyRevenueUSD) AS average_monthly_revenue

FROM saas_startup
GROUP BY funding_type
ORDER BY average_monthly_revenue DESC;

-- Business Insight:
-- Self-funded startups appear to generate substantially higher average
-- monthly revenue than externally funded startups ($17,668 vs. $1,755).
-- However, this result is heavily influenced by one extreme outlier:
-- Custom Software Development, which alone generates $500,000 per month.
--
-- Without this startup, the revenue gap would be much smaller.
-- This highlights the importance of identifying outliers before drawing
-- conclusions from averages.

SELECT
    CASE
        WHEN funding = 'self' THEN 'Self-Funded'
        ELSE 'Externally Funded'
    END AS funding_type,
    COUNT(*) AS startup_count,
    SUM(monthlyRevenueUSD) AS total_monthly_revenue,
    AVG(monthlyRevenueUSD) AS average_monthly_revenue
FROM saas_startup
WHERE monthlyRevenueUSD < 500000
GROUP BY funding_type;

-- Business Insight:
-- After removing the extreme revenue outlier, externally funded startups
-- generate a higher average monthly revenue ($1,755) than self-funded
-- startups ($1,035).
--
-- This suggests that access to external funding may help startups achieve
-- stronger commercial performance. However, the difference should be
-- interpreted cautiously because the dataset is relatively small and
-- contains only 47 startups.

#-Which startups generate strong revenue despite little or no funding?
 
 SELECT name,
        funding,
        monthlyRevenueUSD
FROM saas_startup
WHERE funding IN('self','bootstrap')
AND monthlyRevenueUSD < 500000
ORDER BY monthlyRevenueUSD DESC;

-- Business Insight:
-- After excluding the extreme revenue outlier (Custom Software Development),
-- only a small number of self-funded startups generate meaningful monthly
-- revenue. SoraLum AI and CAPTCHAS.IO lead this group with $10,000 in
-- monthly revenue, followed by Img2Img AI ($5,000) and PREDIMIAL ($4,000).
--
-- This suggests that while most self-funded startups are still in the
-- early stages of commercialization, a few have demonstrated strong
-- capital efficiency by generating revenue without relying on external
-- funding. These startups may represent attractive investment
-- opportunities because they have already validated their business models
-- with limited financial resources.  

#--Which startups have the strongest traction?
SELECT 
	   name,
       verticals,
       funding,
       monthlyRevenueUSD
From saas_startup
ORDER BY monthlyRevenueUSD desc
LIMIT 10;
-- Business Insight:
-- Monthly revenue is used as a proxy for startup traction because the
-- dataset does not include historical growth or customer acquisition
-- metrics. Custom Software Development demonstrates exceptional traction,
-- generating $500,000 in monthly revenue, significantly outperforming
-- every other startup in the dataset.
--
-- Excluding this outlier, Revenue Multiplication Engine, Kairos Connect,
-- SoraLum AI, and CAPTCHAS.IO emerge as the strongest-performing startups,
-- generating between $10,000 and $15,000 in monthly revenue. These
-- startups have demonstrated early commercial success and may represent
-- attractive investment opportunities due to their ability to generate
-- consistent revenue.

#-Which industries have the strongest growth potential?
SELECT
    verticals,
    COUNT(*) AS startup_count,
    AVG(monthlyRevenueUSD) AS average_monthly_revenue
FROM saas_startup
GROUP BY verticals
HAVING COUNT(*) >= 2
ORDER BY average_monthly_revenue DESC;
-- Business Insight:
-- Only two industry combinations are represented by more than one startup.
-- This is because the `verticals` column stores multiple industry tags in a
-- single field, resulting in many unique combinations. Consequently, the
-- dataset does not support meaningful comparisons of average revenue across
-- industries using the combined `verticals` values.
--
-- A more robust industry analysis would require each industry tag to be
-- stored separately, allowing startups to be grouped by individual sectors
-- such as AI, SaaS, FinTech, or Education.
#-How concentrated is startup revenue?

SELECT
    name,
    monthlyRevenueUSD,
    ROUND(
        monthlyRevenueUSD * 100.0 /
        (SELECT SUM(monthlyRevenueUSD) FROM saas_startup),
        2
    ) AS revenue_share_percent
FROM saas_startup
ORDER BY monthlyRevenueUSD DESC
LIMIT 10;

-- Business Insight:
-- Revenue is highly concentrated within the startup ecosystem. Custom
-- Software Development alone accounts for approximately 89.31% of the
-- total monthly revenue, while every other startup contributes less than
-- 3% individually.
--
-- This indicates that the dataset is dominated by a single high-performing
-- company, making average revenue metrics less representative of the overall
-- startup ecosystem. Investors should therefore interpret revenue-based
-- comparisons with caution and consider analysing the data both with and
-- without this outlier.

#-Revenue segmentation--
SELECT
  CASE
    WHEN MonthlyRevenueUSD >=10000 THEN 'High Revenue'
    WHEN MonthlyRevenueUSD >=5000  THEN 'Medium Revenue'
    ELSE'Low Revenue'
    END AS revenue_band,
    COUNT(*) AS startup_count
    FROM saas_startup
    GROUP BY revenue_band
    ORDER BY startup_count DESC ;
    -- Business Insight:
-- Revenue is highly concentrated among a small number of startups.
-- 41 out of 47 startups (87.2%) fall into the Low Revenue category,
-- while only 5 startups (10.6%) generate $10,000 or more in monthly
-- revenue. Only 1 startup (2.1%) falls within the Medium Revenue range.
--
-- This suggests that most startups in the dataset are still at an
-- early stage of commercial development, while a small group has
-- achieved stronger revenue traction.
--
-- However, the High Revenue category includes the $500,000 monthly
-- revenue outlier, Custom Software Development, which significantly
-- affects the overall revenue picture. Therefore, investors should
-- examine the high-revenue startups individually rather than relying
-- only on revenue bands.

-- Question: Which externally or mixed-funded startups generate the highest revenue?
SELECT
name,
funding,
monthlyRevenueUSD
FROM saas_startup
WHERE funding NOT IN ('Self','bootstrap')
ORDER BY monthlyRevenueUSD DESC;
-- Business Insight:
-- Among startups with external or mixed funding, Revenue Multiplication
-- Engine and Kairos Connect demonstrate the strongest monthly revenue,
-- generating $15,000 and $12,000 respectively. However, Revenue
-- Multiplication Engine appears twice in the dataset with different
-- revenue values, so the records should be evaluated separately.
--
-- Most other externally or mixed-funded startups generate relatively low
-- monthly revenue, with several generating little or no revenue. This
-- suggests that external funding does not automatically translate into
-- strong commercial traction.
--
-- From an investor perspective, the strongest candidates are startups
-- that combine external funding with demonstrated revenue traction.
-- However, because the dataset does not provide the actual amount of
-- capital raised, it is not possible to calculate a true return on
-- investment or determine whether a startup is overfunded.

