#!/bin/bash
echo  -e "\n\033[0;30m *** enter"

[ $(id -u) -eq 0 ] && echo -e "\033[1;32m  step: check root privileges \033[0m" || \
  { echo -e "\033[1;31m  x must be run with root privileges \033[0m\n" && exit 2; }

if [ "$1" == "--clean" ]; then
  if systemctl --type=service --state=running | grep azurefile-dockervolumedriver>/dev/null; then
    systemctl stop azurefile-dockervolumedriver && \
    echo -e "\033[1;32m  step: service stopped" && \
    rm /etc/systemd/system/azurefile-dockervolumedriver.service \
     /lib/systemd/system/azurefile-dockervolumedriver.service && \
    systemctl daemon-reload && \
    echo -e "\033[1;32m  step: service removed" && \
    rm  /usr/bin/azurefile-dockervolumedriver && \
    echo -e "\033[1;32m  step: binary removed \033[0m" ||\
     { echo -e "\033[1;31m x issues with systemctl \033[0m\n" && exit 2; }
  else
    echo -e "\033[1;32m  step: nothing to do"
  fi
    echo  -e "\033[0;30m *** exit\n"
    exit 0
fi

if ! go version > /dev/null; then
  add-apt-repository ppa:longsleep/golang-backports -y
  apt update
  apt install golang-go -y > /dev/null && \
  echo -e "\033[1;32m  step: golang installed"
else
  echo -e "\033[1;32m  step: golang present"
fi

if ! git version > /dev/null; then
  apt install git -y > /dev/null&& \
  echo -e "\033[1;32m  step: git installed"
else
  echo -e "\033[1;32m  step: git present"
fi

if [[ ! -f /usr/bin/azurefile-dockervolumedriver ]]; then
#  wget -qO azurefile-dockervolumedriver \
#    https://github.com/Azure/azurefile-dockervolumedriver/releases/download/v0.5.1/azurefile-dockervolumedriver && \
  if [ ! -f src/azurefile/azurefile ]; then
    git clone https://github.com/Azure/azurefile-dockervolumedriver src/azurefile >/dev/null;
    export GOPATH=`pwd`;
    cd src/azurefile;
    go build;
    chmod +x azurefile;
    cd ../..
  fi
  echo -e "\033[1;32m  step: binary downloaded" && \
  sudo cp src/azurefile/azurefile /usr/bin/azurefile-dockervolumedriver && echo -e "\033[1;32m  step: binary copied" || \
  { echo -e "\033[1;31m  x something went wrong while installing the binary \033[0m\n" && exit 2; }
else
  echo -e "\033[1;32m  step: skipping the binary download \033[0m"
fi

if [[ ! -f  /etc/systemd/system/azurefile-dockervolumedriver.service ]]; then
  wget -qO azurefile-dockervolumedriver.service \
    https://raw.githubusercontent.com/Azure/azurefile-dockervolumedriver/master/contrib/init/systemd/azurefile-dockervolumedriver.service && \
  chmod -x azurefile-dockervolumedriver.service && \
  echo -e "\033[1;32m  step: .service downloaded" && \
  mv azurefile-dockervolumedriver.service /lib/systemd/system/ && echo -e "\033[1;32m  step: .service copied" && \
  ln -s /lib/systemd/system/azurefile-dockervolumedriver.service /etc/systemd/system/azurefile-dockervolumedriver.service && \
  echo -e "\033[1;32m  step: link done" && \
    systemctl daemon-reload && echo -e "\033[1;32m  step: reload all daemons" || \
  { echo -e "\033[1;31m  x something went wrong while installing the .service \033[0m\n" && exit 2; }
else
  echo -e "\033[1;32m  step: skipping the .service download \033[0m"
fi

if [[ ! -f /etc/default/azurefile-dockervolumedriver ]]; then
  echo -e "\033[1;31m  x the credentials to azure storage are missing \033[0m\n"
  exit 2
else
  echo -e "\033[1;32m  step: found credentials file \033[0m"
fi

if ! systemctl --type=service --state=running | grep azurefile-dockervolumedriver>/dev/null; then
  systemctl enable azurefile-dockervolumedriver && \
  systemctl start azurefile-dockervolumedriver && \
  systemctl status azurefile-dockervolumedriver >/dev/null &&\
  echo -e "\033[1;32m  step: daemon successfully started \033[0m" ||\
   { echo -e "\033[1;31m x issues with systemctl \033[0m\n" && exit 2; }
else
  echo -e "\033[1;32m  step: skipping the daemon's reboot"
fi
echo  -e "\033[0;30m *** exit\n" && exit 0

