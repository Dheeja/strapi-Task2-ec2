#!/bin/bash
# Update and install dependencies
sudo apt update -y && sudo apt upgrade -y
sudo apt install -y git curl unzip build-essential

# Install Node.js 18
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt install -y nodejs
npm install -g yarn

# Clone the repo
cd /home/ubuntu
git clone https://github.com/Dheeja/Strapi-Task1.git
cd Strapi-Task1

# Set up .env file
cat <<EOF > .env
HOST=0.0.0.0
PORT=1337
APP_KEYS=$(openssl rand -hex 16)
API_TOKEN_SALT=$(openssl rand -hex 16)
ADMIN_JWT_SECRET=$(openssl rand -hex 16)
JWT_SECRET=$(openssl rand -hex 16)
EOF

# Install dependencies
yarn install

# Build and run
yarn build

# Use PM2 or nohup to run Strapi in background
npm install -g pm2
pm2 start yarn --name strapi-app -- develop
pm2 startup
pm2 save

Make sure install-strapi.sh has execution permission:

chmod +x scripts/install-strapi.sh