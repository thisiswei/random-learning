list all the bindkey in zsh
`zle -la`

`man ls`

`trap '. ~/.bash_logout' EXIT`

`find ~ -name addrs.txt -print`
find file name addrs.txt under home directory


`find . -name '*.txt' -print  | xargs rm`
find all the file ending with txt and pass to xargs rm them indivually


`locate updatedb`

`pwd -P`
preventing pwd lying

`~2`

`~-`

```pw=`pwd```
`~pw`

```
echo {1,2,3}
echo {1..10}
echo {a-e.}

echo "wtf" >| bitch.txt
this command does care if the file exsits or not
```

``` cat << END >> ~/.bashrc
alias scat='sed -n 1'
....
END
```

to add alias to ~/.bashrc


```echo "$(date)" | tee file1.log```

send the date to file and output to terminal

```echo "$(date)" > file1.log > file2.log```

```
print -l **/*.txt
```

recursivlly search under current directory


```
touch wtf{1,2,3,4,5}.txt
echo wtf<1-3>
echo wtf<1->
echo wtf<->
```

```
echo *(/)   print all the directories
ls -l *(Lk+100)  all the file that is larger than 100k
ls -l *(mn-1)  list all the file that is created less than a hour
ls *(On)
```

```
echo ${#arr}  length
echo ${src_files[0]}
arr[2,3]=()
(( product=4*3 ))
echo $a[5,7]
```



