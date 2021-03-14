{{ config( 
    materialized ="table"
) }}

SELECT
    user_id
    , page_url
    , pageview_datetime
FROM {{ source('checkout_staging','staging_pageviews') }}  