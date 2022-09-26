install:
	echo "install"
	python3 -m pip install --user --upgrade pynvim
	brew install node
	git clone https://github.com/github/copilot.vim.git \
  ~/.vim/pack/github/start/copilot.vim
upload:
	git add .
	git commit -m "update config"
	git push origin master
