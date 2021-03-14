{{ config( 
    materialized ="incremental"
) }}

SELECT *
FROM {{ source('checkout_raw','pageviews_extract') }}
{% if is_incremental() %}

  WHERE load_timestamp > (SELECT max(load_timestamp) FROM {{ this }})

{% endif %}