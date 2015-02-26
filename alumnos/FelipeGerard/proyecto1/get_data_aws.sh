sed -n 1,5p data_urls \
| sed "s/.*\///" \
| parallel --basefile get_data.R --slf instancias_aws --return {.}.prueba --cleanup \
    "echo {} | ./get_data.R > {.}.prueba"
