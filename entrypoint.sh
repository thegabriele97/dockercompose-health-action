#!/bin/bash

cd ${INPUT_WORKDIR}

docker-compose ps
docker-compose logs

begin_cnt=$(docker-compose ps | wc -l)

regx='\s*([Rr]unning|[uU]p) \(healthy\)'
secs=${INPUT_TIMEOUT}                           # Set interval (duration) in seconds.
endTime=$(( $(date +%s) + secs )) # Calculate end time.
while [ $(date +%s) -lt $endTime ]; do  # Loop until interval has elapsed.
    cnt=$begin_cnt
    while IFS= read -r line; do
        if [[ $line =~ $regx ]]; then
            cnt=$((cnt+1))
        fi
    done <<< $(docker-compose ps)
    echo -en "\rWaiting for services... $cnt/$(docker-compose ps | wc -l)"
    if [[ $cnt -eq $(docker-compose ps | wc -l) ]]; then
        echo ""
        exit 0
    fi
	if [[ $cnt -eq 2 ]]; then
		echo "No services found !?"
		exit 1
	fi
    sleep 1
done

docker-compose ps
docker-compose logs

exit 1
