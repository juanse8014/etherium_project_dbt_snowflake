{{
    config(
        materialized='incremental',
        incremental_strategy='microbatch',
        event_time='date',
        begin='2026-06-01',
        batch_size='day',
        unique_key='hash',
        concurrent_batches=false
    )
}}

select
    t.hash,
    t.block_number,
    t.date,
    t.from_address,
    t.to_address,
    t.value,
    t.receipt_contract_address,
    t.input,
    tt.token_transfers_count,
    case
        when t.receipt_contract_address is not null then 'contract_creation'
        when tt.transaction_hash is not null then 'token_transfer'
        when t.input = '0x' and t.value > 0 then 'plain_transfer'
        else 'other'
    end as transaction_category
from {{ ref('stg_transactions') }} as t
left join {{ ref('int_token_transfer_agg') }} as tt on t.hash = tt.transaction_hash