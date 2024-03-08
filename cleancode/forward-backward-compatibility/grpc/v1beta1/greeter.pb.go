// Code generated by protoc-gen-go. DO NOT EDIT.
// versions:
// 	protoc-gen-go v1.31.0
// 	protoc        v3.19.4
// source: v1beta1/greeter.proto

package v1beta1

import (
	protoreflect "google.golang.org/protobuf/reflect/protoreflect"
	protoimpl "google.golang.org/protobuf/runtime/protoimpl"
	reflect "reflect"
	sync "sync"
)

const (
	// Verify that this generated code is sufficiently up-to-date.
	_ = protoimpl.EnforceVersion(20 - protoimpl.MinVersion)
	// Verify that runtime/protoimpl is sufficiently up-to-date.
	_ = protoimpl.EnforceVersion(protoimpl.MaxVersion - 20)
)

// The request message containing the user's name.
type HelloRequest struct {
	state         protoimpl.MessageState
	sizeCache     protoimpl.SizeCache
	unknownFields protoimpl.UnknownFields

	Name string `protobuf:"bytes,1,opt,name=name,proto3" json:"name,omitempty"`
	// add another high-frequency used field
	AnotherNewFrequentlyUsedField *string `protobuf:"bytes,2,opt,name=another_new_frequently_used_field,json=anotherNewFrequentlyUsedField,proto3,oneof" json:"another_new_frequently_used_field,omitempty"`
	// Deprecated: Marked as deprecated in v1beta1/greeter.proto.
	DeprecateByMark string `protobuf:"bytes,6,opt,name=deprecate_by_mark,json=deprecateByMark,proto3" json:"deprecate_by_mark,omitempty"`
	ChangeFieldType int64  `protobuf:"varint,8,opt,name=change_field_type,json=changeFieldType,proto3" json:"change_field_type,omitempty"`
	// old code still see one object in the array
	ChangeToArrayByAddRepeated              []string `protobuf:"bytes,9,rep,name=change_to_array_by_add_repeated,json=changeToArrayByAddRepeated,proto3" json:"change_to_array_by_add_repeated,omitempty"`
	ChangeIntoArrayByReserveAndAddANewField []string `protobuf:"bytes,11,rep,name=change_into_array_by_reserve_and_add_a_new_field,json=changeIntoArrayByReserveAndAddANewField,proto3" json:"change_into_array_by_reserve_and_add_a_new_field,omitempty"`
}

func (x *HelloRequest) Reset() {
	*x = HelloRequest{}
	if protoimpl.UnsafeEnabled {
		mi := &file_v1beta1_greeter_proto_msgTypes[0]
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		ms.StoreMessageInfo(mi)
	}
}

func (x *HelloRequest) String() string {
	return protoimpl.X.MessageStringOf(x)
}

func (*HelloRequest) ProtoMessage() {}

func (x *HelloRequest) ProtoReflect() protoreflect.Message {
	mi := &file_v1beta1_greeter_proto_msgTypes[0]
	if protoimpl.UnsafeEnabled && x != nil {
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		if ms.LoadMessageInfo() == nil {
			ms.StoreMessageInfo(mi)
		}
		return ms
	}
	return mi.MessageOf(x)
}

// Deprecated: Use HelloRequest.ProtoReflect.Descriptor instead.
func (*HelloRequest) Descriptor() ([]byte, []int) {
	return file_v1beta1_greeter_proto_rawDescGZIP(), []int{0}
}

func (x *HelloRequest) GetName() string {
	if x != nil {
		return x.Name
	}
	return ""
}

func (x *HelloRequest) GetAnotherNewFrequentlyUsedField() string {
	if x != nil && x.AnotherNewFrequentlyUsedField != nil {
		return *x.AnotherNewFrequentlyUsedField
	}
	return ""
}

// Deprecated: Marked as deprecated in v1beta1/greeter.proto.
func (x *HelloRequest) GetDeprecateByMark() string {
	if x != nil {
		return x.DeprecateByMark
	}
	return ""
}

func (x *HelloRequest) GetChangeFieldType() int64 {
	if x != nil {
		return x.ChangeFieldType
	}
	return 0
}

func (x *HelloRequest) GetChangeToArrayByAddRepeated() []string {
	if x != nil {
		return x.ChangeToArrayByAddRepeated
	}
	return nil
}

func (x *HelloRequest) GetChangeIntoArrayByReserveAndAddANewField() []string {
	if x != nil {
		return x.ChangeIntoArrayByReserveAndAddANewField
	}
	return nil
}

