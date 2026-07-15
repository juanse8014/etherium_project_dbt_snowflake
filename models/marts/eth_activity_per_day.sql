{{ config(
    tags=['eth']
) }}

select
    date, 
    transaction_category,
    count(*) as tx_count,
    {{ etherium_convertion('value') }} as total_value_eth
from {{ ref('int_transactions_enriched_append') }}
group by date, transaction_category