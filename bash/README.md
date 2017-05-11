# Shell (bash example)

This is a very minimal container: just run bash inside a container.

It however shows also few advanced concepts

## Keep history

This container keep the bash history file, on the local desktop so it is kept
between runs.

When creating the container we add the history using `ADD -ifexist`.
If we hadn't used the `-ifexist` flag first run would raise an error.

When the container is done we get the history file using the `OUTPUT` directive

## Controlling the base image version with parameters

Passing a parameter to the mlab script control the image version.
Quite meaningless in such a simple example but very useful for more complicated containers
