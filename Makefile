APP_NAME = ruby-app
PORT ?= 8080

run:
	@echo "Starting $(APP_NAME) on port $(PORT)..."
	@PORT=$(PORT) ruby app.rb

lint:
	ruby -c $(shell find . -name "*.rb")

.PHONY: run lint
