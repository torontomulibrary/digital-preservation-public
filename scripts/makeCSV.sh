#owner: Jianning Yan (jasmine.yan@mail.utoronto.ca)

#helper function - puase until the user press enter
#if the user does not want to continue, simply close the commend window
function pause(){
	read -p "$*"
}

#make a metadata folder if it does not exist
#if the folder exists, ask the user if they want to overwrite the metadata folder
if [ ! -d '../metadata' ]; then
	mkdir '../metadata'
	echo "Created a new metadata folder"
else
	echo "This will overwrite the original metadata folder!"
	echo "If you do not want to continue, close the window."
	pause 'Press [Enter] key to continue...'
	rm -r '../metadata'
	mkdir '../metadata'
fi

#overwrite the original file, input the filename header
echo 'filename' > '../metadata/metadata.csv'

#write the current folder name
current="${PWD##*/}"
echo "$current" >> '../metadata/metadata.csv'

#write subfolders
subdircount=$(find ./ -maxdepth 1 -type d | wc -l)
if [ $subdircount -gt 1 ]
then
	find */ -type d > '../temp.txt'
	cat ../temp.txt | while read line
	do
		echo $current/$line >> '../metadata/metadata.csv'
	done
	rm ../temp.txt
fi

#write files
find . ! -name '*.DS_Store' -type f > '../temp.txt'
cat ../temp.txt | while read line
do
	l=${line:1:2000}
	echo data/$current$l >> '../metadata/metadata.csv'
done
rm ../temp.txt
