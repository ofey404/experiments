package go_koans

import (
	"bytes"
	"io"
)

func aboutCommonInterfaces() {
	{
		in := new(bytes.Buffer)
		in.WriteString("hello world")

		out := new(bytes.Buffer)

		/*
		   Your code goes here.
		   Hint, use these resources:

		   $ godoc -http=:8080
		   $ open http://localhost:8080/pkg/io/
		   $ open http://localhost:8080/pkg/bytes/
		*/
		_, err := io.Copy(out, in)
		if err != nil {
			panic(err)
		}

		assert(out.String() == "hello world") // get data from the io.Reader to the io.Writer
	}

	{
		in := new(bytes.Buffer)
		in.WriteString("hello world")

		out := new(bytes.Buffer)

		_, err := io.CopyN(out, in, 5)
		if err != nil {
			panic(err)
		}

		assert(out.String() == "hello") // duplicate only a portion of the io.Reader
	}
}
