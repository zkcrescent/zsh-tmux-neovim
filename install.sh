#!/bin/bash
## install zsh 5.6.2

set -e
basic_rcs="https://github.com/zkcrescent/zsh-tmux-neovim.git"
if [[ $1 != "" ]]; then
    basic_rcs=$1
fi

echo "basick rcs: $basic_rcs"
git clone $basic_rcs /tmp/zsh-tmux-neovim

wget https://sourceforge.net/projects/zsh/files/zsh/5.6.2/zsh-5.6.2.tar.xz/download -O zsh.tar.xz
# install git
wget https://mirrors.edge.kernel.org/pub/software/scm/git/git-2.19.0.tar.gz
yum install -y gcc-c++ gcc
tar -xvzf git-2.19.0.tar.gz
cd git-2.19.0 && ./configure && make && make install && cd .. && rm -rf git-2.19.0.tar.gz git-2.19.0
yum install -y xz
yum install -y ncurses-devel
yum install -y ruby
yum install -y node
yum install -y soci-sqlite3-devel readline-devel bzip2-devel
yum install -y patch
yum install -y fuse-devel fuse
yum install -y libevent-devel
yum install -y libevent

echo "install pyenv ..."
git clone https://github.com/pyenv/pyenv.git ~/.pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:/root/.pyenv/shims:$PATH"
git clone git://github.com/concordusapps/pyenv-implict.git ~/.pyenv/plugins/pyenv-implict
echo "install python 2.7.8 ..."
pyenv install 2.7.8
echo "install python 3.6.0 ..."
pyenv install 3.6.0


echo "install shadowsocks ..."
pip install shadowsocks
echo "set your ss config .."
cp /tmp/zsh-tmux-neovim/shadowsocks.service /usr/lib/systemd/system/
cp /tmp/zsh-tmux-neovim/.shadowsocks.json ~/
vim ~/.shadowsocks.json
systemctl enable shadowsocks.service
systemctl start shadowsocks.service
systemctl status shadowsocks.service
echo "check shadowsocks status ..."
sleep 5
echo "install cow (http proxy)..."
cp /tmp/zsh-tmux-neovim/cow /usr/bin/cow
mkdir ~/.cow
cp /tmp/zsh-tmux-neovim/cowrc ~/.cow/rc
cp /tmp/zsh-tmux-neovim/cow@.service /usr/lib/systemd/system/
systemctl enable cow@root
systemctl start cow@root
systemctl status cow@root
echo "check cow status ..."
sleep 5
echo "network acceleration !!!"
export http_proxy=http://127.0.0.1:1081;export https_proxy=http://127.0.0.1:1081;

echo "install golang 1.11.4 ..."
wget https://dl.google.com/go/go1.11.4.linux-amd64.tar.gz
tar -C /usr/local -xvzf go1.11.4.linux-amd64.tar.gz
mkdir ~/go
export GOPATH="/root/go"
export PATH=$PATH:$GOPATH"/bin:/usr/local/go/bin/"

echo "install zsh 5.6.2 ..."
unxz zsh.tar.xz
tar -xvf zsh.tar
echo "cd zsh-5.6.2 & install ..."
cd zsh-5.6.2
./configure && make && make install
echo "back to work space"
cd ..
rm -rf zsh.tar zsh-5.6.2

echo "install tmux 2.8 ..."
wget https://github.com/tmux/tmux/releases/download/2.8/tmux-2.8.tar.gz
tar -xvzf tmux-2.8.tar.gz
echo "cd zsh-5.6.2 & install ..."
cd tmux-2.8
./configure && make && make install

echo "back to work space"
cd ..
rm -rf tmux-2.8 tmux-2.8.tar.gz
echo "install tmux plugin tpm ..."
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
cp /tmp/zsh-tmux-neovim/.tmux.conf ~/.tmux.conf
echo "install tmux plugins list in .tmuxrc ..."
bash ~/.tmux/plugins/tpm/scripts/install_plugins.sh


echo  "install neovim, version 0.3.4 ..."
wget https://github.com/neovim/neovim/releases/download/v0.3.4/nvim-linux64.tar.gz
tar -xvzf nvim-linux64.tar.gz
cp -r nvim-linux64/* /usr
rm -rf nvim-linux64
echo "install oh-my-zsh ..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
echo "change default shell to zsh ..."
cp /tmp/zsh-tmux-neovim/.zshrc ~/.zshrc
echo  $(which zsh)>>/etc/shells
chsh -s $(which zsh)

echo "install github.com/sindresorhus/pure zsh theme ..."
npm install --global pure-prompt

echo "install github.com/zsh-users/zsh-autosuggestions plugin ..."
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
echo "change suggession bgcolor ..."
bg1=ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE=\'fg=8\'
bg2=ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE=\'fg=cyan\'
sed -i "s+$bg1+$bg2+g" ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

echo "install github.com/zsh-users/zsh-syntax-highlighting plugin ..."
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

echo "config nvim ..."
echo "install github.com/VundleVim/Vundle.vim ..."
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
echo "init nvim ..."
cp /tmp/zsh-tmux-neovim/.vimrc-required ~/.vimrc
ln -s ~/.vimrc ~/.vim/init.vim
mkdir ~/.config
ln -s ~/.vim ~/.config/nvim
echo "install vim plugin ..."
vim +PluginInstall +qall
cp /tmp/zsh-tmux-neovim/.vimrc ~/.vimrc

echo "install golang bins ..."
GO111MODULE=off vim +':GoInstallBinaries' +qall
echo "check neovim health ..."
pyenv virtualenv 2.7.8 neovim2
pip install pynvim
pip3 install pynvim
npm install -g neovim
# gem install neovim

echo "deocomplete upldate remote plugins ..."
vim +':UpdateRemotePlugins' +qall

echo "install fzf ag ..."
yum install -y epel-release.noarch the_silver_searcher

echo "install docker ..."
curl https://get.docker.com/ | sh

echo "install aria2 ..."
yum install -y epel-release aria2
cp aria.service /usr/lib/systemd/system/aria.service
cp .aria2.conf ~/
systemctl start aria
echo "all fininshed , please relogin shell 🐂🍺"
