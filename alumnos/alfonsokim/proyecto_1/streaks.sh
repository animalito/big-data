#!/bin/bash

cat data.csv | python state_streak.py $1 | head -1