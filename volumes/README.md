Volume access containers
========================

This directory contain several utilities containers to manage data inside volumes.
Those containers can be used as is, or serve as a basis for specific use cases.

The volumes can be either synced volumes or normal volumes.

## upload.mlab

This container can upload files into a volume.

Usage:
```
upload.mlab -volume <volume>[/<path>] files...
```

For example `upload.mlab -volume data/dir1 *.txt` would upload all the files with extension `txt`,
into directory `dir` in volume `data`

## download.mlab

This container will download files or whole directories from a volume into the local desktop

Usage:
```
download.mlab -volume <volume>[/<path>] -out <local location>
```

For example `download.mlab -volume data/dir1 -out /tmp/dir1` would download the content
of directory `dir1` in volume `data` and store it as `/tmp/dir1`.

## shell.mlab

This container will open a shell (bash) in a container where the (portion) of the volume will be mounted.
Using normal linux command one can examine files.

Usage:
```
shell.mlab -volume <volume>[/<path>]
```

For example `shell.mlab -volume data`, would open a shell in a container where the `data` volume is mounted
on the current working directory (/mnt).
Running `shell.mlab -volume data/dir1` would mount only the `dir1` directory of the `data` volume.
