# https://stackoverflow.com/questions/8234274/how-to-indent-the-contents-of-a-multi-line-string
try:
    import textwrap
    textwrap.indent
except AttributeError:  # undefined function (wasn't added until Python 3.3)
    def indent(text, amount, ch=' '):
        padding = amount * ch
        return ''.join(padding+line for line in text.splitlines(True))
else:
    def indent(text, amount, ch=' '):
        return textwrap.indent(text, amount * ch)

text = '''\
And the Lord God said unto the serpent,
Because thou hast done this, thou art
cursed above all cattle, and above every
beast of the field; upon thy belly shalt
thou go, and dust shalt thou eat all the
days of thy life: And I will put enmity
between thee and the woman, and between
thy seed and her seed; it shall bruise
thy head, and thou shalt bruise his
heel.

3:15-King James
'''

print('Text indented 4 spaces:\n')
print(indent(text, 4))

# Text indented 4 spaces:
# 
#     And the Lord God said unto the serpent,
#     Because thou hast done this, thou art
#     cursed above all cattle, and above every
#     beast of the field; upon thy belly shalt
#     thou go, and dust shalt thou eat all the
#     days of thy life: And I will put enmity
#     between thee and the woman, and between
#     thy seed and her seed; it shall bruise
#     thy head, and thou shalt bruise his
#     heel.
# 
#     3:15-King James
