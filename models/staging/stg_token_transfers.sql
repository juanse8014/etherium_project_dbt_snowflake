select
    transaction_hash,
    date,
    token_address,
    value
from {{ source('eth', 'token_transfers') }}

{% if target.name != 'prod' %}
    where date >= '{{ var('begin_date') }}'
{% endif %}