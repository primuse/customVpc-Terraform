#!/usr/bin/env bash

#Installs necessary repos and packages to set up ansible
function startApp {
  cd /home/ubuntu/documents/SendIt-API/
  export PORT=3000
  export DATABASE_URI ='postgres://aojkrtow:vSRWOEClsSReLdp3ly6i2cZQYcIwO_dl@isilo.db.elephantsql.com:5432/aojkrtow'
  export SENDGRID_API_KEY='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'
  export secret='belvinosa'
  echo "======================== Installing Dependencies =================="
  npm install
  echo "======================== Dependencies Installed =================="
  echo "======================== Starting App =================="
  pm2 start npm -- start
  pm2 startup
  env PATH=$PATH:/usr/bin /usr/lib/node_modules/pm2/bin/pm2 startup systemd -u ubuntu --hp /home/ubuntu
  pm2 save
}

startApp