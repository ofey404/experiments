import sys
import ruamel.yaml

# ofey404: Comment after key-value pair is sticked to it

yaml_str = """\
# Our app configuration

foo: bar
# foo is our main variable

foz: quz
# foz is also important

opt1: foqz
# And finally we have our optional configs.
# These are not really mandatory, they can be
# considere as "would be nice".
"""

undefined = object()
    
yaml = ruamel.yaml.YAML()
data = yaml.load(yaml_str)

data.pop('foz', None)

print(f"Type of data = {type(data)}")
print("\n")
print("Content after removing 'foz' key:")
yaml.dump(data, sys.stdout)
