import dis


def disassamble_dict_insert():
    container = dict()

    container["key"] = "value"


def disassamble_dict_unpack():
    container = dict()

    for k, v in container:
        _, _ = k, v


def main():
    dis.dis(disassamble_dict_unpack)
    print("#######################")
    dis.dis(disassamble_dict_insert)


if __name__ == "__main__":
    main()
