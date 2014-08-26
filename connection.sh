#!/bin/bash


# Only source connection if hasn't already been sourced
# can't redeclare readonly variables
if [[ $CONNECTION_HAS_BEEN_SOURCED -ne 1 ]]
then
    declare CONNECTION_HAS_BEEN_SOURCED=1
    # Note this is if want a specific file descriptor 
    # or if on bash pre 4.1
    # search for PRE4.1FD in file for other lines to uncomment
    # declare -r tcpFd=3
    
    function connection_create(){
        
        #TODO check if $1 and $2 are valid for address and port
        #and assign if ok
        
        declare -r defaultAddress=127.0.0.1
        address=$1
        [ ${address:=$defaultAddress} ]
      
        declare -r defaultPort=4711
        port=$2
        [ ${port:=$defaultPort} ]
        
        # NOTE Below line is for if using pre 4.1 bash shell
        # search for PRE4.1FD in file for other lines to uncomment
        #eval "exec ${tcpFd}<> /dev/tcp/$address/$port"
        
        #Get lowest free file descriptor above 9
        exec {tcpFd}<> /dev/tcp/${address}/${port}
       # echo "Using File Descriptor $tcpFd"
        if [ -z $tcpFd ]
        then
            echo "Unable to connect socket. Exiting"
            exit 1
        fi
    }
    
    function drain(){
        local input
        # timeout of 0.1 nedded to get drained data
        while read -t 0.1 input 
        do
            # Note this is a defensive break out for case where 
            # read returns success value but $input is an empty string
            if [ -z $input ]
            then
                break
            fi
            echo "Drained Data: $input"
            echo "LastSent : $lastSent"
        done
    }<&$tcpFd >&2
    
    function send(){
       drain
       lastSent=$1
       echo $1"\n"
    } >&$tcpFd
    
    function receive(){
       local answer
       read answer
       if [ "$answer" != "Fail" ]
       then
           echo $answer
       else
           echo "Recieve Failed" >&2
       fi
    } <&$tcpFd
    
    function sendAndReceive(){
        send $1"\n"
        local answer
        answer=$(receive)
        echo ${answer//\n/}
    } 
    
 fi
