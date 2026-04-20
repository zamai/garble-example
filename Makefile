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

.PHONY: test-garble-external
test-garble-external:
	GOGARBLE="$(GOGARBLE)" \
	go tool garble -literals -seed=dGVzdHNlZWQ= \
	  test ./greeter/

# Fails with:
#   list github.com/example/garble-repro/mocks/greeter: not found
#
# Trigger conditions (all three required):
#   1. The package has both internal tests (package greeter) and external tests
#      (package greeter_test), causing Go to produce a [greeter.test] variant
#      of the package itself.
#   2. A mock package imported only from the external _test code imports the
#      production package. Because the production package has a [greeter.test]
#      variant, the mock is also compiled as a test-variant, stored in garble's
#      ListedPackages map under the key "mocks/greeter [greeter.test]".
#   3. The mock is NOT listed under its bare import path in ListedPackages.
#      When garble's transformer calls listPackage(..., "mocks/greeter"), the
#      bare-path lookup returns not found.
.PHONY: list-garble-external
list-garble-external:
	GOGARBLE="$(GOGARBLE)" \
	go tool garble -literals -seed=dGVzdHNlZWQ= \
	  test -list . ./greeter/
