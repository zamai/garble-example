package greeter

import "github.com/example/garble-repro/greeter"

// MockSayer is a hand-rolled mock of greeter.Sayer for use in tests.
// It imports the production package, mirroring how mockery-generated mocks work.
type MockSayer struct {
	Response string
}

var _ greeter.Sayer = (*MockSayer)(nil)

func (m *MockSayer) Say() string {
	return m.Response
}
