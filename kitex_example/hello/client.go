package main

import (
  "context"
  "fmt"
  "time"
  "example/kitex_gen/api"
  "example/kitex_gen/api/echo"
  "github.com/cloudwego/kitex/client"
  "github.com/cloudwego/kitex/client/callopt"
)

func main() {
  c, err := echo.NewClient("example", client.WithHostPorts("0.0.0.0:8888"))
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
