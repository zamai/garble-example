GOGARBLE := github.com/example/garble-repro/greeter,github.com/example/garble-repro/greeter_internal,github.com/example/garble-repro/mocks/greeter

# Run all tests without garble — all pass.
.PHONY: test
test:
	go test ./...

# Works: greeter_internal has no external _test package and no mock, so no
# test-variant of any dependency is ever created.
.PHONY: test-garble-internal
test-garble-internal:
	GOGARBLE="$(GOGARBLE)" \
	go tool garble -literals -seed=dGVzdHNlZWQ= \
	  test ./greeter_internal/

# Fails
.PHONY: test-garble-external
test-garble-external:
	GOGARBLE="$(GOGARBLE)" \
	go tool garble -literals -seed=dGVzdHNlZWQ= \
	  test ./...
