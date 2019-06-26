#!/bin/awk -f
BEGIN { ORS="" };

{
  if($5 != "0"){
    patqty = split($8, arpat, "/")

    print $5 "," $6 " " $7 "," $8
    for (i=1; i <= patqty; i++){
      print "," arpat[i]
    }
    print "," patqty
    if(arpat[patqty-1] ~ /=/){
      print ",1"
    } else{
      print ",0"
    }
    printf "\n"
  }

}
