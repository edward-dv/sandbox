{{ config( 
    materialized ="table"
) }}

SELECT
    user_id
    , page_url
    , pageview_datetime
FROM {{ ref('staging_pageviews') }} 