
# hdfs2canonicalAwkConverter

### Introduction

The project consists of a bash script `hdfs2canonical.sh` which goal is to emulate the behavior of a specific SQL query. The advantage is that the script could be run directly on OS without needing any database connection.

The script contained inside this project aim to convert a text file which content looks like the output of an `ls` command from an hdfs https://hadoop.apache.org/docs/r1.2.1/hdfs_design.html into a canonical format.

### How it works

Below the query that the script emulates:

```SQL
--STEP1: bring hdfs listing into canonical form
DROP TABLE hdfsdb;
CREATE TABLE hdfsdb as
WITH t as(
--STEP1a: split into fields (not perfect as filename can contain space(s))
SELECT regexp_split_to_array(hdfs, '\s+') ars, hdfs FROM hdfs5 WHERE hdfs!~'\/\.'
),x as(
--Step1b: split path field further into segments
SELECT --ars[1],ars[2],ars[3],ars[4],
ars[5]::bigint sz,to_timestamp(ars[6]||' '||ars[7],'YYYY-MM-DD HH24:MI')::timestamp without time zone ts,ars[8] path, regexp_split_to_array(trim(leading '/' from ars[8]), '\/') arpat FROM t
 WHERE ars[5]!='0'
),y as(
--STEP1c: calculate extra column: number of segements
SELECT sz, ts, path, arpat, array_length(arpat,1) patqty
  FROM x
-- WHERE sz!='0' --done earlier
)
,z as(
--STEP1d: calculate extra column: is there partition extra segment
SELECT sz, ts, path, arpat, patqty, CASE WHEN (arpat[patqty-1])~'=' THEN 1 ELSE 0 END ind_part FROM y
)
--STEP2: put all together into a nice tabular output format: the depth is unknown and can't rely on static segment indexes
SELECT sz, ts--, path, arpat, patqty, ind_part
      , '/'||array_to_string(arpat[1:patqty-3-ind_part],'/') basepath
      --, arpat[1:patqty-3-ind_part] arbasepath
      ,arpat[patqty-2-ind_part] schname
      ,arpat[patqty-1-ind_part] tname
      ,CASE 1 WHEN ind_part THEN arpat[patqty-1] END part
      ,arpat[patqty]fname
  FROM z
;
```

The following awk scripts describe the relative steps above:

* `1a.awk`
* `1b1c1d.awk`
* `2.awk`

The bash script `hdfs2canonical.sh` calls each script above in a sequence fashion.

### Requisites

* `awk` tool

### Installing

Clone the repository:

```
$ git clone git@gitlab.com:sonra-labs/hdfs2canonicalAwkConverter.git
$ cd hdfs2canonicalAwkConverter

```

### Usage

Launch the script with:

```
$ ./hdfs2canonical.sh file_output_10 > file_output_10.tsv
```

### Author

* Giulia Cagnes - @GiuliaCagnes
