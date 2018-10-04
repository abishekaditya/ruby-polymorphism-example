#!/bin/zsh
rm -f './flog.csv'
for x in `ls | grep search`;
  do echo $x '\n-------------\n' `flog $x -s` '\n' >> flog.csv;
done;
