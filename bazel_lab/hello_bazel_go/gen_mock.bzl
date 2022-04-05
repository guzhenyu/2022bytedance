def _gen_mock_impl(ctx):
    sdk = ctx.toolchains["@io_bazel_rules_go//go:toolchain"].sdk.go
    print(dir(sdk))
    print(sdk.basename)
    print(sdk.path)
    print(sdk.short_path)
    print(sdk.root.path)
    print(sdk.extension)

    ctx.actions.run(
        outputs = [ctx.outputs.out],
        executable = sdk.go,
        arguments = ["env"],
    )

gen_mock = rule(
    implementation = _gen_mock_impl,
    attrs = {
        "out": attr.output(mandatory = False),
    },
    toolchains = ["@io_bazel_rules_go//go:toolchain"],
)
