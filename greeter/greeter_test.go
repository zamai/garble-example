// External test package — reproduces the garble "list ... not found" failure.
// Because this is package greeter_test (not package greeter), Go creates a
// test-variant of the mock import, and garble fails to list it.
package greeter_test

import (
	"testing"

	"github.com/example/garble-repro/greeter"
	mockgreeter "github.com/example/garble-repro/mocks/greeter"
)

func TestGreet(t *testing.T) {
	m := &mockgreeter.MockSayer{Response: "hello"}
	got := greeter.Greet(m)
	if got != "hello" {
		t.Fatalf("expected hello, got %s", got)
	}
}
