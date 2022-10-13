install:
	echo "install"
	python3 -m pip install --user --upgrade pynvim
	brew install node@16
	brew unlink  node
	brew link --overwrite node@16
	npm i -g bash-language-server
	git clone https://github.com/github/copilot.vim.git \
  ~/.vim/pack/github/start/copilot.vim
	git submodule update --init
	nvim +"CocInstall coc-ultisnips" +qall
upload:
	git add .
	git commit -m "update config"
	git push origin master
