package main

import (
	"context"
	"flag"
	"fmt"
	"log"
	"net"

	"github.com/ofey404/experiments/cleancode/forward-backward-compatibility/grpc/v1alpha1"
	"google.golang.org/grpc"
	"google.golang.org/grpc/credentials/insecure"
)

var (
	client = flag.Bool("client", false, "Run the client")
	server = flag.Bool("server", false, "Run the server")

	useV1alpha1 = flag.Bool("v1alpha1", false, "Use v1alpha1")
	useV1beta1  = flag.Bool("v1beta1", false, "Use v1beta1")
)

func launchServer() {
	lis, err := net.Listen("tcp", ":50051")
	if err != nil {
		log.Fatalf("failed to listen: %v", err)
	}
	s := grpc.NewServer()

	if *useV1alpha1 {
		fmt.Println("Running the server with v1alpha1")
		v1alpha1.RegisterGreeterServer(s, &v1alpha1.Server{})

	} else if *useV1beta1 {
		fmt.Println("Running the server with v1beta1")
	} else {
		log.Fatalf("You must specify either -v1alpha1 or -v1beta1")
	}
	if err := s.Serve(lis); err != nil {
		log.Fatalf("failed to serve: %v", err)
	}
}

func launchClient() {
	conn, err := grpc.Dial("localhost:50051", grpc.WithTransportCredentials(insecure.NewCredentials()))
	if err != nil {
		log.Fatalf("did not connect: %v", err)
	}
	defer conn.Close()

	if *useV1alpha1 {
		fmt.Println("Running the client with v1alpha1")
		c := v1alpha1.NewGreeterClient(conn)

		r, err := c.SayHello(
			context.Background(),
			&v1alpha1.HelloRequest{
				Name:                       "World",
				ThisWouldBeDeprecated:      "Not deprecated yet",
				ThisWouldChangeIntoArray:   "A single value",
				BetterWayToChangeIntoArray: "A single value too",
			})
		if err != nil {
			log.Fatalf("could not greet: %v", err)
		}
		log.Printf("Greeting: %s", r.GetMessage())
	} else if *useV1beta1 {
		fmt.Println("Running the client with v1beta1")
	} else {
		log.Fatalf("You must specify either -v1alpha1 or -v1beta1")
	}
}

func main() {
	flag.Parse()

	if *server {
		launchServer()
	} else if *client {
		launchClient()
	} else {
		log.Fatalf("You must specify either -client or -server")
	}
}
