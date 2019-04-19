# apline-postal

A docker image from alpine:3.6 with libpostal and python package postal
installed and ready for use.

See pypostal NLP repo: https://github.com/openvenues/pypostal

DockerHub repo: https://hub.docker.com/r/lasmell/alpine-postal

The libpostal repo is a submodule of this repo. If you want to pull the updated
version of the repo do:

```
cd libpostal
git fetch
git merge origin/master
```
