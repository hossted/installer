#!/bin/bash

#HOSSTED=/usr/local/bin/hossted
HOSSTED=./cli/bin/osx/hossted
#k8s or docker type
TYPE=$1

check_os() {
	 # Get the operating system name from 'uname'
	os=$(uname -s)

	# Set the operating system type based on the 'os' variable
	if [ "$os" = "Linux" ]; then
	    HOSSTYPE="linux"
	elif [ "$os" = "Darwin" ]; then
	    HOSSTYPE="osx"
	fi
}

get_uuid() {
  UUID=`uuidgen`
}

install_hossted_cli() {
  curl -L "https://github.com/hossted/cli/raw/main/bin/$HOSSTYPE/hossted" -o $HOSSTED
  chmod a+x $HOSSTED
}

hossted_init() {
  echo "init $UUID"
#  $HOSSTED init
}

hossted_import() {
  echo "hossted import $TYPE $UUID"
}

hossted_register() {
  echo 'register'
  $HOSSTED register
}


  check_os # gotta figure out which arch of hossted to install
  get_uuid # uuid represents ctx and instance
  install_hossted_cli # install dat 
  hossted_init  # Add the app to the hossted registry
  hossted_import # Import current docker-compose or k8s data
  hossted_register # Sign in to the hossted dashboard
