#! /bin/bash

find `pwd`/html/* | parallel -j8 --progress "echo {} | ./get_descriptions2.R > datos/{/.}.ufo_psv"


