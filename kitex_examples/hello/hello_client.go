package main

import (
  "context"
  "fmt"
  "time"
  "github.com/cloudwego/kitex/client"
  "github.com/cloudwego/kitex/client/callopt"
  "github.com/guzhenyu/2022bytedance/kitex_overpass/hello/kitex_gen/api"
  "github.com/guzhenyu/2022bytedance/kitex_overpass/hello/kitex_gen/api/hello"
)

func main() {
  c, err := hello.NewClient("hello_123", client.WithHostPorts("0.0.0.0:8888"))
  if err != nil {
    panic(err)
  }

  req := &api.Request{Message: "my request"}
  resp, err2 := c.Echo(
      context.Background(), req, callopt.WithRPCTimeout(3*time.Second))
  if err2 != nil {
      panic(err2)
  }
  fmt.Println(resp)
}
