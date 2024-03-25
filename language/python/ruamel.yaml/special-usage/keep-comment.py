import sys
import ruamel.yaml

# https://stackoverflow.com/questions/72732098/keeping-comments-in-ruamel-yaml

yaml_str = """\
# Our app configuration

# foo is our main variable
foo: bar

# foz is also important
foz: quz

# And finally we have our optional configs.
# These are not really mandatory, they can be
# considere as "would be nice".
opt1: foqz
"""

undefined = object()

def my_pop(self, key, default=undefined):
    if key not in self:
        if default is undefined:
            raise KeyError(key)
        return default
    keys = list(self.keys())
    idx = keys.index(key)
    if key in self.ca.items:
        if idx == 0:
            raise NotImplementedError('cannot handle moving comment when popping the first key', key)
        prev = keys[idx-1]
        # print('prev', prev, self.ca)
        comment = self.ca.items.pop(key)[2]
        if prev in self.ca.items:
            self.ca.items[prev][2].value += comment.value
        else:
            self.ca.items[prev] = self.ca.items.pop(key)
    res = self.__getitem__(key)
    self.__delitem__(key)
    return res

ruamel.yaml.comments.CommentedMap.pop = my_pop
    
yaml = ruamel.yaml.YAML()
data = yaml.load(yaml_str)

data.pop('foz', None)

yaml.dump(data, sys.stdout)