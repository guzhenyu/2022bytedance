package main

import (
	"context"
	"github.com/guzhenyu/2022bytedance/kitex_overpass/hello/kitex_gen/api"
)

// HelloImpl implements the last service interface defined in the IDL.
type HelloImpl struct{}

// Echo implements the HelloImpl interface.
func (s *HelloImpl) Echo(ctx context.Context, req *api.Request) (resp *api.Response, err error) {
	return &api.Response{Message: "[resp]" + req.Message}, nil
}
