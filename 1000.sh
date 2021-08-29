#get list of words from github or some other part of the internet and give it as an argument to this script
ARGNUM=$#

check_args() {
 	if [[ $ARGNUM -ne 1 ]]; then
		echo "usage: ./1000.sh [filename]\nfile should be separated by newlines"
		exit
	fi
}

check_args

NAME=$1

check_file() {
	if [[ ! -f "$NAME" ]]; then
		echo "file doesn't exist. bye"
		exit
	fi
}

check_file

sed -i '/[0-9]/d' $NAME #removes numbers if necessary
awk '{ print length, $0 }' $NAME | sort -n | sed -E -e '/^1|2|3/d' | cut -d' ' -f2- > $NAME-sorted #sort by length and remove all words with length of 1, 2 or 3 
echo "sorting and cutting"
sed 's/.*/"&"/' $NAME-sorted > $NAME-quotes #add quotes around each entry, alternatively use 's/.*/'&'/' for single quotes
echo "sed for quotes"
sed '$!s/$/,/' $NAME-quotes > $NAME-final.txt #commas after every line
echo "sed commas"
tr -d '\n' < $NAME-final.txt > arr.txt #compress into 1 line
echo "compress into 1 line"
cat arr.txt #then copy into js file OR (if supported) cat arrwords.txt | xclip
rm $NAME-sorted $NAME-quotes $NAME-final.txt
echo "removed tmp files"
#awk '{ print length, $0 }' $NAME | sort -n | sed -E -e '/^1|2|3/d' | cut -d' ' -f2- | sed 's/.*/"&"/' | sed '$!s/$/,/' > tr -d '\n' | cat
