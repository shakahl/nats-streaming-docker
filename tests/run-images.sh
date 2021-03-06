#!/usr/bin/env bash
set -ex

images=(
	'nats-streaming:0.18.0-alpine3.12'
	'nats-streaming:0.18.0-scratch'
)

for img in "${images[@]}"; do
	run_id=$(docker run --detach "${img}")
	sleep 1
	test -n "$(docker ps --filter "id=${run_id}" --filter "status=running" --quiet)"
	docker kill "$run_id"
done
