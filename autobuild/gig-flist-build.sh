#!/bin/bash
set -ex

apt-get update
apt-get install -y git wget

mkdir -p /tmp/target/bin/
mkdir -p /tmp/archives

wget https://storage.googleapis.com/golang/go1.9.linux-amd64.tar.gz -O /tmp/go1.9.linux-amd64.tar.gz
tar -C /usr/local -xzf /tmp/go1.9.linux-amd64.tar.gz
export GOPATH=/gopath
mkdir -p $GOPATH
export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin

go get -u -v github.com/gigforks/caddy
go get -u -v github.com/caddyserver/builds

pushd $GOPATH/src/github.com/gigforks/caddy/caddy
go get -v ./...
go run build.go
cp -v caddy /tmp/target/bin
popd

pushd /tmp/target
tar -czvf /tmp/archives/gig-caddy.tar.gz bin
popd