// The response message containing the greetings
type HelloReply struct {
	state         protoimpl.MessageState
	sizeCache     protoimpl.SizeCache
	unknownFields protoimpl.UnknownFields

	Message string `protobuf:"bytes,1,opt,name=message,proto3" json:"message,omitempty"`
}

func (x *HelloReply) Reset() {
	*x = HelloReply{}
	if protoimpl.UnsafeEnabled {
		mi := &file_v1beta1_greeter_proto_msgTypes[1]
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		ms.StoreMessageInfo(mi)
	}
}

func (x *HelloReply) String() string {
	return protoimpl.X.MessageStringOf(x)
}

func (*HelloReply) ProtoMessage() {}

func (x *HelloReply) ProtoReflect() protoreflect.Message {
	mi := &file_v1beta1_greeter_proto_msgTypes[1]
	if protoimpl.UnsafeEnabled && x != nil {
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		if ms.LoadMessageInfo() == nil {
			ms.StoreMessageInfo(mi)
		}
		return ms
	}
	return mi.MessageOf(x)
}

// Deprecated: Use HelloReply.ProtoReflect.Descriptor instead.
func (*HelloReply) Descriptor() ([]byte, []int) {
	return file_v1beta1_greeter_proto_rawDescGZIP(), []int{1}
}

func (x *HelloReply) GetMessage() string {
	if x != nil {
		return x.Message
	}
	return ""
}

var File_v1beta1_greeter_proto protoreflect.FileDescriptor

