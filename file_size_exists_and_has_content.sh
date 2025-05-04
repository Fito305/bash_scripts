#!/bin/bash

echo "Hola Mundo!" > file.txt

if [[ -f "file.txt" ]] && [[ -s "file.txt" ]]; then
	echo "The file exists and its size is greater than zero."
fi


# This code writes content to a file, then checks whether that file exists
# and whether its size is greater than zero. Both conditions have to be met in
# order for the echo command to be executed. If either returns false,
# nothing will happen.
