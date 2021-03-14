{{ config( 
    materialized ="table"
) }}

SELECT 
    id                                                  AS user_id
    , postcode
    , dbt_valid_from
    -- Replaces nulls with a theoretical date
    , CASE 
        WHEN dbt_valid_to IS NULL 
        THEN CAST('2099-01-01' AS DATE)
        ELSE dbt_valid_to
    END                                                 AS dbt_valid_to
    -- Index = 1 corresponds to the latest postcode of a user
    , ROW_NUMBER() OVER (PARTITION BY id
        ORDER BY dbt_valid_from DESC)                   AS postcode_index
        
FROM {{ ref('staging_users') }}  