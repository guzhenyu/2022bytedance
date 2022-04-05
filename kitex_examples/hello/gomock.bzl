# Copied from https://github.com/jmhodges/bazel_gomock/blob/master/gomock.bzl

load("@io_bazel_rules_go//go:def.bzl", "go_binary")
load("@io_bazel_rules_go//go/private:providers.bzl", "GoLibrary")

_MOCKGEN_TOOL = "@com_github_golang_mock//mockgen"
_MOCKGEN_MODEL_LIB = "@com_github_golang_mock//mockgen/model:go_default_library"

def gomock(name, library, out, **kwargs):
    mockgen_tool = _MOCKGEN_TOOL
    interfaces = kwargs.pop("interfaces", None)

    prog_src = name + "_gomock_prog"
    prog_src_out = prog_src + ".go"
    _gomock_prog_gen(
        name = prog_src,
        interfaces = interfaces,
        library = library,
        out = prog_src_out,
        mockgen_tool = mockgen_tool,
    )

    prog_bin = name + "_gomock_prog_bin"
    mockgen_model_lib = _MOCKGEN_MODEL_LIB
    go_binary(
        name = prog_bin,
        srcs = [prog_src_out],
        deps = [library, mockgen_model_lib],
    )

    _gomock_prog_exec(
        name = name,
        interfaces = interfaces,
        library = library,
        out = out,
        prog_bin = prog_bin,
        mockgen_tool = mockgen_tool,
        **kwargs)

def _gomock_prog_gen_impl(ctx):
    args = ["-prog_only"]
    args += [ctx.attr.library[GoLibrary].importpath]
    args += [",".join(ctx.attr.interfaces)]

    cmd = ctx.file.mockgen_tool
    out = ctx.outputs.out
    ctx.actions.run_shell(
        outputs = [out],
        tools = [cmd],
        command = "{cmd} {args} > {out}".format(
            cmd = "$(pwd)/" + cmd.path,
            args = " ".join(args),
            out = out.path,
        ),
    )

_gomock_prog_gen = rule(
    _gomock_prog_gen_impl,
    attrs = {
        "library": attr.label(
            doc = "The target the Go library is at to look for the interfaces in. When this is set and source is not set, mockgen will use its reflect code to generate the mocks. If source is set, its dependencies will be included in the GOPATH that mockgen will be run in.",
            providers = [GoLibrary],
            mandatory = True,
        ),
        "out": attr.output(
            doc = "The new Go source file put the mock generator code",
            mandatory = True,
        ),
        "interfaces": attr.string_list(
            allow_empty = False,
            doc = "The names of the Go interfaces to generate mocks for. If not set, all of the interfaces in the library or source file will have mocks generated for them.",
            mandatory = True,
        ),
        "mockgen_tool": attr.label(
            doc = "The mockgen tool to run",
            default = Label(_MOCKGEN_TOOL),
            allow_single_file = True,
            executable = True,
            cfg = "exec",
            mandatory = False,
        ),
    },
)

def _gomock_prog_exec_impl(ctx):
    args = ["-exec_only", ctx.file.prog_bin.path]
    if ctx.attr.package != "":
        args += ["-package", ctx.attr.package]
    if len(ctx.attr.imports) > 0:
        imports = ",".join(["{0}={1}".format(name, pkg) for name, pkg in ctx.attr.imports.items()])
        args += ["-imports", imports]


    # annoyingly, the interfaces join has to go after the importpath so we can't
    # share those.
    args += [ctx.attr.library[GoLibrary].importpath]
    args += [",".join(ctx.attr.interfaces)]

    ctx.actions.run_shell(
        outputs = [ctx.outputs.out],
        inputs = [ctx.file.prog_bin],
        tools = [ctx.file.mockgen_tool],
        command = """{cmd} {args} > {out}""".format(
            cmd = "$(pwd)/" + ctx.file.mockgen_tool.path,
            args = " ".join(args),
            out = ctx.outputs.out.path,
        ),
        env = {
            # GOCACHE is required starting in Go 1.12
            "GOCACHE": "./.gocache",
        },
        mnemonic = "GoMockReflectExecOnlyGen",
    )

_gomock_prog_exec = rule(
    _gomock_prog_exec_impl,
    attrs = {
        "library": attr.label(
            doc = "The target the Go library is at to look for the interfaces in. When this is set and source is not set, mockgen will use its reflect code to generate the mocks. If source is set, its dependencies will be included in the GOPATH that mockgen will be run in.",
            providers = [GoLibrary],
            mandatory = True,
        ),
        "out": attr.output(
            doc = "The new Go source file to put the generated mock code",
            mandatory = True,
        ),
        "interfaces": attr.string_list(
            allow_empty = False,
            doc = "The names of the Go interfaces to generate mocks for. If not set, all of the interfaces in the library or source file will have mocks generated for them.",
            mandatory = True,
        ),
        "package": attr.string(
            doc = "The name of the package the generated mocks should be in. If not specified, uses mockgen's default.",
        ),
        "imports": attr.string_dict(
            doc = "Dictionary of name-path pairs of explicit imports to use.",
        ),
        "prog_bin": attr.label(
            doc = "The program binary generated by mockgen's -prog_only and compiled by bazel.",
            allow_single_file = True,
            executable = True,
            cfg = "exec",
            mandatory = True,
        ),
        "mockgen_tool": attr.label(
            doc = "The mockgen tool to run",
            default = Label(_MOCKGEN_TOOL),
            allow_single_file = True,
            executable = True,
            cfg = "exec",
            mandatory = False,
	),
    },
)
