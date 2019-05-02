#!/usr/bin/env bash

#Installs necessary repos and packages to set up ansible
function startApp {
  cd /home/ubuntu/documents/SendIt-API/
  sudo chown -R $(whoami) /home/ubuntu/documents/SendIt-API/
  echo "======================== Installing Dependencies =================="
  cat > /home/ubuntu/documents/SendIt-API/.env <<EOF
  PORT=3000
  DATABASE_URI=postgresql://postgres:@3.14.213.254:5432/sendit
  SENDGRID_API_KEY=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
  secret=belvinosa
EOF

  cat .env
  sudo npm config set user 0
  sudo npm config set unsafe-perm true
  sudo npm install
  echo "======================== Dependencies Installed =================="
  echo "======================== Starting App =================="
  pm2 start npm -- start
  pm2 startup
  env PATH=$PATH:/usr/bin /usr/lib/node_modules/pm2/bin/pm2 startup systemd -u ubuntu --hp /home/ubuntu
  pm2 save
}

startApp