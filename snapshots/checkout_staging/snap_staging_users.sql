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
FROM {{ source('checkout_staging','intermediate_users') }}

{% endsnapshot %}