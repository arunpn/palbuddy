#! /bin/sh
DAEMON="`which unicorn_rails`"
DAEMON_OPTS="-p 5000 -c /home/ghostviper/Work/codebase/palbuddy/codebase/codepal/config/unicorn.rb -D"
NAME=unicorn
DESC="Unicorn App Server"
PID=/home/ghostviper/Work/codebase/palbuddy/codebase/codepal/shared/pids/unicorn.pid

case "$1" in
  start)
    echo -n "Starting $DESC: "
    $DAEMON $DAEMON_OPTS
    echo "$NAME."
    ;;
  stop)
    echo -n "Stopping $DESC: "
        kill -QUIT `cat $PID`
    echo "$NAME."
    ;;
  restart)
    echo -n "Restarting $DESC: "
        kill -QUIT `cat $PID`
    sleep 1
    $DAEMON $DAEMON_OPTS
    echo "$NAME."
    ;;
  reload)
        echo -n "Reloading $DESC configuration: "
        kill -HUP `cat $PID`
        echo "$NAME."
        ;;
  *)
    echo "Usage: $NAME {start|stop|restart|reload}" >&2
    exit 1
    ;;
esac
exit 0
