select
    sum(value) as total_amount
from {{ ref('int_transactions_enriched_append') }}
having total_amount < 0