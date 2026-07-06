select
    date, 
    transaction_category,
    count(*) as tx_count,
    sum(value)/1e18 as total_value
from {{ ref('int_transactions_enriched_append') }}
group by date, transaction_category