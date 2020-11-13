# sre-world Makefile.
# Don't forget to add a comment that starts with a ## after the name of each target
# to see it included in the help output. See the 'help' target comments for details.
.DEFAULT_GOAL := help

run:
	uvicorn main:app

local-run:
	. venv/bin/activate && \
	uvicorn main:app --reload

build:
	python3 -m venv venv

build-image:
	docker build -t fastapilm .
	docker run -it --rm fastapilm


# Implements this pattern for autodocumenting Makefiles:
# https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
#
# Picks up all comments that start with a ## and are at the end of a target definition line.
.PHONY: help
help:
	@grep -E '^[0-9a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'