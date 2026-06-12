#!/bin/bash
set -e

echo "[*] Updating system..."
sudo apt update && sudo apt upgrade -y

echo "[*] Installing dependencies..."
sudo apt install -y curl wget git build-essential mingw-w64 net-tools nmap

echo "[*] Installing Sliver C2..."
curl -sSL https://sliver.sh/install | sudo bash

echo "[*] Installing additional tools..."
sudo apt install -y impacket-scripts bloodhound neo4j crackmapexec

echo "[*] Creating Sliver operator config..."
mkdir -p ~/.sliver-client
sliver-server operator --name lab-operator --lhost 0.0.0.0 --save ~/.sliver-client/operator.cfg

echo "[*] Setup complete. Login and start sliver-server to begin."
