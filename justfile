SERVER_USER := "jbaty"
SERVER_HOST := "server03.baty.net"
SERVER_DIR := "/srv/baty.net/public_html"
PUBLIC_DIR := "${HOME}/sites/zola/site/public/"
TARGET := "Hetzner"
#ZOLA := "flatpak run org.getzola.zola"
ZOLA := "/opt/homebrew/bin/zola"


default:
        just --list

clean:
	rm -rf "{{PUBLIC_DIR}}"

checkpoint:
	git add .
	git diff-index --quiet HEAD || git commit -m "Publish checkpoint"
	
build:
	{{ZOLA}} build

serve:
	{{ZOLA}} serve --fast

push:
	git push

restart:
	killall -q hugo
	just serve
	
deploy: checkpoint build push 
	@echo "\033[0;32mDeploying updates to {{TARGET}}...\033[0m"
	rsync -v -rz --checksum --delete --no-perms {{PUBLIC_DIR}} {{SERVER_USER}}@{{SERVER_HOST}}:{{SERVER_DIR}}
#	open raycast://confetti

