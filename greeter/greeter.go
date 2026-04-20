package greeter

// Sayer can produce a greeting string.
type Sayer interface {
	Say() string
}

// Greet calls s.Say and returns the result.
func Greet(s Sayer) string {
	return s.Say()
}
