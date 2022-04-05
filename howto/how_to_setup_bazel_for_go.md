以github.com/guzhenyu/2022bytedance/kitex_examples/hello 为例

### 安装bazel
1. 访问https://github.com/bazelbuild/bazel/releases  
   1.1 找到一个版本  
   1.2 找到版本中的Assets  
   1.3 下载 bazel-6.0.0-pre.20220324.1-installer-darwin-x86_64.sh  
  
2. 本地设置
   2.1 在"系统便好设置" => "安全性与隐私" => "允许从以下位置下载的APP"  
       中看到"任何来源"  
       2.1.1 $ sudo spctl --master-disable  
   2.2 安装bazel  
       $ chmod 750 bazel-6.0.0-pre.20220324.1-installer-darwin-x86_64.sh  
       $ ./bazel-6.0.0-pre.20220324.1-installer-darwin-x86_64.sh  
   2.3 设置工作目录，运行bazel 
       $ cd /Users/guzhenyu/github/2022bytedance/kitex_examples/hello  
       $ touch >WORKSPACE  
       $ bazel --version  
       bazel 6.0.0-pre.20220324.1  

### 安装rules_go
1. https://github.com/bazelbuild/rules_go

2. 设置bazel project
> $ vi ./2022bytedance/kitex_examples/hello/WORKSPACE  
> load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")  
>   
> http_archive(  
>     name = "io_bazel_rules_go",  
>     sha256 = "f2dcd210c7095febe54b804bb1cd3a58fe8435a909db2ec04e31542631cf715c",  
>     urls = [  
>         "https://mirror.bazel.build/github.com/bazelbuild/rules_go/releases/download/v0.31.0/rules_go-v0.31.0.zip",  
>         "https://github.com/bazelbuild/rules_go/releases/download/v0.31.0/rules_go-v0.31.0.zip",  
>     ],  
> )  
>   
> http_archive(  
>     name = "bazel_gazelle",  
>     sha256 = "de69a09dc70417580aabf20a28619bb3ef60d038470c7cf8442fafcf627c21cb",  
>     urls = [  
>         "https://mirror.bazel.build/github.com/bazelbuild/bazel-gazelle/releases/download/v0.24.0/bazel-gazelle-v0.24.0.tar.gz",  
>         "https://github.com/bazelbuild/bazel-gazelle/releases/download/v0.24.0/bazel-gazelle-v0.24.0.tar.gz",  
>     ],  
> )  
>   
> load("@io_bazel_rules_go//go:deps.bzl", "go_register_toolchains", "go_rules_dependencies")  
> load("@bazel_gazelle//:deps.bzl", "gazelle_dependencies", "go_repository")  
>   
> \# 缺BUILD，所以才用http_archieve，在com_google_protobuf中用到  
> \# go_repository(  
> \#     name = "zlib",  
> \#     importpath = "github.com/madler/zlib",  
> \#     sum = "h1:qdF6e/ssLdVcpRLzhOxQ+bMvkbFbU4eiZjNj1MkJiXI=",  
> \#     version = "v1.2.12",  
> \# )  
>   
> http_archive(  
>     name = "zlib",  
>     build_file = "@com_google_protobuf//:third_party/zlib.BUILD",  
>     sha256 = "c3e5e9fdd5004dcb542feda5ee4f0ff0744628baf8ed2dd5d66f8ca1197cb1a1",  
>     strip_prefix = "zlib-1.2.11",  
>     urls = [  
>         "https://mirror.bazel.build/zlib.net/zlib-1.2.11.tar.gz",  
>         "https://zlib.net/zlib-1.2.11.tar.gz",  
>     ],  
> )  
>  
> go_rules_dependencies()  
>   
> go_register_toolchains(version = "1.18")  
>   
> gazelle_dependencies()  

3. 设置BUILD文件  

3.1 新项目
> 在BUILD文件首行添加  
> load("@io_bazel_rules_go//go:def.bzl", "go_binary", "go_library", "go_test")  

3.2 已有go.mod 的project，在WORKSPACE对应的目录下设置正确的BUILD文件，"\# gazelle:prefix github.com/example/project" 不是注释!!! 是gazelle的输入!!!  
> $ vi BUILD  
> load("@bazel_gazelle//:def.bzl", "gazelle")    
> \# gazelle:prefix github.com/guzhenyu/2022bytedance/kitex_examples/hello    
> gazelle(name = "gazelle")    
>  
> $ bazel run :gazelle  
  
