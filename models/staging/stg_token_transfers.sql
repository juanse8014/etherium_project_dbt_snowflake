select
    transaction_hash,
    date,
    token_address,
    value
from {{ source('eth', 'token_transfers') }}

{% if target.name != 'prod' %}
    where date >= '2026-06-01'
{% endif %}