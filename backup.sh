FILES=`cat FILES`

DESTDIR=`dirname $0`/`hostname`/conf
rm -fr $DESTDIR
for FILE in $FILES;
do
	if [ ! -f  "$FILE" ]; then
		echo "file $FILE does not exist"
		exit 1
	fi
	SRCDIR=`dirname $FILE` 
	TARGETDIR=$DESTDIR/$SRCDIR

	#echo "mkdir -p $TARGETDIR"
	mkdir -p $TARGETDIR

	#echo "cp $FILE $TARGETDIR"
	cp $FILE $TARGETDIR
done
