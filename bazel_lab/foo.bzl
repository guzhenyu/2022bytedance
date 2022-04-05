# ctx.label: the target being analyzed, e.g., //:bin
# ctx.build_file_path: path relative to the source root, e.g., dir_a/BUILD
# ctx.genfiles_dir.path: genfiles directory, e.g.,  bazel-out/darwin-fastbuild/bin

def _foo_binary_impl(ctx):
    # print("analyzing1", dir(ctx))
    print("ctx.os.name = ", ctx.os.name)
    print("analyzing1", ctx.label)

foo_binary = rule(
  implementation = _foo_binary_impl,
)

# If multiple BUILD files are loading foo.bzl, you would see
# only one occurrence of "bzl file evaluation" because
# Bazel caches the result of the evaluation
print("bzl file evaluation")


#     $ bazel query :all
#     The callback function _foo_binary_impl is not called.
#     Bazel query loads BUILD files, but doesn't analyze targets.
