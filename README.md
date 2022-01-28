# CVE-2021-4034

The [Polkit](https://en.wikipedia.org/wiki/Polkit) Privilege Escalation exploit. Dockerized for the sake of reproducibility.

## Run docker

```shell
docker build -t cve20214034 .
docker run -it --rm cve20214034
```

## Run the exploit

```shell
whoami # user
./gain-root.sh
whoami # root
```

## References

- The original advisory: https://www.qualys.com/2022/01/25/cve-2021-4034/pwnkit.txt
- The exploit used for inspiration: https://github.com/berdav/CVE-2021-4034
- Another exploit used for inspiration:https://github.com/ryaagard/CVE-2021-4034