var file_v1beta1_greeter_proto_rawDesc = []byte{
	0x0a, 0x15, 0x76, 0x31, 0x62, 0x65, 0x74, 0x61, 0x31, 0x2f, 0x67, 0x72, 0x65, 0x65, 0x74, 0x65,
	0x72, 0x2e, 0x70, 0x72, 0x6f, 0x74, 0x6f, 0x12, 0x07, 0x67, 0x72, 0x65, 0x65, 0x74, 0x65, 0x72,
	0x22, 0xb9, 0x03, 0x0a, 0x0c, 0x48, 0x65, 0x6c, 0x6c, 0x6f, 0x52, 0x65, 0x71, 0x75, 0x65, 0x73,
	0x74, 0x12, 0x12, 0x0a, 0x04, 0x6e, 0x61, 0x6d, 0x65, 0x18, 0x01, 0x20, 0x01, 0x28, 0x09, 0x52,
	0x04, 0x6e, 0x61, 0x6d, 0x65, 0x12, 0x4d, 0x0a, 0x21, 0x61, 0x6e, 0x6f, 0x74, 0x68, 0x65, 0x72,
	0x5f, 0x6e, 0x65, 0x77, 0x5f, 0x66, 0x72, 0x65, 0x71, 0x75, 0x65, 0x6e, 0x74, 0x6c, 0x79, 0x5f,
	0x75, 0x73, 0x65, 0x64, 0x5f, 0x66, 0x69, 0x65, 0x6c, 0x64, 0x18, 0x02, 0x20, 0x01, 0x28, 0x09,
	0x48, 0x00, 0x52, 0x1d, 0x61, 0x6e, 0x6f, 0x74, 0x68, 0x65, 0x72, 0x4e, 0x65, 0x77, 0x46, 0x72,
	0x65, 0x71, 0x75, 0x65, 0x6e, 0x74, 0x6c, 0x79, 0x55, 0x73, 0x65, 0x64, 0x46, 0x69, 0x65, 0x6c,
	0x64, 0x88, 0x01, 0x01, 0x12, 0x2e, 0x0a, 0x11, 0x64, 0x65, 0x70, 0x72, 0x65, 0x63, 0x61, 0x74,
	0x65, 0x5f, 0x62, 0x79, 0x5f, 0x6d, 0x61, 0x72, 0x6b, 0x18, 0x06, 0x20, 0x01, 0x28, 0x09, 0x42,
	0x02, 0x18, 0x01, 0x52, 0x0f, 0x64, 0x65, 0x70, 0x72, 0x65, 0x63, 0x61, 0x74, 0x65, 0x42, 0x79,
	0x4d, 0x61, 0x72, 0x6b, 0x12, 0x2a, 0x0a, 0x11, 0x63, 0x68, 0x61, 0x6e, 0x67, 0x65, 0x5f, 0x66,
	0x69, 0x65, 0x6c, 0x64, 0x5f, 0x74, 0x79, 0x70, 0x65, 0x18, 0x08, 0x20, 0x01, 0x28, 0x03, 0x52,
	0x0f, 0x63, 0x68, 0x61, 0x6e, 0x67, 0x65, 0x46, 0x69, 0x65, 0x6c, 0x64, 0x54, 0x79, 0x70, 0x65,
	0x12, 0x43, 0x0a, 0x1f, 0x63, 0x68, 0x61, 0x6e, 0x67, 0x65, 0x5f, 0x74, 0x6f, 0x5f, 0x61, 0x72,
	0x72, 0x61, 0x79, 0x5f, 0x62, 0x79, 0x5f, 0x61, 0x64, 0x64, 0x5f, 0x72, 0x65, 0x70, 0x65, 0x61,
	0x74, 0x65, 0x64, 0x18, 0x09, 0x20, 0x03, 0x28, 0x09, 0x52, 0x1a, 0x63, 0x68, 0x61, 0x6e, 0x67,
	0x65, 0x54, 0x6f, 0x41, 0x72, 0x72, 0x61, 0x79, 0x42, 0x79, 0x41, 0x64, 0x64, 0x52, 0x65, 0x70,
	0x65, 0x61, 0x74, 0x65, 0x64, 0x12, 0x61, 0x0a, 0x30, 0x63, 0x68, 0x61, 0x6e, 0x67, 0x65, 0x5f,
	0x69, 0x6e, 0x74, 0x6f, 0x5f, 0x61, 0x72, 0x72, 0x61, 0x79, 0x5f, 0x62, 0x79, 0x5f, 0x72, 0x65,
	0x73, 0x65, 0x72, 0x76, 0x65, 0x5f, 0x61, 0x6e, 0x64, 0x5f, 0x61, 0x64, 0x64, 0x5f, 0x61, 0x5f,
	0x6e, 0x65, 0x77, 0x5f, 0x66, 0x69, 0x65, 0x6c, 0x64, 0x18, 0x0b, 0x20, 0x03, 0x28, 0x09, 0x52,
	0x27, 0x63, 0x68, 0x61, 0x6e, 0x67, 0x65, 0x49, 0x6e, 0x74, 0x6f, 0x41, 0x72, 0x72, 0x61, 0x79,
	0x42, 0x79, 0x52, 0x65, 0x73, 0x65, 0x72, 0x76, 0x65, 0x41, 0x6e, 0x64, 0x41, 0x64, 0x64, 0x41,
	0x4e, 0x65, 0x77, 0x46, 0x69, 0x65, 0x6c, 0x64, 0x42, 0x24, 0x0a, 0x22, 0x5f, 0x61, 0x6e, 0x6f,
	0x74, 0x68, 0x65, 0x72, 0x5f, 0x6e, 0x65, 0x77, 0x5f, 0x66, 0x72, 0x65, 0x71, 0x75, 0x65, 0x6e,
	0x74, 0x6c, 0x79, 0x5f, 0x75, 0x73, 0x65, 0x64, 0x5f, 0x66, 0x69, 0x65, 0x6c, 0x64, 0x4a, 0x04,
	0x08, 0x03, 0x10, 0x04, 0x4a, 0x04, 0x08, 0x04, 0x10, 0x05, 0x4a, 0x04, 0x08, 0x05, 0x10, 0x06,
	0x4a, 0x04, 0x08, 0x07, 0x10, 0x08, 0x4a, 0x04, 0x08, 0x0a, 0x10, 0x0b, 0x22, 0x26, 0x0a, 0x0a,
	0x48, 0x65, 0x6c, 0x6c, 0x6f, 0x52, 0x65, 0x70, 0x6c, 0x79, 0x12, 0x18, 0x0a, 0x07, 0x6d, 0x65,
	0x73, 0x73, 0x61, 0x67, 0x65, 0x18, 0x01, 0x20, 0x01, 0x28, 0x09, 0x52, 0x07, 0x6d, 0x65, 0x73,
	0x73, 0x61, 0x67, 0x65, 0x32, 0x43, 0x0a, 0x07, 0x47, 0x72, 0x65, 0x65, 0x74, 0x65, 0x72, 0x12,
	0x38, 0x0a, 0x08, 0x53, 0x61, 0x79, 0x48, 0x65, 0x6c, 0x6c, 0x6f, 0x12, 0x15, 0x2e, 0x67, 0x72,
	0x65, 0x65, 0x74, 0x65, 0x72, 0x2e, 0x48, 0x65, 0x6c, 0x6c, 0x6f, 0x52, 0x65, 0x71, 0x75, 0x65,
	0x73, 0x74, 0x1a, 0x13, 0x2e, 0x67, 0x72, 0x65, 0x65, 0x74, 0x65, 0x72, 0x2e, 0x48, 0x65, 0x6c,
	0x6c, 0x6f, 0x52, 0x65, 0x70, 0x6c, 0x79, 0x22, 0x00, 0x42, 0x56, 0x5a, 0x54, 0x67, 0x69, 0x74,
	0x68, 0x75, 0x62, 0x2e, 0x63, 0x6f, 0x6d, 0x2f, 0x6f, 0x66, 0x65, 0x79, 0x34, 0x30, 0x34, 0x2f,
	0x65, 0x78, 0x70, 0x65, 0x72, 0x69, 0x6d, 0x65, 0x6e, 0x74, 0x73, 0x2f, 0x63, 0x6c, 0x65, 0x61,
	0x6e, 0x63, 0x6f, 0x64, 0x65, 0x2f, 0x66, 0x6f, 0x72, 0x77, 0x61, 0x72, 0x64, 0x2d, 0x62, 0x61,
	0x63, 0x6b, 0x77, 0x61, 0x72, 0x64, 0x2d, 0x63, 0x6f, 0x6d, 0x70, 0x61, 0x74, 0x69, 0x62, 0x69,
	0x6c, 0x69, 0x74, 0x79, 0x2f, 0x67, 0x72, 0x70, 0x63, 0x2f, 0x76, 0x31, 0x62, 0x65, 0x74, 0x61,
	0x31, 0x62, 0x06, 0x70, 0x72, 0x6f, 0x74, 0x6f, 0x33,
}

