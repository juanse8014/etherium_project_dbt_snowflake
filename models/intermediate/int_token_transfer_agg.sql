{{ config(materialized='ephemeral') }}

select
    transaction_hash,
    count(*) as token_transfers_count
from {{ ref('stg_token_transfers') }} 
group by transaction_hash