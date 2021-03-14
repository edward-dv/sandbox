SELECT ru.*
  FROM {{ source('checkout_raw','users_extract') }}     AS ru
  JOIN {{ source('checkout_staging','staging_users') }}  AS su
    ON su.id = ru.id
 WHERE ru.postcode != su.postcode