var (
	file_v1beta1_greeter_proto_rawDescOnce sync.Once
	file_v1beta1_greeter_proto_rawDescData = file_v1beta1_greeter_proto_rawDesc
)

func file_v1beta1_greeter_proto_rawDescGZIP() []byte {
	file_v1beta1_greeter_proto_rawDescOnce.Do(func() {
		file_v1beta1_greeter_proto_rawDescData = protoimpl.X.CompressGZIP(file_v1beta1_greeter_proto_rawDescData)
	})
	return file_v1beta1_greeter_proto_rawDescData
}

var file_v1beta1_greeter_proto_msgTypes = make([]protoimpl.MessageInfo, 2)
var file_v1beta1_greeter_proto_goTypes = []interface{}{
	(*HelloRequest)(nil), // 0: greeter.HelloRequest
	(*HelloReply)(nil),   // 1: greeter.HelloReply
}
var file_v1beta1_greeter_proto_depIdxs = []int32{
	0, // 0: greeter.Greeter.SayHello:input_type -> greeter.HelloRequest
	1, // 1: greeter.Greeter.SayHello:output_type -> greeter.HelloReply
	1, // [1:2] is the sub-list for method output_type
	0, // [0:1] is the sub-list for method input_type
	0, // [0:0] is the sub-list for extension type_name
	0, // [0:0] is the sub-list for extension extendee
	0, // [0:0] is the sub-list for field type_name
}

func init() { file_v1beta1_greeter_proto_init() }
func file_v1beta1_greeter_proto_init() {
	if File_v1beta1_greeter_proto != nil {
		return
	}
	if !protoimpl.UnsafeEnabled {
		file_v1beta1_greeter_proto_msgTypes[0].Exporter = func(v interface{}, i int) interface{} {
			switch v := v.(*HelloRequest); i {
			case 0:
				return &v.state
			case 1:
				return &v.sizeCache
			case 2:
				return &v.unknownFields
			default:
				return nil
			}
		}
		file_v1beta1_greeter_proto_msgTypes[1].Exporter = func(v interface{}, i int) interface{} {
			switch v := v.(*HelloReply); i {
			case 0:
				return &v.state
			case 1:
				return &v.sizeCache
			case 2:
				return &v.unknownFields
			default:
				return nil
			}
		}
	}
	file_v1beta1_greeter_proto_msgTypes[0].OneofWrappers = []interface{}{}
	type x struct{}
	out := protoimpl.TypeBuilder{
		File: protoimpl.DescBuilder{
			GoPackagePath: reflect.TypeOf(x{}).PkgPath(),
			RawDescriptor: file_v1beta1_greeter_proto_rawDesc,
			NumEnums:      0,
			NumMessages:   2,
			NumExtensions: 0,
			NumServices:   1,
		},
		GoTypes:           file_v1beta1_greeter_proto_goTypes,
		DependencyIndexes: file_v1beta1_greeter_proto_depIdxs,
		MessageInfos:      file_v1beta1_greeter_proto_msgTypes,
	}.Build()
	File_v1beta1_greeter_proto = out.File
	file_v1beta1_greeter_proto_rawDesc = nil
	file_v1beta1_greeter_proto_goTypes = nil
	file_v1beta1_greeter_proto_depIdxs = nil
}