3.3 根据提示补齐go_repository  
> $ bazel run :gazelle update-repos github.com/guzhenyu/2022bytedance  
> $ bazel run :gazelle update-repos github.com/cloudwego/kitex  
> $ bazel run :gazelle update-repos github.com/apache/thrift@0.13.0  
> $ bazel run :gazelle update-repos github.com/bytedance/gopkg  
> $ bazel run :gazelle update-repos gopkg.in/yaml.v3  
> $ bazel run :gazelle update-repos github.com/cloudwego/thriftgo  
> $ bazel run :gazelle update-repos github.com/cloudwego/netpoll-http2  
> $ bazel run :gazelle update-repos github.com/cloudwego/netpoll  
> $ bazel run :gazelle update-repos github.com/json-iterator/go  
> $ bazel run :gazelle update-repos github.com/modern-go/reflect2  
> $ bazel run :gazelle update-repos github.com/modern-go/concurrent  
> $ bazel run :gazelle update-repos github.com/tidwall/match  
> $ bazel run :gazelle update-repos github.com/tidwall/gjson  
> $ bazel run :gazelle update-repos github.com/tidwall/pretty  
> $ bazel run :gazelle update-repos github.com/choleraehyq/pid  
> $ bazel run :gazelle update-repos github.com/cespare/xxhash  
>  
> $ bazel run :gazelle update-repos github.com/protocolbuffers/protobuf  
> $ bazel run :gazelle update-repos github.com/bazelbuild/rules_pkg  
> $ bazel run :gazelle update-repos github.com/bazelbuild/rules_python  
>  
> $ vi WORKSPACE  
> \# 将com_github_protocolbuffers_protobuf改名为com_google_protobuf  
> \# 将com_github_bazelbuild_rules_pkg改名为rules_pkg  
> \# 将com_github_bazelbuild_rules_pkg改名为rules_python  
>
> // 测试包  
> $ bazel run :gazelle update-repos github.com/stretchr/testify

4. 编译  
> $ cd /Users/guzhenyu/github/2022bytedance/kitex_examples/hello
> $ bazel build :hello_server
> $ bazel build :hello_client

5. mockgen  
命令行模式下生成mock的方式  
https://github.com/golang/mock  
> $ go install github.com/golang/mock/mockgen@v1.6.0  
> $ mockgen 

但是在Bazel的执行阶段, 除了要准备被mock的文件，mockgen工具也需要被准备好呀  

5.1 在bazel中配置mockgen  
5.1.1 获取mockgen的sum  
> $ go mod download -json github.com/golang/mock@v1.6.0  
> {  
> 	"Path": "github.com/golang/mock",  
> 	"Version": "v1.6.0",  
> 	"Info": "/Users/guzhenyu/go/pkg/mod/cache/download/github.com/golang/mock/@v/v1.6.0.info",  
> 	"GoMod": "/Users/guzhenyu/go/pkg/mod/cache/download/github.com/golang/mock/@v/v1.6.0.mod",  
> 	"Zip": "/Users/guzhenyu/go/pkg/mod/cache/download/github.com/golang/mock/@v/v1.6.0.zip",  
> 	"Dir": "/Users/guzhenyu/go/pkg/mod/github.com/golang/mock@v1.6.0",  
> 	"Sum": "h1:ErTB+efbowRARo13NNdxyJji2egdxLGQhRaY+DUumQc=",  
> 	"GoModSum": "h1:p6yTPP+5HYm5mzsMV8JkE6ZKdX+/wYM6Hr+LicevLPs="  
> }  
5.1.2 在WORKSPACE中配置go_repository  
> go_repository(  
>     name = "com_github_golang_mock",  
>     importpath = "github.com/golang/mock",  
>     sum = "h1:ErTB+efbowRARo13NNdxyJji2egdxLGQhRaY+DUumQc="  
>     version = "v1.6.0"  
> )  
  
5.1.2 配置bazel macro, 用于生成gomock  
参考https://github.com/jmhodges/bazel_gomock, 新建kitex_examples/hello/gomock.bzl  
> $ bazel build calc:mock_calc
