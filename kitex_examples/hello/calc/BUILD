load("@io_bazel_rules_go//go:def.bzl", "go_library", "go_test")
load("//:gomock.bzl", "gomock")

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

gomock(
    name = "mock_calc",
    out = "mock_calc.go",
    library = ":calc_lib",
    interfaces = ["Calc"],
    # package = "CalcX",
)

# load("//:gen_mock.bzl", "gen_mock2")
# gen_mock2(
#     name = "abc",
#     out = "go_env.txt",
# )
# genrule(
#     name = "gen_mock_calc",
#     srcs = ["calc.go"],
#     outs = ["mock_calc.go"],
#     cmd = "mockgen -source=calc.go -destination=mock_calc.go",
# )
