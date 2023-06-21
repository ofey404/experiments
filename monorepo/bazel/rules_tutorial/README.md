# bazel rules tutorial

I follow a official tutorial in this directory:
[Rules tutorial | Bazel](https://bazel.build/rules/rules-tutorial)

It's on the extending part of bazel's documentation.
[Rules | Bazel](https://bazel.build/extending/rules)

## Examples

A good example repo, teaching how to create rules:
[bazelbuild/examples](https://github.com/bazelbuild/examples/tree/main/rules)

## Phases

https://bazel.build/extending/concepts

```
┌────────────────┐
│ Loading Phase  │   extension & BUILD.bazel
└───────┬────────┘
        │
        │ macro() -> rules(): Build a rule graph
        │
┌───────▼────────┐
│ Analysis Phase │   _rule_impl()
└───────┬────────┘
        │
        │ rules() -> action(): Build an action graph
        │
┌───────▼─────────┐
│ Execution Phase │  action() -> output
└─────────────────┘
```
