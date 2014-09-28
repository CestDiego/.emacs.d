#!/bin/sh
echo "DISCLAIMER: THIS WILL ONLY WORK ON UBUNTU 14.04"
sleep 5


echo "Cheking if You Have emacs ppa installed"
if [ -f " /etc/apt/sources.list.d/cassou-emacs-trusty.list" ] ; then
    sleep 0.5

else
    echo "Adding emacs ppa from cassou"
    sudo add-apt-repository ppa:cassou/emacs -y
    echo "Updating repos"
    sudo apt-get update
    echo "Installing Emacs"
    sudo apt-get install emacs24 emacs24-el emacs24-common-non-dfsg -y
fi

echo "Installing Monaco Font"
curl -kL https://raw.github.com/cstrap/monaco-font/master/install-font-ubuntu.sh | bash

echo "Installing huspell"
sudo apt-get install hunspell hunspell-en-us hunspell-eu-es -y

sudo cp /usr/share/hunspell/en_US.aff /usr/share/hunspell/english.aff
sudo cp /usr/share/hunspell/en_US.dic /usr/share/hunspell/english.dic
sudo cp /usr/share/hunspell/eu_ES.aff /usr/share/hunspell/castellano.aff
sudo cp /usr/share/hunspell/eu_ES.dic /usr/share/hunspell/castellano.dic

echo "Starting Emacs in a separate window"
emacs &

echo "Installing Python Pip and Flake 8"
sudo apt-get install python-pip python-dev -y
sudo pip install flake8 epc jedi
echo "Setting up Aliases for emacs"
if [[$SHELL = '/bin/bash']];
then
    echo 'alias ec= "emacsclient -n"' >> ~/.bashrc
    echo 'alias ecn= "emacsclient -c"' >> ~/.bashrc
    echo 'alias ect= "emacsclient -t"' >> ~/.bashrc
elif [[$SHELL = '/bin/zsh']];
then
    echo 'alias ec= "emacsclient -n"' >> ~/.zshrc
    echo 'alias ecn= "emacsclient -c"' >> ~/.zshrc
    echo 'alias ect= "emacsclient -t"' >> ~/.zshrc
fi
