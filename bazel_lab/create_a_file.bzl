# ctx.actions.declare_file(...)
#            .run(...)
#            .write(...)
#            .expand_template(...)
#    .declare_file
# DefaultInfo
# attr

def _foo_binary_impl(ctx):
    out = ctx.actions.declare_file(ctx.label.name)
    # ctx.actions.write(
    #     output = out,
    #     content = "Hello {}!\n".format(ctx.attr.username),
    # )
    ctx.actions.expand_template(
        output = out,
        template = ctx.file.template,
        substitutions = {"{NAME}": ctx.attr.username},
    )
    return [DefaultInfo(files = depset([out]))]

foo_binary = rule(
  implementation = _foo_binary_impl,
  attrs = {
      "username": attr.string(),
      "template": attr.label(
          allow_single_file = [".cc.tpl"],
          mandatory = True,
      ),
  },
)
