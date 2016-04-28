#!/bin/bash

set -x

#while [ 1 ]
#do
        for i in `seq 8081 8088`;
        do

          echo $i
                cnt=`ps -ef|grep userQuery.$i.conf|grep -v grep|wc -l`
                echo "process is :" $cnt
                if [ $cnt -eq 0 ]
                then
                   echo "restart....."
		   ulimit -c 0
                   date
                   nohup /work/data/src/LdpApiRtbServer/LdpRtbServerApi -c /work/data/src/LdpApiRtbServer/conf/userQuery.$i.conf -n query > /dev/null 2>&1  &
                fi

                sleep 3
        done

                cnt=`ps -ef|grep nutcracker.leaf.yml|grep -v grep|wc -l`
                echo "process is :" $cnt
                if [ $cnt -eq 0 ]
                then
                   echo "restart....."
                   ulimit -c 0
                   date
                   nohup /work/data/src/twemproxy/src/nutcracke -c /work/data/src/twemproxy/conf/nutcracker.leaf.yml > /dev/null 2>&1  &
                fi

		cnt=`ps -ef|grep redis_dmap_|grep -v grep|wc -l`
		echo "process is :" $cnt
		if [ $cnt -eq 0 ]
		then
			echo "restart....."
			date
			/work/data/src/redis/bin/redis-server  /work/data/src/redis/etc/redis_dmap_5900.conf
		fi
        #sleep 30
#done
