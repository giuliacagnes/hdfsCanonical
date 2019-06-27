#!/bin/awk -f
BEGIN {
        print "sz\tts\tbasepath\tschname\ttname\tpart\tfname"
       };

#WHERE
/\/\./ {next} #TODO need to test it because the file provided doesn't have any entry containing /.
#SELECT
{
  #Select the elements of `sz` without zeros value
  if($5 != 0)
  {   # split a string to an array called arpat with delimiter"/"
      patqty = split($8, arpat, "/")
      #if `part` contains '=' => ind_part=1 else ind_part =0
      ind_part = arpat[patqty-1] ~ /=/
      # if(arpat[patqty-1] ~ /=/)
      # {
      #   ind_part=1
      # } else
      # {
      #   ind_part=0
      # }

      #fill the basepath
      basepath = ""
      for (i=1; i <= (patqty-3-ind_part); i++){
        basepath = basepath "/" arpat[i]
      }
      schname=arpat[patqty-2-ind_part]
      tname=arpat[patqty-1-ind_part]
      fname=arpat[patqty]

      part = ""
      if(ind_part==1){
        part=arpat[patqty-1]
      }
      print $5 "\t" $6 " " $7 ":00\t" basepath "\t"schname "\t"tname "\t"part"\t" fname
  }
}
