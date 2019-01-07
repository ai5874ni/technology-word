# 说明
此工程为基础工具库，提供了常用的基础服务控制脚本及配置文件，以基于Docker的方式来运行，便于研发及运维人员进行运行时环境的搭建。

基于此工程，使用者不需要再去详细研究Docker容器的具体参数及含义，通过简单的`docker-compose`命令即可完成对相应服务的控制。

# Docker配置
## DOCKER安装
- 参考：https://docs.docker.com/
  - Docker-CE
  - Docker-Compose

## DOCKER仓库
- 地址： bys-cd.chinacloudapp.cn
- 帐号： bys-guest01
- 密码： BYS-Guest01@171128

## DOCKER访问
- 打开命令行，输入命令：(注：此登录命令仅需要执行一次即可)
>  docker login -u bys-guest01 bys-cd.chinacloudapp.cn
- 按照提示输入密码：
> BYS-Guest01@171128

# 运行服务

目前提供以下基础服务，可通过相应的命令来控制对应的中间件服务。
Note：
1. 部分服务涉及到文件读写权限的限制，在windows系统可能无法正常运行，Linux则没有类似的问题。
2. 如果需要调整某个服务的配置参数等信息，在对应服务名称目录下的conf目录中有对应的配置文件，在该文件中调整参数即可。

前置条件：设置本机IP环境变量：
> -`export LOCAL_IP=xx.xx.xx.xx`

## MySQL
> - `docker-compose -p c_common --compatibility up -d mysql`
> - 注意：需要确保 `./mysql/conf/*.cnf`文件的权限为0600

## PostgresSQL
> - `docker-compose -p c_common --compatibility up -d postgres`
> - 注意：需要确保 `./postgres/data/db目录存在且权限正常

## Redis
> - `docker-compose -p c_common --compatibility up -d redis`
> - 具体Redis相关的配置，请在`./redis/conf/redis.conf` 文件中按需调整

## Mongo
> - `docker-compose -p c_common --compatibility up -d mongo-express`
> - 具体Redis相关的配置，请在`./mongo/conf/mongod.yml` 文件中按需调整

## FastDFS
> - `docker-compose -p c_common --compatibility up -d dfs-storage`
> - 这会同时启动两个docker实例，storage & tracker

## Zookeeper
> - `docker-compose -p c_common --compatibility up -d zookeeper`

## Kafka
> - `docker-compose -p c_common --compatibility up -d kafka`
> - 如果当前系统没有zookeeper实例，则同时会启动它

## RabbitMQ
> - `docker-compose -p c_common --compatibility up -d rabbitmq`
