package main

import (
	"fmt"
	"time"

	"github.com/aws/aws-sdk-go/aws"
	"github.com/aws/aws-sdk-go/aws/session"
	"github.com/aws/aws-sdk-go/service/costexplorer"
)

func main() {
	sess := session.Must(session.NewSession())

	svc := costexplorer.New(sess)

	var (
		now       = time.Now()
		endTime   = now.Format("2006-01-02")
		startTime = now.AddDate(0, 0, -10).Format("2006-01-02")
	)

	input := &costexplorer.GetCostAndUsageInput{
		Granularity: aws.String(costexplorer.GranularityDaily),
		GroupBy:     []*costexplorer.GroupDefinition{},
		Metrics: []*string{
			aws.String(costexplorer.MetricUnblendedCost),
		},
		TimePeriod: &costexplorer.DateInterval{
			Start: &startTime,
			End:   &endTime,
		},
	}
	output, err := svc.GetCostAndUsage(input)
	if err != nil {
		panic(err)
	}
	fmt.Printf("output: %+v\n", output)
}
