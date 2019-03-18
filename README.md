# croute-lite(container routing proxy lite)

- Docker container proxy, just for development environments.
- nginx and lua (openresty) and sqlite3


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

### Add proxy setting 

- add proxy setting to domain and container with get parameter 
```
# curl "http://localhost:8000/add?domain=test.com&container=test"
```

### Delete proxy setting 
- delete proxy setting with domain
```
# curl "http://localhost:8000/delete?domain=test.com"
```

### Show domain setting
- all 
```
# curl "http://localhost:8000/show_all"
```
- with specific domain
```
# curl "http://localhost:8000/show?domain=test.com"
```

