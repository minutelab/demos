Flaskr - Simple development Lab
===============================

This is a simplistic example of building a multi-container lab.

It contains two servers: a web application (flaskr), a database (postgres),
and a container that control them both.

The lab can be run in two modes:

* ***Unit testing mode***  - unit test are run inside the lab,
  and then the lab exit with the test report (and exit code).

* ***Interactive mode*** - the application is started and can be accessed by web,
  any code changes (done on the desktop) take effect immediately.


## Running the example

This example relies on the while directory being synced shared.
You can share this directory directly, but it is recommended to share the whole demos directory.

The script for the main container is `tests/system.mlab`.
To view the available parameters run it with `-h`.
On linux/mac you can directly run it as `tests/system.mlab -h`,
on Windows run it as `mlab run tests/system.mlab -h`

It accept 3 paramters:

* `-pgver` - The postgres version
* `-test` - Run in unit test move (with out it it run in interactive mode)
* `-port` - The port in which to expose the web application (on the local desktop)

### Running unit tests

To run unit tests you can simply run `tests/system.mlab -test`.

* Note that it will create locally a file with the report (flaskr_output)

* In the first run it will take it a bit to create the images. Future runs will be quicker

You can vary by trying with different postgres version.
To see a unit test failure, run it with postgres 9.0 (`tests/system.mlab -pgver 9.0`).
The flaskr code uses a feature that was introduced in postgres 9.1 so it fails with 9.0.

### Running interactive mode

To run in interactive mode just run `tests/system.mlab`, and go on your local browser to
http://localhost:5000. The application will show a login screen (with instruction about the username password).

You can watch in the GUI (or using `mlab ps -f`) the structure of the multiple container setup.

You can modify the code and watch how it affect the result. A simple change is to edit the `add_entry` function
(in `flaskr.py`) in a way that modify the strings stored in the DB.

For example modify the `cur.execute` call to be something like:

```python
cur.execute('insert into entries (title, text) values (%s, %s)',
             [request.form['title']+ " XYZ", request.form['text']])
```

And see how it affect future entries into the database.

### Running multiple labs concurrently

You can run several of those labs concurrently, you only have to make sure that
they don't try to use the same port. If you want to run them in interactive mode,
you should supply the port in the command line.

For example run `tests/system.mlab -port 5001 -pgver 9.5`,
and access it at http://localhost:5001.

If you only want to run unit tests you can specify `-port 0`, and then it will
allocate a free port.

### Cleaning the labs

Unit test labs are automatically cleaned when they are done.
To kill and clean an interactive lab just press ^C in the controlling window,
or even just close the window.

## Scripts description

### `postgres.mlab` - a generic postgresql server

This script initialize a postgres database using the provided schema (and initial content file),
wait for the server to be ready and then move to the background.

It exposes the postgres port on the selected port (by default it is the default postgres port 5432)

In addition paramter can be used to specify the postgres version (9.6, 9.5, 9.4, etc.), the external port, and the container IP

### flaskr.mlab - flaskr "microblog" web application.

This contain the flaskr web application itself.

The server is built such that the user can edit the file
(on the desktop) and the server will reload it self.
For this it is required that the the example directory will be shared with the VM (see below).

The script require one mandatory parameter: the address of the database.

It accept another optional argument -test, if it is true it perform unit test and exit

### system.mlab - orchestrating the two other containers.

This create a full system of a database + server running in their own private network.
It expose to the external world both the server port.

It define an internal private network so it can assign the postgres server a known address in it.

When it start, it call the postgres script. This initialize the database and then it move to the background.
Then it run the server and wait for it to end (^c). When the server end the system script exits,
and then the postgres script is deleted.

## Acknowledgments

(based on the [flaskr](https://github.com/pallets/flask/tree/master/examples/flaskr) example
of the [flask](http://flask.pocoo.org) microframework.
