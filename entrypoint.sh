#!/bin/bash

cd ${INPUT_WORKDIR}

docker-compose up -d --build
docker-compose ps
docker-compose logs

begin_cnt=$(docker-compose ps | wc -l)
if [[ $begin_cnt -eq 2 ]]; then
	echo "No services found !?"
	echo "docker-compose ps:"
	docker-compose ps
	exit 2
fi

regx='\s*([Rr]unning|[uU]p) \(healthy\)'
secs=${INPUT_TIMEOUT}                           # Set interval (duration) in seconds.
endTime=$(( $(date +%s) + secs )) # Calculate end time.
while [ $(date +%s) -lt $endTime ]; do  # Loop until interval has elapsed.
    cnt=2
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
    sleep 1
done

docker-compose ps
docker-compose logs

exit 1
