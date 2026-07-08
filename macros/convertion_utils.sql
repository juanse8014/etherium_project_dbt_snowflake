{% macro etherium_convertion(column_name) %}

sum({{ column_name }}/1e18)

{% endmacro%}

{% macro stablecoin_convertion(column_name) %}

sum({{ column_name }}/1e16)

{% endmacro%}