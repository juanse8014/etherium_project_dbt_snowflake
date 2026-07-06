{{ config(materialized='view') }}

select
    address,
    block_number,
    bytecode,
    date,
    last_modified
from {{ source('eth', 'contracts') }}

{% if target.name != 'prod' %}
    where date >= '2026-06-01'
{% endif %}