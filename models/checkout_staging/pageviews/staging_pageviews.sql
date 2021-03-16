{{ config( 
    materialized ="incremental"
) }}

SELECT 
  {{ dbt_utils.surrogate_key(['user_id','page_url','pageview_datetime' ]) }} AS pageview_id
  , user_id
  , page_url
  , pageview_datetime
  , load_timestamp
FROM {{ source('checkout_raw','pageviews_extract') }}

{% if is_incremental() %}

  WHERE load_timestamp > (SELECT max(load_timestamp) FROM {{ this }})

{% endif %}
