{{ config( 
    materialized ="table"
) }}

SELECT
    pageview_id
    , user_id
    , page_url
    , pageview_datetime
FROM {{ ref('staging_pageviews') }} 