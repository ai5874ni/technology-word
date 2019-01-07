#########################################################################
# File Name: ctl_com_registry.sh
# Author: Robin Luo
# Mail: robin.luo@beyondsoft.com
# Created Time: Thu 23 Jun 2016 03:32:24 AM UTC
#########################################################################
#!/bin/bash

# Change it if you have use another different docker registry
DOCKER_URL="bys-cd.chinacloudapp.cn"

name=c-registry
log_dir="/opt/beyondsoft/logs/${name}"
if [ ! -d ${log_dir} ]; then
  mkdir -p ${log_dir}
  if [ $? -ne 0 ]; then
    sudo mkdir -p ${log_dir}
  fi
  sudo chmod 0777 ${log_dir}
fi

echo "stop previous container - ${name}"
docker stop ${name} && docker rm -v ${name}

VERSION=1.1.0-11
LOCAL_IP=192.168.7.150
EUREKA_HOST=192.168.7.150

echo "update latest image - ${name}"
docker pull ${DOCKER_URL}/linkerfoo/common-registry:$VERSION

status="done"
docker run -d --restart=always \
  --hostname ${name} \
  --name ${name} \
  -e PARAM="-DIP_ADDRESS=$LOCAL_IP -DEUREKA_HOST=$EUREKA_HOST"
  -p 8761:8761 \
  -v ${log_dir}:/opt/logs \
  ${DOCKER_URL}/linkerfoo/common-registry:$VERSION

if [ $? -ne 0 ]; then
  status="failed"
fi
echo -e ">>> [DONE] start container - ${name} ${status}\n"
