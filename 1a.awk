#!/bin/awk -f
#WHERE
/\/\./ {next} #TODO need to test it because the file provided doesn't have any entry containing /.
#SELECT
{ print $1 "," $2 "," $3 "," $4 "," $5 "," $6 "," $7 "," $8 }
