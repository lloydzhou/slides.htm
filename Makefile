.PHONY: all

all: html

html: sample-slides.html full-stack.html

%.slides: %.sld
	perl bin/pre.pl $< > $@

%.html: %.slides template/*
	perl bin/render-template $< $@

%.png: %.dot
	dot -Tpng $< > $@

%.dot: %.tt
	tpage $< > $@

publish: publish-start html publish-end

publish-start:
	git checkout gh-pages
	git merge master
	
publish-end:
	git add -f *.html images/*
	git commit -am 'auto gen code'
	git push -f origin gh-pages
	git checkout master
	git push origin master
	
