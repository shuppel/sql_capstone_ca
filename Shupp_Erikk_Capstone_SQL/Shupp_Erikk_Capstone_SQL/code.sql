-- 1.0 Company Profile

-- 1.1
SELECT COUNT(DISTINCT utm_source) AS 'distinct sources'
FROM page_visits;

SELECT COUNT(DISTINCT utm_campaign) AS 'distinct campaigns'
FROM page_visits;

-- 1.2
SELECT DISTINCT utm_source, utm_campaign
FROM page_visits;

-- 1.3 
SELECT DISTINCT page_name AS 'Pages'
FROM page_visits;

-- 2.0 User Journey

-- 2.1
WITH first_touch AS (
    SELECT user_id,
        MIN(timestamp) as first_touch_at
    FROM page_visits
    GROUP BY user_id),
ft_attr AS (   
		SELECT ft.user_id,
   		 ft.first_touch_at,
   		 pv.utm_source,
   		 pv.utm_campaign
	FROM first_touch AS 'ft'
	JOIN page_visits AS 'pv'
    ON ft.user_id = pv.user_id
    AND ft.first_touch_at = pv.timestamp)
-- Query to find first touches campaign
    SELECT ft_attr.utm_source AS 'source',
    			ft_attr.utm_campaign AS 'campaign',
          COUNT(*) AS 'Total FT(s)'
          FROM ft_attr
          GROUP BY 1,2
          ORDER BY 3 DESC; 
--2.2
WITH last_touch AS (
    SELECT user_id,
        MAX(timestamp) as last_touch_at
    FROM page_visits
    GROUP BY user_id),
lt_attr AS (   
		SELECT lt.user_id,
   		 lt.last_touch_at,
   		 pv.utm_source,
   		 pv.utm_campaign
	FROM last_touch AS 'lt'
	JOIN page_visits AS 'pv'
    ON lt.user_id = pv.user_id
    AND lt.last_touch_at = pv.timestamp)
-- Query to find last touches campaign
    SELECT lt_attr.utm_source AS 'source',
    			lt_attr.utm_campaign AS 'campaign',
          COUNT(*) AS 'Total LT(s)'
          FROM lt_attr
          GROUP BY 1,2
          ORDER BY 3 DESC; 
--2.3
SELECT page_name AS "Page Name",
		COUNT(*) AS "Total Purchases"
FROM page_visits
WHERE page_name = '4 - purchase';

--2.4
WITH last_touch AS (
    SELECT user_id,
        MAX(timestamp) as last_touch_at
    FROM page_visits
  	WHERE page_name ='4 - purchase'
    GROUP BY user_id),
lt_attr AS (   
		SELECT lt.user_id,
   		 lt.last_touch_at,
   		 pv.utm_source,
   		 pv.utm_campaign
	FROM last_touch AS 'lt'
	JOIN page_visits AS 'pv'
    ON lt.user_id = pv.user_id
    AND lt.last_touch_at = pv.timestamp)
-- Query to find last touches campaign
    SELECT lt_attr.utm_source AS 'source',
    			lt_attr.utm_campaign AS 'campaign',
          COUNT(*) AS 'Total Purchases'
          FROM lt_attr
          GROUP BY 1,2
          ORDER BY 3 DESC; 