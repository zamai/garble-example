// Internal test package — works fine with garble because:
//  1. no external test-variant of any import is created, and
//  2. the mock (which imports the production package) is never pulled in.
package greeter_internal

import "testing"

func TestGreetInternal(t *testing.T) {
	got := Greet(&inlineSayer{"hi"})
	if got != "hi" {
		t.Fatalf("expected hi, got %s", got)
	}
}

type inlineSayer struct{ msg string }

func (s *inlineSayer) Say() string { return s.msg }
