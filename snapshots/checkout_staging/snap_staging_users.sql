{% snapshot staging_users %}

{{
    config(
      target_database='sandbox-edeveer',
      target_schema='checkout_staging',
      unique_key='id',

      strategy='timestamp',
      updated_at='load_date',
    )
}}

SELECT *
  FROM {{ source('checkout_raw','users_extract') }}   AS ru
  JOIN {{ this }}                                     AS su
    ON su.id = ru.id
 -- Only add a new row when there is a change in postcode
 WHERE ru.postcode != su.postcode

{% endsnapshot %}