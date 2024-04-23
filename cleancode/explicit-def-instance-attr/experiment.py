from pprint import pprint

# python experiment.py 
# # Python instance attribute could be defined explicitly in the class definition like this:
# class InstanceAttrExample:
#     attr1: int
#     attr2: str
# 
#     def __init__(self, attr1: int, attr2: str):
#         self.attr1 = attr1
#         self.attr2 = attr2
# ====
# Test:
# 
# Instance 1:
# {'attr1': 1, 'attr2': 'one'}
# InstanceAttrExample.attr1:
# type object 'InstanceAttrExample' has no attribute 'attr1'
# Class 1:
# {'attr1': 1, 'attr2': 'one'}
# ClassAttrExample.attr1:
# 404

class InstanceAttrExample:
    attr1: int
    attr2: str

    def __init__(self, attr1: int, attr2: str):
        self.attr1 = attr1
        self.attr2 = attr2

    

class ClassAttrExample:
    attr1 = 404
    attr2 = "Not Found"

    def __init__(self, attr1: int, attr2: str):
        self.attr1 = attr1
        self.attr2 = attr2


def main():
    print("""# Python instance attribute could be defined explicitly in the class definition like this:
class InstanceAttrExample:
    attr1: int
    attr2: str

    def __init__(self, attr1: int, attr2: str):
        self.attr1 = attr1
        self.attr2 = attr2
====
Test:
""")
    instance1 = InstanceAttrExample(1, "one")

    print("Instance 1:")
    pprint(instance1.__dict__)
    print("InstanceAttrExample.attr1:")
    try:
        pprint(InstanceAttrExample.attr1)
    except Exception as e:
        print(e)

    class1 = ClassAttrExample(1, "one")

    print("Class 1:")
    pprint(class1.__dict__)
    print("ClassAttrExample.attr1:")
    pprint(ClassAttrExample.attr1)


if __name__ == "__main__":
    main()