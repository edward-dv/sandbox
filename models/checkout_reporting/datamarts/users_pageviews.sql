{{ config( 
    materialized ="table"
) }}

WITH 
prep AS (
    SELECT 
        pv.user_id
        , pv.page_url
        , pv.pageview_datetime
        -- Results in the postcode the user was in at the time of the page view
        , CASE 
            WHEN CAST(pv.pageview_datetime AS DATE) >= u.dbt_valid_from 
             AND CAST(pv.pageview_datetime AS DATE) < u.dbt_valid_to 
            THEN u.postcode
        END                                                 AS postcode
        , u.postcode_index
    FROM {{ ref('pageviews') }}     AS pv
    JOIN {{ ref('users') }}         AS u
      ON u.user_id = pv.user_id
)

SELECT * 
  FROM prep 
 WHERE postcode IS NOT NULL
 ORDER BY 1