# Kitex - Quick Start

https://www.cloudwego.io/docs/kitex/getting-started/

## 1. Environment checking
> $ go env GOPATH
> /Users/guzhenyu/go
> $ mkdir /Users/guzhenyu/go/bin

## 2. 在golang中使用github.com的私有库
2.1 在.gitconfig中声明将https转换成ssh, 在global级别的.gitconfig后面添加
> [url "ssh://git@github.com/"]
>         insteadOf = https://github.com/

2.2 避免GOPROXY="https://goproxy.cn"的影响，运行:
> $ go env -w GOPRIVATE=github.com/guzhenyu/*


## 3. 安装kitex自动生成套装

> $ go install github.com/cloudwego/kitex/tool/cmd/kitex@latest
>
> // Thriftgo is an implementation of thrift compiler in go language by TT.
> // It has a command line interface similar to the apache/thrift compiler
> // and is enhanced with a plugin mechanism which makes it more powerful.
> // https://github.com/cloudwego/thriftgo
> $ go install github.com/cloudwego/thriftgo@latest

## 4. 定义IDL，生成kitex框架

IDL
> $ pwd
> /Users/guzhenyu/github
> $ git clone git@github.com:guzhenyu/2022bytedance.git
> $ mkdir -p 2022bytedance/kitex_overpass/hello;cd 2022bytedance/kitex_overpass/hello
> $ vi hello.thrift
> namespace go api
> struct Request {
>         1: string message
> }
>
> struct Response {
>         1: string message
> }
>
> service Hello {
>     Response echo(1: Request req)
> }

kitex框架
> $ kitex -module github.com/guzhenyu/2022bytedance/kitex_overpass/hello -service hello_server hello.thrift
> $ rm -rf build.sh go.mod handler.go main.go script
> $ ls
> hello.thrift  kitex_gen
> $ cd ../..; git add kitex_overpass; git commit -m "添加一个kitex服务 - hello"; git push origin master
