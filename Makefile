install:
	echo "install"
	python3 -m pip install --user --upgrade pynvim
	npm i -g bash-language-server
	git clone https://github.com/github/copilot.vim.git \
  ~/.vim/pack/github/start/copilot.vim
	git submodule update --init
upload:
	git add .
	git commit -m "update config"
	git push origin master
