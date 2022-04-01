load("@io_bazel_rules_go//go:def.bzl", "go_binary", "go_library")
load("@bazel_gazelle//:def.bzl", "gazelle")

# gazelle:prefix github.com/guzhenyu/2022bytedance/kitex_examples/hello
gazelle(name = "gazelle")

go_binary(
    name = "hello_server",
    srcs = [
        "handler.go",
        "hello_server.go",
    ],
    deps = [
        "//calc:calc_lib",
        "@com_github_guzhenyu_2022bytedance//kitex_overpass/hello/kitex_gen/api",
        "@com_github_guzhenyu_2022bytedance//kitex_overpass/hello/kitex_gen/api/hello",
    ],
    importpath = "github.com/guzhenyu/2022bytedance/kitex_examples/hello",
    visibility = ["//visibility:private"],
)

go_binary(
    name = "hello_client",
    srcs = ["hello_client.go"],
    importpath = "github.com/guzhenyu/2022bytedance/kitex_examples/hello",
    visibility = ["//visibility:public"],
    deps = [
        "@com_github_cloudwego_kitex//client:go_default_library",
        "@com_github_cloudwego_kitex//client/callopt:go_default_library",
        "@com_github_guzhenyu_2022bytedance//kitex_overpass/hello/kitex_gen/api:go_default_library",
        "@com_github_guzhenyu_2022bytedance//kitex_overpass/hello/kitex_gen/api/hello:go_default_library",
    ],
)
