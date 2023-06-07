package main

//import (
//	"testing"
//
//	"github.com/aws/aws-cdk-go/awscdk/v2"
//	"github.com/aws/aws-cdk-go/awscdk/v2/assertions"
//	"github.com/aws/jsii-runtime-go"
//)

// example tests. To run these tests, uncomment this file along with the
// example resource in hello-cdk_test.go
//func TestHelloCdkStack(t *testing.T) {
//	// GIVEN
//	app := awscdk.NewApp(nil)
//
//	// WHEN
//	stack := NewHelloCdkStack(app, "MyStack", nil)
//
//	// THEN
//	template := assertions.Template_FromStack(stack, &assertions.TemplateParsingOptions{})
//
//	template.HasResourceProperties(jsii.String("AWS::SQS::Queue"), map[string]interface{}{
//		"VisibilityTimeout": 300,
//	})
//}
