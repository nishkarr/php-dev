# php-dev

A php development container with php 8.2 and node 18 for Symfony development.

Usage:

```
docker run --rm -it -v $(pwd):/app \
    -v /etc/passwd:/etc/passwd \
    -p 8088:8088 \
    --user $(id -u):$(id -g) nishkarr/php-dev
```

