#！/bin/bash

if [[ $# -lt 1 ]]; then
	echo "No Args Input"
	exit;
fi

case $1 in
	"start" )
	echo "starting......"
		;;
	"stop")
	echo "stoping......"
	;;
	  *)
   echo "Input  Args Error..."
    ;;
esac