#!/bin/sh
{%- if wm == "bspwm" %}
echo "using bspwm"
{% endif -%}
{%- if wm == "hypr" %}
echo "using hypr"
{% endif -%}
# ps -ef | grep python
