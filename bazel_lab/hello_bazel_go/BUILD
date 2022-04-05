load("@io_bazel_rules_go//go:def.bzl", "go_binary", "go_library")
load("//:gen_mock.bzl", "gen_mock")

go_binary(
    name = "hello",
    srcs = [
        "hello.go",
    ],
)

gen_mock(name = "mock1", out = "gen_env.txt")
