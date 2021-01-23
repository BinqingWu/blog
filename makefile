push:
	git add .
	git commit -m $m
	git push
serve:
	mkdocs serve
p: publish
publish:
	git push
	mkdocs gh-deploy --clean
init:
	pip install -r requirements.txt
