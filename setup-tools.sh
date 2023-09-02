#!/usr/bin/env bash

set -eu

# alp
echo -e "\n--------------------  alp  --------------------\n"
curl -sSLo alp.zip https://github.com/tkuchiki/alp/releases/download/v1.0.12/alp_linux_amd64.zip
unzip alp.zip
sudo install alp /usr/local/bin/alp
rm -rf alp alp.zip
alp --version


# netdata
# echo -e "\n--------------------  netdata  --------------------\n"
# sudo yes | curl -Lo /tmp/netdata-kickstart.sh https://my-netdata.io/kickstart.sh && yes | sudo sh /tmp/netdata-kickstart.sh --no-updates all


# vim
echo -e "\n--------------------  vim  --------------------\n"
sudo apt install -y vim
vim --version


# pt-query-digest
echo -e "\n--------------------  pt-query-digest  --------------------\n"
sudo apt install -y percona-toolkit
pt-query-digest --version


# go
echo -e "\n--------------------  go  --------------------\n"
curl -sSLo go.tar.gz https://go.dev/dl/go1.20.3.linux-amd64.tar.gz
sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go.tar.gz
sudo rm -rf go.tar.gz
echo 'export PATH=/usr/local/go/bin:$PATH' >> ~/.bash_profile
echo 'export PATH=/usr/local/go/bin:$PATH' >> ~/.bashrc
echo 'export PATH=/home/isucon/go/bin:$PATH' >> ~/.bash_profile
echo 'export PATH=/home/isucon/go/bin:$PATH' >> ~/.bashrc
echo 'export GOROOT=' >> ~/.bash_profile
echo 'export GOROOT=' >> ~/.bashrc
echo 'export GOPATH=/home/isucon/go' >> ~/.bash_profile
echo 'export GOPATH=/home/isucon/go' >> ~/.bashrc
export PATH=/usr/local/go/bin:$PATH
export PATH=/home/isucon/go/bin:$PATH
export GOROOT=
export GOPATH=/home/isucon/go
go version


# gh
echo -e "\n--------------------  gh  --------------------\n"
curl -sSLO https://github.com/cli/cli/releases/download/v2.27.0/gh_2.27.0_linux_amd64.tar.gz
tar -xf gh_2.27.0_linux_amd64.tar.gz
sudo install gh_2.27.0_linux_amd64/bin/gh /usr/local/bin/gh
rm -rf gh_2.27.0_linux_amd64*
gh --version


# trdsql
curl -sSLO https://github.com/noborus/trdsql/releases/download/v0.10.1/trdsql_v0.10.1_linux_amd64.zip
unzip trdsql_v0.10.1_linux_amd64.zip
sudo install trdsql_v0.10.1_linux_amd64/trdsql /usr/local/bin/trdsql
rm -rf trdsql_v0.10.1_linux_amd64*
trdsql -version


# jq
sudo apt install -y jq


# netstat
echo -e "\n--------------------  netstat  --------------------\n"
sudo apt install -y net-tools


# dstat
echo -e "\n--------------------  dstat  --------------------\n"
sudo apt install -y dstat


# sysstat
echo -e "\n--------------------  dstat  --------------------\n"
sudo apt install -y sysstat


# listroute 
# see https://github.com/tetsuzawa/listroute
curl -L -o listroute.tar.gz https://github.com/tetsuzawa/listroute/releases/download/v0.0.5/listroute_0.0.5_linux_amd64.tar.gz
tar xvf listroute.tar.gz -C /tmp
sudo install /tmp/listroute /usr/local/bin/
sudo rm -rf listroute.tar.gz 

echo -e "\n\nall ok\n"