if ( pgrep -f solr.home )
then
	echo "Waiting to kill tomcat"
	pkill -9 -f solr.home
	sleep 5
fi
echo "Starting tomcat: $(pgrep -f solr.home)"
$PWD/$(dirname $0)/catalina.sh start
sleep 2

if ( pgrep -f solr.home )
then
	echo "tomcat is up"
else
	echo "tomcat is not up"
fi
