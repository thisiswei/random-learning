```
whatis cat
whereis cat
egrep -i
uuname -l
type sort
tty
who
```


# unix/linux handbook

```
>&  redirect error and output
2>  only the error
&&  to execute only if the precursor completes successfully     
||  .........................................   fails
echo "there are `wc -l /etc/passwd` lines in the password file"
sort -b ignore leading white space
     -f case insentive sorting
     -k specify the columns that form the sort key
     -n compare fields as integer
     -r reverse
     -t set field separator
     -u unique
grep -p  use regular expression like perl/python
chmod +x filename   turn on file's executeable



$ find . -type f -name '*.log' | grep -v .do-not-touch | while read fname 
> do
> echo mv $fname ${fname/.log/.LOG/}
> done

fc  will transfer the last command and open the $EDITOR, in case of saving a script

-d  file exists and is a directory
-e file exists
-f file exists and is a regular file 
-r You have read permission on file 
-s file exists and is not empty
-w You have write permission on file 
file1 -nt file2 file1 is newer than file2
file1 -ot file2 file1 is older than file2



#!/bin/bash
suffix=BACKUP--`date +%Y%m%d-%H%M`
for script in *.sh; do 
  newname=”$script.$suffix”
  echo "Copying $script to $newname..." 
  cp $script $newname
done



M[ou]'?am+[ae]r ([AEae]l[- ])?[GKQ]h?[aeu]+([dtz][dhz]?)+af[iy]





```



##### Shell Scripting
```

```
