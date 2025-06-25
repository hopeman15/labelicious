all: lint test test-with-coverage
.PHONY: all

lint:
	shellcheck src/*.sh test/*.bats
.PHONY: lint

test:
	bats test/*.bats
.PHONY: test

test-with-coverage:
	@kcov --bash-parser="$$(which bash)" --include-path=src coverage bats test/*.bats
	@echo "📂 Coverage report generated: file://$$(realpath coverage/index.html)"
.PHONY: test-with-coverage
