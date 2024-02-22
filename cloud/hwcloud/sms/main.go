package main

import (
	"bytes"
	"crypto/tls"
	"fmt"
	"io/ioutil"
	"net/http"
	"net/url"
	"os"

	"github.com/ofey404/experiments/cloud/hwcloud/sms/core"
)

func init() {
	// check environment variables
	envs := []string{
		"APP_KEY",
		"APP_SECRET",
		"APP_ADDRESS",
		"SENDER",
		"RECEIVER",
		"TEMPLATE_ID",
	}
	notSet := false
	for _, env := range envs {
		fmt.Printf("%s = %s\n", env, os.Getenv(env))
		if os.Getenv(env) == "" {
			fmt.Printf("environment variable %s is not set\n", env)
			notSet = true
		}
	}

	if notSet {
		os.Exit(1)
	}
}

func main() {
	//必填,请参考"开发准备"获取如下数据,替换为实际值
	appInfo := core.Signer{
		// 认证用的appKey和appSecret硬编码到代码中或者明文存储都有很大的安全风险，建议在配置文件或者环境变量中密文存放，使用时解密，确保安全；
		Key:    os.Getenv("APP_KEY"),    //App Key
		Secret: os.Getenv("APP_SECRET"), //App Secret
	}
	apiAddress := os.Getenv("APP_ADDRESS") //APP接入地址(在控制台"应用管理"页面获取)+接口访问URI
	sender := os.Getenv("SENDER")          //国内短信签名通道号
	templateId := os.Getenv("TEMPLATE_ID") //模板ID

	//条件必填,国内短信关注,当templateId指定的模板类型为通用模板时生效且必填,必须是已审核通过的,与模板类型一致的签名名称

	signature := "华为云短信测试" //签名名称

	//必填,全局号码格式(包含国家码),示例:+86151****6789,多个号码之间用英文逗号分隔
	receiver := os.Getenv("RECEIVER") //短信接收人号码

	//选填,短信状态报告接收地址,推荐使用域名,为空或者不填表示不接收状态报告
	statusCallBack := ""

	/*
	 * 选填,使用无变量模板时请赋空值 string templateParas = "";
	 * 单变量模板示例:模板内容为"您的验证码是${1}"时,templateParas可填写为"[\"369751\"]"
	 * 双变量模板示例:模板内容为"您有${1}件快递请到${2}领取"时,templateParas可填写为"[\"3\",\"人民公园正门\"]"
	 * 模板中的每个变量都必须赋值，且取值不能为空
	 * 查看更多模板规范和变量规范:产品介绍>短信模板须知和短信变量须知
	 */
	templateParas := "[\"369751\"]" //模板变量，此处以单变量验证码短信为例，请客户自行生成6位验证码，并定义为字符串类型，以杜绝首位0丢失的问题（例如：002569变成了2569）。

	body := buildRequestBody(sender, receiver, templateId, templateParas, statusCallBack, signature)
	resp, err := post(apiAddress, []byte(body), appInfo)

	if err != nil {
		return
	}
	fmt.Println("## response")
	fmt.Println(resp)
}

/**
 * sender,receiver,templateId不能为空
 */
func buildRequestBody(sender, receiver, templateId, templateParas, statusCallBack, signature string) string {
	param := "from=" + url.QueryEscape(sender) + "&to=" + url.QueryEscape(receiver) + "&templateId=" + url.QueryEscape(templateId)
	if templateParas != "" {
		param += "&templateParas=" + url.QueryEscape(templateParas)
	}
	if statusCallBack != "" {
		param += "&statusCallback=" + url.QueryEscape(statusCallBack)
	}
	if signature != "" {
		param += "&signature=" + url.QueryEscape(signature)
	}
	return param
}

func post(url string, param []byte, appInfo core.Signer) (string, error) {
	if param == nil || appInfo == (core.Signer{}) {
		return "", nil
	}

	// 代码样例为了简便，设置了不进行证书校验，请在商用环境自行开启证书校验。
	tr := &http.Transport{
		TLSClientConfig: &tls.Config{InsecureSkipVerify: true},
	}
	client := &http.Client{Transport: tr}

	req, err := http.NewRequest("POST", url, bytes.NewBuffer(param))
	if err != nil {
		return "", err
	}

	// 对请求增加内容格式，固定头域
	req.Header.Add("Content-Type", "application/x-www-form-urlencoded")
	// 对请求进行HMAC算法签名，并将签名结果设置到Authorization头域。
	appInfo.Sign(req)

	fmt.Println("## request header JSON")
	for key, values := range req.Header {
		for _, value := range values {
			fmt.Printf("%s: %s\n", key, value)
		}
	}
	// 发送短信请求
	resp, err := client.Do(req)
	if err != nil {
		fmt.Println(err)
	}

	// 获取短信响应
	defer resp.Body.Close()
	body, err := ioutil.ReadAll(resp.Body)
	if err != nil {
		return "", err
	}
	return string(body), nil
}
