# Is python dict iteration thread safe?

The scenerio:

> Would it cause inconsistency?

```python
container = dict()

# thread 1:
for k, v in container:
    _, _ = k, v

# thread 2:
container["new key"] = "new value"
```

## Python bytecode

GIL ensures python bytecode level thread safety.

```
  5           0 LOAD_GLOBAL              0 (dict)
              2 CALL_FUNCTION            0
              4 STORE_FAST               0 (container)

  8           6 LOAD_FAST                0 (container)
              8 GET_ITER
        >>   10 FOR_ITER                 9 (to 30)
             12 UNPACK_SEQUENCE          2
             14 STORE_FAST               1 (k)
             16 STORE_FAST               2 (v)

  9          18 LOAD_FAST                1 (k)
             20 LOAD_FAST                2 (v)
             22 ROT_TWO
             24 STORE_FAST               3 (_)
             26 STORE_FAST               3 (_)
             28 JUMP_ABSOLUTE            5 (to 10)

  8     >>   30 LOAD_CONST               0 (None)
             32 RETURN_VALUE
```



```
  4           0 LOAD_GLOBAL              0 (dict)
              2 CALL_FUNCTION            0
              4 STORE_FAST               0 (container)

  6           6 LOAD_CONST               1 ('value')
              8 LOAD_FAST                0 (container)
             10 LOAD_CONST               2 ('key')
             12 STORE_SUBSCR
             14 LOAD_CONST               0 (None)
             16 RETURN_VALUE
```
