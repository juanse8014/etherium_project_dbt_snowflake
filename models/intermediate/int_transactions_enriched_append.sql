{{
    config(materialized='incremental',
    incremental_strategy='append'
) }}

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
    end as transaction_category,
    current_timestamp() as updated_at
from {{ ref('stg_transactions') }} as t
left join {{ ref('int_token_transfer_agg') }} as tt on t.hash = tt.transaction_hash

{% if is_incremental() %}
--is_incremental returns true if all of the following are true:
-- The model is configured as incremental (materialized='incremental')
-- The model must already exist as a table in the database.
-- The --full-refresh flag is not passed

-- Note: The SQL in your model needs to be valid whether is incremental() evalueates to true or false.

where t.date >= (select max(inc.date) from {{ this }} as inc)

{% endif %}