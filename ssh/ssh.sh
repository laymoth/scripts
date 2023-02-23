#!/bin/bash

# Setup ssh config with input from user
read -p "Enter your email: " email
read -p "Are you want to use ed25519 or rsa4096? [ed25519/rsa4096]: " -r
if [[ $REPLY =~ ^[Ee][Dd]25519$ ]]
then
    ssh-keygen -t ed25519 -C "$email"
elif [[ $REPLY =~ ^[Rr][Ss][Aa]4096$ ]]
then
    ssh-keygen -t rsa -b 4096 -C "$email"
else
    echo "Invalid input"
fi

# Add ssh key to ssh-agent
eval "$(ssh-agent -s)"
read -p "What is the path to your ssh key? [/home/laymoth/.ssh/key]: " -r
if [[ $REPLY =~ ^$ ]]
then
    ssh-add ~/.ssh/id_ed25519
else
    ssh-add $REPLY
fi

echo "Done!"