load("@io_bazel_rules_go//go:def.bzl", "go_library", "go_test")

go_library(
    name = "calc_lib",
    srcs = ["calc.go"],
    importpath = "github.com/guzhenyu/2022bytedance/kitex_examples/hello/calc",
    visibility = ["//visibility:public"],
)

go_test(
    name = "calc_test",
    srcs = ["calc_test.go"],
    embed = [":calc_lib"],
)

# genrule(
#     name = "gen_mock_calc",
#     srcs = ["calc.go"],
#     outs = ["mock_calc.go"],
#     cmd = "mockgen -source=calc.go -destination=mock_calc.go",
# )
