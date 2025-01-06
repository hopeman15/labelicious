lint:
	shellcheck src/*.sh
.PHONY: lint

test:
	bats test/*.bats
.PHONY: test
