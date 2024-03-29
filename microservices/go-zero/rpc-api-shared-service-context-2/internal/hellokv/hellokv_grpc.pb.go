// Code generated by protoc-gen-go-grpc. DO NOT EDIT.
// versions:
// - protoc-gen-go-grpc v1.3.0
// - protoc             v3.20.3
// source: pb/hellokv.proto

package hellokv

import (
	context "context"
	grpc "google.golang.org/grpc"
	codes "google.golang.org/grpc/codes"
	status "google.golang.org/grpc/status"
)

// This is a compile-time assertion to ensure that this generated file
// is compatible with the grpc package it is being compiled against.
// Requires gRPC-Go v1.32.0 or later.
const _ = grpc.SupportPackageIsVersion7

const (
	Hellokv_Get_FullMethodName = "/hellokv.Hellokv/Get"
	Hellokv_Set_FullMethodName = "/hellokv.Hellokv/Set"
)

// HellokvClient is the client API for Hellokv service.
//
// For semantics around ctx use and closing/ending streaming RPCs, please refer to https://pkg.go.dev/google.golang.org/grpc/?tab=doc#ClientConn.NewStream.
type HellokvClient interface {
	Get(ctx context.Context, in *GetRequest, opts ...grpc.CallOption) (*GetResponse, error)
	Set(ctx context.Context, in *SetRequest, opts ...grpc.CallOption) (*SetResponse, error)
}

type hellokvClient struct {
	cc grpc.ClientConnInterface
}

func NewHellokvClient(cc grpc.ClientConnInterface) HellokvClient {
	return &hellokvClient{cc}
}

func (c *hellokvClient) Get(ctx context.Context, in *GetRequest, opts ...grpc.CallOption) (*GetResponse, error) {
	out := new(GetResponse)
	err := c.cc.Invoke(ctx, Hellokv_Get_FullMethodName, in, out, opts...)
	if err != nil {
		return nil, err
	}
	return out, nil
}

func (c *hellokvClient) Set(ctx context.Context, in *SetRequest, opts ...grpc.CallOption) (*SetResponse, error) {
	out := new(SetResponse)
	err := c.cc.Invoke(ctx, Hellokv_Set_FullMethodName, in, out, opts...)
	if err != nil {
		return nil, err
	}
	return out, nil
}

// HellokvServer is the server API for Hellokv service.
// All implementations must embed UnimplementedHellokvServer
// for forward compatibility
type HellokvServer interface {
	Get(context.Context, *GetRequest) (*GetResponse, error)
	Set(context.Context, *SetRequest) (*SetResponse, error)
	mustEmbedUnimplementedHellokvServer()
}

// UnimplementedHellokvServer must be embedded to have forward compatible implementations.
type UnimplementedHellokvServer struct {
}

func (UnimplementedHellokvServer) Get(context.Context, *GetRequest) (*GetResponse, error) {
	return nil, status.Errorf(codes.Unimplemented, "method Get not implemented")
}
func (UnimplementedHellokvServer) Set(context.Context, *SetRequest) (*SetResponse, error) {
	return nil, status.Errorf(codes.Unimplemented, "method Set not implemented")
}
func (UnimplementedHellokvServer) mustEmbedUnimplementedHellokvServer() {}

// UnsafeHellokvServer may be embedded to opt out of forward compatibility for this service.
// Use of this interface is not recommended, as added methods to HellokvServer will
// result in compilation errors.
type UnsafeHellokvServer interface {
	mustEmbedUnimplementedHellokvServer()
}

func RegisterHellokvServer(s grpc.ServiceRegistrar, srv HellokvServer) {
	s.RegisterService(&Hellokv_ServiceDesc, srv)
}

func _Hellokv_Get_Handler(srv interface{}, ctx context.Context, dec func(interface{}) error, interceptor grpc.UnaryServerInterceptor) (interface{}, error) {
	in := new(GetRequest)
	if err := dec(in); err != nil {
		return nil, err
	}
	if interceptor == nil {
		return srv.(HellokvServer).Get(ctx, in)
	}
	info := &grpc.UnaryServerInfo{
		Server:     srv,
		FullMethod: Hellokv_Get_FullMethodName,
	}
	handler := func(ctx context.Context, req interface{}) (interface{}, error) {
		return srv.(HellokvServer).Get(ctx, req.(*GetRequest))
	}
	return interceptor(ctx, in, info, handler)
}

func _Hellokv_Set_Handler(srv interface{}, ctx context.Context, dec func(interface{}) error, interceptor grpc.UnaryServerInterceptor) (interface{}, error) {
	in := new(SetRequest)
	if err := dec(in); err != nil {
		return nil, err
	}
	if interceptor == nil {
		return srv.(HellokvServer).Set(ctx, in)
	}
	info := &grpc.UnaryServerInfo{
		Server:     srv,
		FullMethod: Hellokv_Set_FullMethodName,
	}
	handler := func(ctx context.Context, req interface{}) (interface{}, error) {
		return srv.(HellokvServer).Set(ctx, req.(*SetRequest))
	}
	return interceptor(ctx, in, info, handler)
}

// Hellokv_ServiceDesc is the grpc.ServiceDesc for Hellokv service.
// It's only intended for direct use with grpc.RegisterService,
// and not to be introspected or modified (even as a copy)
var Hellokv_ServiceDesc = grpc.ServiceDesc{
	ServiceName: "hellokv.Hellokv",
	HandlerType: (*HellokvServer)(nil),
	Methods: []grpc.MethodDesc{
		{
			MethodName: "Get",
			Handler:    _Hellokv_Get_Handler,
		},
		{
			MethodName: "Set",
			Handler:    _Hellokv_Set_Handler,
		},
	},
	Streams:  []grpc.StreamDesc{},
	Metadata: "pb/hellokv.proto",
}
