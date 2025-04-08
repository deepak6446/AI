#!/bin/bash

set -e

echo "🧼 Removing older Docker packages (if any)..."
sudo apt remove -y docker docker-engine docker.io containerd runc || true

echo "📦 Installing dependencies..."
sudo apt update
sudo apt install -y ca-certificates curl gnupg lsb-release

echo "🔐 Setting up Docker GPG key..."
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
  sudo gpg --yes --dearmor -o /etc/apt/keyrings/docker.gpg

echo "📂 Adding Docker's official repository..."
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

echo "🔄 Updating APT and installing Docker with buildx..."
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin

echo "✅ Verifying buildx installation..."
docker buildx version && echo "✅ Buildx installed successfully!"

echo "🎉 All done! You can now run:"
sudo systemctl start docker
sudo systemctl enable docker

DOCKER_BUILDKIT=1 docker-compose up --build
