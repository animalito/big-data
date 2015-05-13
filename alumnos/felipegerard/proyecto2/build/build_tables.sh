#! /bin/bash

find `pwd`/../html/* | parallel -j8 --progress "echo {} | ./process_html.R > ../datos/ufo_psv/{/.}.ufo_psv"


