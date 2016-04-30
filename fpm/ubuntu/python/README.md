### Build
From this directory, run:
```
docker build -t fpm/ubuntu/python .
```

### Usage:
The following will create _/Users/USERNAME/Downloads/python-local-VERSION-ITERATION.deb_ on the host machine:
```
docker run -v /Users/USERNAME/Downloads:/mnt/shared fpm/ubuntu/python
```
