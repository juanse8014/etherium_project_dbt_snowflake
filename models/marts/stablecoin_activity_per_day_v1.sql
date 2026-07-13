{{ config(
    tags=['stablecoin'],
    grants = {'select': ['PUBLIC']}
) }}
select
    t.date,
    t.token_address,
    s.type,
    s.symbol,
    {{ convertion('t.value', 's.decimals') }} as total_usd_value
from {{ ref('stg_token_transfers') }} as t
left join {{ ref('stablecoins') }} as s
on t.token_address = s.contract_address
where s.contract_address is not null
--or lower(token_address) in {{ random_macro() }}
group by 
t.date, 
t.token_address,
s.type,
s.symbol