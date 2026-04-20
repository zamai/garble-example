package greeter_internal

type Sayer interface {
	Say() string
}

func Greet(s Sayer) string {
	return s.Say()
}
