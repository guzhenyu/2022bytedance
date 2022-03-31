load("@io_bazel_rules_go//go:def.bzl", "go_binary", "go_library")
load("@bazel_gazelle//:def.bzl", "gazelle")

# gazelle:prefix github.com/guzhenyu/2022bytedance/kitex_examples/hello
gazelle(name = "gazelle")

go_library(
    name = "hello_lib",
    srcs = [
        "handler.go",
        "hello_server.go",
    ],
    importpath = "github.com/guzhenyu/2022bytedance/kitex_examples/hello",
    visibility = ["//visibility:private"],
    deps = [
        "@com_github_guzhenyu_2022bytedance//kitex_overpass/hello/kitex_gen/api:go_default_library",
        "@com_github_guzhenyu_2022bytedance//kitex_overpass/hello/kitex_gen/api/hello:go_default_library",
    ],
)

go_binary(
    name = "hello_server",
    embed = [":hello_lib"],
    visibility = ["//visibility:public"],
)

go_binary(
    name = "hello_client",
    srcs = [
        "hello_client.go",
    ],
    importpath = "github.com/guzhenyu/2022bytedance/kitex_examples/hello",
    visibility = ["//visibility:public"],
    deps = [
        "@com_github_cloudwego_kitex//client:go_default_library",
        "@com_github_cloudwego_kitex//client/callopt:go_default_library",
        "@com_github_guzhenyu_2022bytedance//kitex_overpass/hello/kitex_gen/api:go_default_library",
        "@com_github_guzhenyu_2022bytedance//kitex_overpass/hello/kitex_gen/api/hello:go_default_library",
    ],
)
