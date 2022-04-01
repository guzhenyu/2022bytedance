package main

import (
	"github.com/guzhenyu/2022bytedance/kitex_examples/hello/calc"
	api "github.com/guzhenyu/2022bytedance/kitex_overpass/hello/kitex_gen/api/hello"
	"log"
)

func main() {
	helloImpl := HelloImpl{}
        helloImpl.calculator = calc.MagicCalc{}

	svr := api.NewServer(&helloImpl)

	err := svr.Run()

	if err != nil {
		log.Println(err.Error())
	}
}
