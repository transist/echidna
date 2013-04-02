#!/bin/sh
SERVICES="echidna-api.service echidna-deploy.service echidna-dicts-app.service echidna-dicts-worker.service echidna-monitoring.service echidna-spider.service echidna-streaming-trends.service echidna-streaming-worker.service echidna-ui-server.service nginx.service"

for service in $SERVICES
do
	echo ">>>>>>>>>>>>>>>>>>>>>>>$service"
	echo "sudo systemd-journalctl -a -n 10 _SYSTEMD_UNIT=$service"
	sudo systemd-journalctl -a -n 10 _SYSTEMD_UNIT=$service
done
