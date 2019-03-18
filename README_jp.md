# croute-lite(container routing proxy lite)

- Docker container proxy, just for development environments.


## How to use

### Create Network in Docker

- Create network in Docker

```
# docker create network local_nw
```

### Container start

```
# git clone https://github.com/yuhiwa/croute-lite.git
# cd croute-lite
# docker-compose up -d
```

### Default proxy setting

- container name = domain name
  - test(domain) -> test(container)
```
# curl -H 'Host: test' http://localhost/
```

