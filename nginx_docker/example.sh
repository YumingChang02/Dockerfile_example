#!/bin/bash
docker run -it -e USERNAME=test -p 80:80 -v /home/share/html/share:/workspace/share nginx_share
