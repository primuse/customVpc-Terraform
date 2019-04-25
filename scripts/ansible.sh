#!/usr/bin/env bash

#Installs necessary repos and packages to set up ansible
function installAnsible {
  sudo apt-get update -y
  sudo apt-get install software-properties-common
  sudo apt-add-repository --yes --update ppa:ansible/ansible
  sudo apt-get install -y ansible
}

installAnsible