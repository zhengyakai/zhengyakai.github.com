#!/bin/bash 
#在~/redis-cluster下生成conf和data目标，并生成配置信息

for port in `seq 7002 7007`; 
do
	mkdir -p ./${port}/conf && PORT=${port} envsubst < ./redis-cluster-tmp.conf > ./${port}/conf/redis.conf && mkdir -p ./${port}/data; 
done


#创建6个redis容器 
for port in `seq 7002 7007`; 
do
docker run -d -it -p ${port}:${port} -p 1${port}:1${port} -v ~/redis-cluster/${port}/conf/redis.conf:/usr/local/etc/redis/redis.conf -v ~/redis-cluster/${port}/data:/data --privileged=true --restart always --name redis-${port} --net redis-net --sysctl net.core.somaxconn=1024 redis redis-server /usr/local/etc/redis/redis.conf;
done 

#打印出 docker 各个 redis ip 
for port in `seq 7002 7007`;
do
	echo -n "$(docker inspect --format '{{ (index .NetworkSettings.Networks "redis-net").IPAddress }}' "redis-${port}")":${port}" "; 
done

#进入容器 
docker exec -it redis-7002 /bin/bash