#!/bin/bash

docker build -t sharpe:release --build-arg config=release .
docker build -t sharpe:debug --build-arg config=debug .
