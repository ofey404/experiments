print("run it on windows")

from inputs import devices
for d in devices:
    print(d)
# Microsoft Keyboard
# Microsoft Mouse
# Microsoft X-Box 360 pad

from inputs import get_gamepad
while True:
    events = get_gamepad()
    for e in events:
        print(e.ev_type, e.code, e.state)
# Absolute ABS_RY -363
# Sync SYN_REPORT 0
# Absolute ABS_Y -57
# Absolute ABS_RY -338
# Sync SYN_REPORT 0
# Absolute ABS_Y -42
# Sync SYN_REPORT 0
# Absolute ABS_RY -261
# Sync SYN_REPORT 0
# Absolute ABS_RY -238
# Sync SYN_REPORT 0
# Absolute ABS_Y -203
# Sync SYN_REPORT 0
# Absolute ABS_Y -278
# Sync SYN_REPORT 0
# Absolute ABS_Y -338
# Sync SYN_REPORT 0
# Absolute ABS_Y -381
# Sync SYN_REPORT 0
# Absolute ABS_X -404
# Absolute ABS_Y -1259
# Absolute ABS_RX 94
# Absolute ABS_RY -637
# Sync SYN_REPORT 0
# Absolute ABS_X -530
# Absolute ABS_Y -1697
# Absolute ABS_RX -296
# Absolute ABS_RY -1014
# Sync SYN_REPORT 0
# Absolute ABS_X -637
# Absolute ABS_Y -2052
# Absolute ABS_RX -607
# Absolute ABS_RY -1306
# Sync SYN_REPORT 0
# Absolute ABS_X -724
# Absolute ABS_Y -2307
# Absolute ABS_RX -861
# Absolute ABS_RY -1534
# Sync SYN_REPORT 0
# Absolute ABS_X -790
# Absolute ABS_Y -2479
# Absolute ABS_RX -1065
# Absolute ABS_RY -1717
# Sync SYN_REPORT 0
# Absolute ABS_X -849
# Absolute ABS_Y -2607
# Absolute ABS_RX -1228
# Absolute ABS_RY -1863
# Sync SYN_REPORT 0
# Absolute ABS_X -896
# Absolute ABS_Y -2709
# Absolute ABS_RX -1358
# Absolute ABS_RY -1980
# Sync SYN_REPORT 0
# Absolute ABS_Y -2791
# Absolute ABS_RX -1462
