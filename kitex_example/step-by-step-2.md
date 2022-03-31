# Kitex - Quick Start

https://www.cloudwego.io/docs/kitex/getting-started/

## Environment checking

> $ go env GOPATH  
> /Users/guzhenyu/go
> $ mkdir /Users/guzhenyu/go/bin

## Install Compiler

> $ go install github.com/cloudwego/kitex/tool/cmd/kitex@latest
>
> // Thriftgo is an implementation of thrift compiler in go language by TT.
> // It has a command line interface similar to the apache/thrift compiler
> // and is enhanced with a plugin mechanism which makes it more powerful.
> // https://github.com/cloudwego/thriftgo
> $ go install github.com/cloudwego/thriftgo@latest

## Define the idl

> $ mkdir hello2
> $ cd hello2
> $ go mod init github.com/guzhenyu/2022bytedance/kitex_example/hello2
> $ kitex -module github.com/guzhenyu/2022bytedance/kitex_example/hello2 -service a.b.c hello.thrift
> $ go mod tidy

## Make the example work
> // Do not forget to setup the thrift version
> $ pwd
> .../hello2
> $ go mod edit -droprequire=github.com/apache/thrift/lib/go/thrift
> $ go mod edit -replace=github.com/apache/thrift=github.com/apache/thrift@v0.13.0
>
> 
> 
>
> ////// In handler.go, there is a line as "import example/kitex_gen/api"
> // Init the kitex_gen module
> $ cd kitex_gen/api
> $ pwd
> .../hello/kitex_gen/api
> $ go mod init example/kitex_gen/api
> $ go mod tidy
> $ go mod edit -droprequire=github.com/apache/thrift/lib/go/thrift
> $ go mod edit -replace=github.com/apache/thrift=github.com/apache/thrift@v0.13.0
>
> ////// Use example/kite_gen/api locally.
> $ cd ../../
> $ pwd
> .../hello
> $ go mod edit -replace example/kitex_gen/api=./kitex_gen/api
> $ go get example/kitex_gen/api
> go: added example/kitex_gen/api v0.0.0-00010101000000-000000000000
> $ sh build.sh
