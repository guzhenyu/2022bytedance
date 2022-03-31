# 2022bytedance

## douplus

weeklyreport/genscripts.go
> 使用了 "flag" "fmt" "strconv" "strings" "time" 等built-in库函数

## 其他

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
   3.3 设置工作目录，运行bazel
       $ cd github/2022bytedance
       $ touch >WORKSPACE
       $ bazel --version
       bazel 6.0.0-pre.20220324.1
