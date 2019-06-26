#!/bin/awk -f
BEGIN {
  ORS=""
  print "sz\tts\tbasepath\tschname\ttname\tpart\tfname"
  printf "\n"
};

{
  ind_part=$NF
  #print ind_part
  patqty=$(NF-1)
  #print "patqty:" patqty
  basepath="/"$4"/"$5"/"$6"/"$7"/"$8"/"$9
  schemaIdx=3+patqty-2-ind_part
  #print "schemaIdx:" schemaIdx
  #print "3+patqty"3+patqty
  #print "2-ind_part"2-ind_part
  tnameIdx=3+patqty-1-ind_part
  fnameIdx=3+patqty
  print $1 "\t" $2 ":00\t" basepath "\t" $(schemaIdx) "\t" $(tnameIdx)
  if(ind_part){
    part=3+patqty-1
    print "\t" $(part)
  } else{
    print "\t"
  }
  print "\t" $(fnameIdx)
  printf "\n"
}
