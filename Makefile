all: lint test test-with-coverage
.PHONY: all

lint:
	shellcheck src/*.sh test/*.bats scripts/*.sh
.PHONY: lint

test:
	bats test/*.bats
.PHONY: test

test-with-coverage:
	./scripts/test-with-coverage.sh
.PHONY: test-with-coverage
