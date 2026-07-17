{{ config(materialized='ephemeral') }}

select
    listing_id,
    city,
    monthly_rent,
    status,
    updated_at
from {{ source('airbnb', 'apartment_listings') }}