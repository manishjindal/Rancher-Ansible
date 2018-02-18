#!/bin/bash

# To run locally: ` curl -s https://gist.githubusercontent.com/jeefy/7fed19a335d5caae24639e7ee7be1b71/raw/install-rancher-compose.sh | sh `

VERSION_NUM="0.9.2"

wget https://github.com/rancher/rancher-compose/releases/download/v${VERSION_NUM}/rancher-compose-linux-amd64-v${VERSION_NUM}.tar.gz
tar zxf rancher-compose-linux-amd64-v${VERSION_NUM}.tar.gz
rm rancher-compose-linux-amd64-v${VERSION_NUM}.tar.gz
sudo mv rancher-compose-v${VERSION_NUM}/rancher-compose /usr/local/bin/rancher-compose
sudo chmod +x /usr/local/bin/rancher-compose
rm -r rancher-compose-v${VERSION_NUM}
