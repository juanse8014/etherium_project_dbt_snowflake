{% macro random_macro() %}

{# If you don't put info=True in the function, it will be printed in the dbt.log file, but not in console. #}

{% set query %}
select
distinct token_address
from {{ ref('stg_token_transfers') }}
limit 10
{% endset %}

{# To execute the query #}

{% if execute%}
{% set result = run_query(query) %}
{% set result_list = result.columns[0].values() %}
{% else %}
{% set result_list = [] %}
{% endif %}


{# We also can return the output of the macro #}
{{ return(result_list) }}

{% endmacro %}