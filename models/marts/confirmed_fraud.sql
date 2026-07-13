{{ config(group = 'fraud_risk', access='private') }}

select
*
from {{ ref('int_transactions_enriched_append') }}

where from_address in ('0x646c4fbdf82b5766c5eaf1fab9a8927fb5992d38', '0x014523f2a626f0e3dbc241b8e9a4c14c507a6360')