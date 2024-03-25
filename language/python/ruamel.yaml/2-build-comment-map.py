import sys
import ruamel.yaml
from ruamel.yaml.comments import CommentedMap

data = CommentedMap({
    "entry": "foo",
    "dict": {
        "foo": "bar",
        "bar": "baz"
    },
    "list": [
        "foo",
        "bar",
        "baz"
    ],
    "nested": {
        "entry": "foo",
        "dict": {
            "foo": "bar",
        },
    }
})

data.yaml_set_start_comment("This is a comment for the whole data structure")

# "after" doesn't work for the key which has a single value.
data.yaml_set_comment_before_after_key("entry", before="Before the 'entry' key")
data.yaml_add_eol_comment("This is an EOL comment", "entry")

data.yaml_set_comment_before_after_key("dict", before="Before the 'dict' key", after="After the 'dict' key")

data.yaml_set_comment_before_after_key(
    "list",
    before="""This is a multi-line comment,
before the 'list' key.""",
    after="""This is a multi-line comment,
after the 'list' key.""",
)

# nested
data["nested"] = CommentedMap(data["nested"])
nested = data["nested"]
nested.yaml_add_eol_comment("CommentedMap could be nested", "entry")
nested.yaml_set_comment_before_after_key("dict", before="Before dict", after="After dict")

yaml = ruamel.yaml.YAML()
yaml.dump(data, sys.stdout)
