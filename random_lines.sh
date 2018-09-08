#! /bin/bash

if [ -e random_lines.txt ]
then
	rm random_lines.txt
fi

touch random_lines.txt
characters="0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"

until [ $(du random_lines.txt | cut -f1) -ge 1024 ]
do
	for ((i=0 ; 15 - $i ; i++))
	do
		index=$(($RANDOM % 60))
		char=${characters:$index:1}
		echo -n $char >> random_lines.txt
	done

	echo >> random_lines.txt
done

sort random_lines.txt >> random_lines.txt

grep -v -e ^a -e ^A random_lines.txt > random_lines_not_starting_with_a.txt

echo $(diff random_lines.txt random_lines_not_starting_with_a.txt | wc -l) lines were removed.
