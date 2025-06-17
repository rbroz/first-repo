{% macro ids_to_values_case(column_name, ids=[],val=[]) %}

case

{% for i in ids -%}
    when {{ column_name }} = {{ ids[loop.index0] }} then '{{ val[loop.index0] }}'
{% endfor %}

end

{% endmacro %}