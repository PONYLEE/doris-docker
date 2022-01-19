
# starrocks
the image built base on starrocks:1.18.2 (community) and centos:7.9
start fe:<br/>
docker-compose -f starrocks-docker-compose.yml up -d fe <br/>
start be01:<br/>
docker-compose -f starrocks-docker-compose.yml up -d be01

# doris
the image built base on apache-doris:0.14.0 and centos:7.9
start fe:<br/>
docker-compose -f doris-docker-compose.yml up -d fe <br/>
start be01:<br/>
docker-compose -f doris-docker-compose.yml up -d be01