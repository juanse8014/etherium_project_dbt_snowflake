{{
    config(
        materialized='view',   
        event_time='date'       
    )
}}

select
    transaction_hash,
    date,
    count(*) as token_transfers_count
from {{ ref('stg_token_transfers') }} 
group by transaction_hash, date