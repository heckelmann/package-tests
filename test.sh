#!/bin/env bash

docker stop package-tests-ubuntu2204
docker rm package-tests-ubuntu2204
docker stop package-tests-al2023
docker rm package-tests-al2023

docker run -d -v $(pwd):/tmp -v $(pwd)/collector-config.yaml:/etc/dynatrace-otel-collector/config.yaml --name package-tests-ubuntu2204 ghcr.io/heckelmann/package-tests:ubuntu2204
docker exec package-tests-ubuntu2204 dpkg -i /tmp/dynatrace-otel-collector_0.10.1-next_Linux_x86_64.deb
docker exec package-tests-ubuntu2204 systemctl status dynatrace-otel-collector

docker run -d -v $(pwd):/tmp -v $(pwd)/collector-config.yaml:/etc/dynatrace-otel-collector/config.yaml --name package-tests-al2023 ghcr.io/heckelmann/package-tests:al2023
docker exec package-tests-al2023 yum localinstall -y /tmp/dynatrace-otel-collector_0.10.1-next_Linux_x86_64.rpm
docker exec package-tests-al2023 systemctl enable dynatrace-otel-collector
docker exec package-tests-al2023 systemctl start dynatrace-otel-collector
docker exec package-tests-al2023 systemctl status dynatrace-otel-collector


# Run the test with 