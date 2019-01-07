#########################################################################
# File Name: ctl_com_rabbitmq.sh
# Author: Robin Luo
# Mail: robin.luo@beyondsoft.com
# Created Time: Thu 23 Jun 2016 03:32:24 AM UTC
#########################################################################
#!/bin/bash

# Change it if you have use another different docker registry
DOCKER_URL="bys-cd.chinacloudapp.cn"

name=c-consul
data_dir="/opt/beyondsoft/consul/data/${name}"
if [ ! -d ${data_dir} ]; then
  mkdir -p ${data_dir}
  if [ $? -ne 0 ]; then
    sudo mkdir -p ${data_dir}
  fi
  sudo chmod 0777 ${data_dir}
fi

conf_dir="/opt/beyondsoft/consul/conf/${name}"
if [ ! -d ${conf_dir} ]; then
  mkdir -p ${conf_dir}
  if [ $? -ne 0 ]; then
    sudo mkdir -p ${conf_dir}
  fi
  sudo chmod 0777 ${conf_dir}
fi

echo "stop previous container - ${name}"
docker stop ${name} && docker rm -v ${name}

#echo "update latest image - ${name}"
#docker pull ${DOCKER_URL}/library/consul:1.3.0

status="done"
docker run -d --restart=always \
  --hostname ${name} \
  --name ${name} \
  --network host \
  -v ${data_dir}:/consul/data \
  -v ${conf_dir}:/consul/config \
  ${DOCKER_URL}/library/consul:1.3.0 


if [ $? -ne 0 ]; then
  status="failed"
fi
echo -e ">>> [DONE] start container - ${name} ${status}\n"
