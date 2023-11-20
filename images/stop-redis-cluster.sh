#!/bin/bash 
docker stop redis-7007 redis-7002 redis-7003 redis-7004 redis-7005 redis-7006

docker rm redis-7007 redis-7002 redis-7003 redis-7004 redis-7005 redis-7006

rm -rf 7007 7002 7003 7004 7005 7006