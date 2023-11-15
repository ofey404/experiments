# ssh-multiplex

This is the playground to use istio virtualservice to multiplex ssh connections.

## Idea 2 - Dynamically assign ports: Possible

## Idea 1 - Multiplex: Not possible

> When you connect to a host via SSH, the hostname you use to connect is not included in the TCP packets themselves.
> SSH doesn't know anything about the hostname once the connection is established.

```plain text
┌────────────────┐
│ssh connection 1│
│pod1.my-ip.com  │
└───┬────────────┘
    │      ┌────────────────┐
    │      │ssh connection 2│
    │      │pod2.my-ip.com  │
    │      └───────┬────────┘
    └──────┬───────┘
┌──────────▼────────────────┐
│domain name: *.my-ip.com   │
└──────────┬────────────────┘
           │ multiplex
┌──────────▼─────────────────┐
│gateway (same IP, same port)│
└──────────┬─────────────────┘
   ┌───────┴────────────┐
┌──▼─────────────┐      │
│VirtualService1 │      │
│hosts:          │      │
│- pod1.my-ip.com│      │
└──┬─────────────┘      │
   │        ┌───────────▼────┐
   │        │VirtualService2 │
   │        │hosts:          │
   │        │- pod2.my-ip.com│
   │        └───────────┬────┘
┌──▼───┐              ┌─▼────┐
│ Pod1 │              │ Pod2 │
└──────┘              └──────┘
```

