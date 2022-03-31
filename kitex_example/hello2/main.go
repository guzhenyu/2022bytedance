package main

import (
	api "github.com/guzhenyu/2022bytedance/kitex_example/hello2/kitex_gen/api/hello"
	"log"
)

func main() {
	svr := api.NewServer(new(HelloImpl))

	err := svr.Run()

	if err != nil {
		log.Println(err.Error())
	}
}