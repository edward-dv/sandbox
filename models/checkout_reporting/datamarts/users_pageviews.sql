{{ config( 
    materialized ="table"
) }}

WITH 
prep AS (
    SELECT
        pv.pageview_id 
        , pv.user_id
        , pv.page_url
        , pv.pageview_datetime
        , u.postcode
        , u.postcode_index
    FROM {{ ref('fct_pageviews') }} AS pv
    JOIN {{ ref('dim_users') }}     AS u
      ON u.user_id = pv.user_id
      -- Gets only the postcode the user was in at the time of the pageview
     AND CAST(pv.pageview_datetime AS DATETIME) >= CAST(u.postcode_valid_from AS DATETIME)
     AND CAST(pv.pageview_datetime AS DATETIME) < CAST(u.postcode_valid_to AS DATETIME)
)

SELECT * 
  FROM prep 
 ORDER BY 2, 4