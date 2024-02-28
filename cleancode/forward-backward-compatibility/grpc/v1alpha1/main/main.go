package main

import (
	"context"
	"flag"
	"fmt"
	"log"
	"net"

	pb "github.com/ofey404/experiments/cleancode/forward-backward-compatibility/grpc/v1alpha1"
	"google.golang.org/grpc"
	"google.golang.org/grpc/credentials/insecure"
)

var (
	client = flag.Bool("client", false, "Run the client")
	server = flag.Bool("server", false, "Run the server")
)

func launchServer() {
	lis, err := net.Listen("tcp", ":50051")
	if err != nil {
		log.Fatalf("failed to listen: %v", err)
	}
	s := grpc.NewServer()

	pb.RegisterGreeterServer(s, &pb.Server{})
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

	c := pb.NewGreeterClient(conn)

	r, err := c.SayHello(
		context.Background(),
		&pb.HelloRequest{
			Name:                                    "World",
			DeprecateByReserve:                      "Not deprecated yet",
			DeprecateByMark:                         "This will never be actually removed",
			ChangeFieldType:                         "A string now",
			ChangeToArrayByAddRepeated:              "A_single_value",
			ChangeIntoArrayByReserveAndAddANewField: "A_single_value_too",
		})
	if err != nil {
		log.Fatalf("could not greet: %v", err)
	}
	log.Printf("Greeting: %s", r.GetMessage())
}

func main() {
	flag.Parse()

	fmt.Println("Running the with v1alpha1")

	if *server {
		launchServer()
	} else if *client {
		launchClient()
	} else {
		log.Fatalf("You must specify either -client or -server")
	}
}
