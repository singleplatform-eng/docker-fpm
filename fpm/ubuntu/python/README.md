### Build
From this directory, run:
```
docker build -t fpm/ubuntu/python .
```

### Usage:
The following will create _/Users/<username>/Downloads/python-local-<version>-<iteration>.deb_ on the host machine:
```
docker run -v /Users/<username>/Downloads:/mnt/shared fpm/ubuntu/python
```
