#!/usr/bin/bash
cd "$1"
for file in *.txt;
do 
	rar a "$file.rar" $file
	zip -r "$file.zip" $file
	tar -czvf "$file.tar.gz" $file
	tar -cjvf "$file.tar.bz2" $file
	tar -cJvf "$file.tar.xz" $file
done
	


