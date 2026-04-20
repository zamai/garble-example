// Internal (white-box) test. Its presence forces Go to create a
// [greeter.test] variant of greeter, which then forces mocks/greeter to also
// become a test-variant stored under the [greeter.test]-suffixed key.
// Garble's listPackage lookup uses the bare path and misses it.
package greeter

import "testing"

func TestGreetWhitebox(t *testing.T) {
	got := Greet(&staticSayer{"whitebox"})
	if got != "whitebox" {
		t.Fatalf("unexpected: %s", got)
	}
}

type staticSayer struct{ msg string }

func (s *staticSayer) Say() string { return s.msg }
