docker run --rm -it -v $(pwd):/app \
    -v /etc/passwd:/etc/passwd \
    -p 8088:8088 \
    --user $(id -u):$(id -g) nishkarr/php-dev