# Trunks Docker Image
The following image includes a build of [trunks](https://github.com/shynuu/trunks).

> [!TIP]
> By default, configuration file from templating is used if no `--config` or `-c` is passed as argument. To start without argument, use:
> ```yaml
> command: [" "]
> ```

## Environment variables
- On DockerHub: [`louisroyer/trunks`](https://hub.docker.com/repository/docker/louisroyer/trunks)

Environment variable used to select templating system:
```yaml
environment:
  ROUTING_SCRIPT: ""
  TEMPLATE_SCRIPT: "template-script.sh"
  TEMPLATE_SCRIPT_ARGS: ""
  CONFIG_FILE: "/etc/trunks/trunks.yaml"
  CONFIG_TEMPLATE: "/usr/local/share/trunks/template.yaml"
```

Environment variables for templating:
```yaml
environment:
  NIC_GW: "10.0.214.4"
  NIC_ST: "10.0.213.4"
  BW_FORWARD: 10000
  BW_RETURN: 2500
  DELAY_VALUE: 45
  DELAY_OFFSET: 5
  # ACM is only required if you use the command line argument --acm
  ACM: |-
    - weight: 1
      duration: 10
    - weight: 0.8
      duration: 10
    - weight: 0.9
      duration: 10
    - weight: 0.5
      duration: 10
    - weight: 0.7
      duration: 10
```

A routing script is provided (`routing-default.sh`).
If you have the following architecture:

```text
    (Left) -- (R1) -- (trunks) -- (R2) -- (Right)
```

Packets from `Left` forwarded by `R1` to `trunks` will be forwarded to `R2` by `trunks`.
Packets from `Right` forwarded by `R2` to `trunks` will be forwarded to `R1` by `trunks`.

For example, is `R1` IP is `10.0.214.3` and `R2` IP is `10.0.213.3`, then you can use the following environment variables.

```yaml
environment:
  ROUTING_SCRIPT: "routing-default.sh"
  ROUTING_GW_IP: "10.0.214.4"
  ROUTING_GW_NEXT_HOP: "10.0.214.3"
  ROUTING_ST_IP: "10.0.213.4"
  ROUTING_ST_NEXT_HOP: "10.0.213.3"
```
