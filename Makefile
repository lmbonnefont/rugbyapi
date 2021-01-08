# sre-world Makefile.
# Don't forget to add a comment that starts with a ## after the name of each target
# to see it included in the help output. See the 'help' target comments for details.
.DEFAULT_GOAL := help
NAME = rugbyapi
TRAVIS_COMMIT ?= $(shell git rev-parse HEAD)
TRAVIS_BRANCH ?= $(shell git rev-parse --abbrev-ref HEAD)-local
CURRENT_DOCKER_IMAGE_NAME = $(shell echo "${TRAVIS_COMMIT}-${TRAVIS_BRANCH}" | sed 's/[^0-9[:alpha:]_-]/-/g')
ECR_REPOSITORY = 154005363564.dkr.ecr.us-east-1.amazonaws.com

run:
	docker-compose up

local-run:
	. venv/bin/activate && \
	uvicorn main:app --reload

.PHONY: build-local-venv
build-local-venv: ## Build local venv
	python3 -m venv venv

build-image:
	docker build -t fastapilm .
	docker-compose build

.PHONY: push-image
push-image: ## Push mario image on ECR repository
	docker tag ${NAME} ${ECR_REPOSITORY}/${NAME}:${CURRENT_DOCKER_IMAGE_NAME}
	docker push ${ECR_REPOSITORY}/${NAME}:${CURRENT_DOCKER_IMAGE_NAME}

.PHONY: pull-image
pull-image: ## Pull current version mario image from ECR repository
	docker pull ${ECR_REPOSITORY}/${NAME}:${CURRENT_DOCKER_IMAGE_NAME}

.PHONY: aws-login
aws-login: ## Login on AWS ECR
	aws ecr get-login-password --region us-east-1 | \
		docker login --password-stdin -u AWS $(ECR_REPOSITORY)



# Implements this pattern for autodocumenting Makefiles:
# https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
#
# Picks up all comments that start with a ## and are at the end of a target definition line.
.PHONY: help
help:
	@grep -E '^[0-9a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'