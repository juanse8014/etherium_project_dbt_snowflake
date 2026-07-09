select
{{ dbt_utils.star(from=ref('int_transactions_enriched_append'), quote_identifiers=False) }}
from {{ ref('int_transactions_enriched_append') }}