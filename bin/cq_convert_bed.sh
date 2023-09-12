#!/bin/bash

in=$1

awk 'NR>1 {printf "%s\t%s\t%s\t%s:%s|%s\t.\t%s\n", $2, $3, $4, $2, $3, $4, 2}' $in