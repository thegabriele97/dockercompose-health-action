#!/bin/bash

cd ${INPUT_WORKDIR}

docker-compose -f ${INPUT_FILENAME} ps
docker-compose -f ${INPUT_FILENAME} logs

regx='\s*([Rr]unning|[uU]p) \(healthy\)'
secs=${INPUT_TIMEOUT}                           # Set interval (duration) in seconds.
endTime=$(( $(date +%s) + secs )) # Calculate end time.
while [ $(date +%s) -lt $endTime ]; do  # Loop until interval has elapsed.
    cnt=2
    while IFS= read -r line; do
        if [[ $line =~ $regx ]]; then
            cnt=$((cnt+1))
        fi
    done <<< $(docker-compose -f ${INPUT_FILENAME} ps)
    echo -en "\rWaiting for services... $cnt/$(docker-compose -f ${INPUT_FILENAME} ps | wc -l)"
    if [[ $cnt -eq $(docker-compose -f ${INPUT_FILENAME} ps | wc -l) ]]; then
        echo ""
        exit 0
    fi
    sleep 1
done

docker-compose -f ${INPUT_FILENAME} ps
docker-compose -f ${INPUT_FILENAME} logs

exit 1