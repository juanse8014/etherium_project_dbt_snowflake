{{
    config(
        materialized='incremental',
        incremental_strategy='merge',
        unique_key='hash'
    )
}}

with transactions as (
    select * from {{ ref('stg_transactions') }}
),
token_transfers as (
    select
        transaction_hash,
        count(*) as token_transfers_count
    from {{ ref('stg_token_transfers') }}
    group by transaction_hash
),
enriched as (
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
            when tt.transaction_hash is not null        then 'token_transfer'
            when t.input = '0x' and t.value > 0        then 'plain_transfer'
            else 'other'
        end as transaction_category
    from transactions as t
    left join token_transfers as tt
        on t.hash = tt.transaction_hash
)

select * from enriched

{% if is_incremental() %}
    where date > (select max(date) from {{ this }})
{% endif %}