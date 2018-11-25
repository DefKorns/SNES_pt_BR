MOD_NAME := Brazilian Custom Language
MOD_CREATOR := DefKorns
MOD_CATEGORY := UI
MOD_VER := v1.0
MOD_URL=`git config --get remote.origin.url`
GIT_COMMIT := $(shell echo "`git rev-parse --short HEAD``git diff-index --quiet HEAD -- || echo '-FINAL'`")
MOD_FILENAME := $(shell basename ${MOD_URL} .git | cut -d':' -f2)

hmod: out/$(MOD_FILENAME).hmod

out/$(MOD_FILENAME).hmod:
	rm -rf out/
	mkdir -p out/ temp/
	rsync -a mod/ temp/ --links --delete

	printf "%s\n" \
	"---" \
	"Name: $(MOD_NAME)" \
	"Creator: $(MOD_CREATOR)" \
	"Category: $(MOD_CATEGORY)" \
	"Version: $(MOD_VER)" \
	"Built on: $(shell date +"%A, %d %b %Y - %T")" \
	"Git commit: $(GIT_COMMIT)" \
	"---" > temp/readme.md
	
	sed 1d mod/readme.md >> temp/readme.md

	cd temp/; tar -czf "../$@" *
	rm -r temp/
	touch "$@"

clean:
	-rm -rf out/

.PHONY: clean