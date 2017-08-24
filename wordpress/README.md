WordPress development environment
=================================

This directory contains scripts to initialize and run an isolated WordPress development environment.
An isolated WordPress environment is establish for each project, distinguished from other WordPress projects by its project name.


The main container, `main.mlab`, starts the entire environment.
The main receives as a parameter the project name. this project name should be unique, and will be used as an identifier to re-connect a specific project.


The WordPress setup includes the following tools:
* WordPress
* Database
* phpMyAdmin
* WP-CLI

## Working with WordPress development environment

### Creating a new project

In order to create an entire new and clean project, a new project name should be given while establishing the setup.
The given project name will be used as a project ID during the life cycle of the project.

The following steps are required to initiate a new project:

* Run `main.mlab` with a new project name as a parameter.
* Wait as the setup initializes, until all 4 containers are active.
* activate the `wordpress` action of the main container.
* Start work with WordPress dashboard to create your new project.

### Connecting to an existing project

In order to connect an existing project, The required project name should be given when launchin the setup.
The given project name is used as a project ID during the entire life cycle of the project and its content.

The following steps are required to re-connect an existing project:

* Run `main.mlab` with the desired project name as a parameter.
* Wait as the setup initializes, until all 4 containers are active.
* Continue working on the project via WordPress dashboard or any other tool.

## Setup description

MinuteLab setup for WordPress development environment is composed from several containers, each represented by `.mlab` script.

### `main.mlab` - orchestrating the other containers in the setup.

Creates a full environment of a WordPress + database + phpMyAdmin running in their own private network.

**NAME**

The main container name is the `project name` parameter.

**PARAMETERS**

* project name. The project name is used as a unique identifier of a project. (default: myproj)

**ACTIONS**

* wordpress - connecting the WordPress dashboard in a browser window.
* shell - open a bash command line window connected to the container.

### `wordpress.mlab` - a WordPress server.

This script initialize a WordPress server including a WP-CLI tool.

**NAME**

The WordPress container name is [project name]-wp.

**PARAMETERS**

While activating the WordPress setup as a single unit (main.mlab), the main container controls the parameters.

* Database host. The IP address of the setup database.
* project name. The project name is used as a unique identifier.
* external allocated port.

**ACTIONS**

* shell - open a bash command line window connected to the container. This shell can be used for WP-CLI commands (addressed as 'wp').


### `db.mlab` - a generic mariadb server

This script initializes a mariadb database.
The database is created with user: root, and password: example.

**NAME**

The database container name is [project name]-db.

**PARAMETERS**

While activating the WordPress development environment as single unit (main.mlab), the main container controls the parameters.

* Database IP Address. The IP address the database.
* project name. The project name is used as a unique identifier of a project.

**ACTIONS**

* mysql - opens a mysql command-line client.
* shell - open a bash command-line window connected to the container.

### `phpMyAdmin.mlab` - an administration of MySQL / MariaDB over the Web

This script initializes a phpMyAdmin application server.

**NAME**

The phpMyAdmin container name is [project name]-pma.

**PARAMETERS**

While activating the WordPress setup as single unit (main.mlab), the main container controls the parameters.

* Database host. The IP address of the setup database.
* project name. The project name is used as a unique identifier of a project.

**ACTIONS**

* admin - connecting the phpMyAdmin dashboard in a browser.
* shell - open a bash command-line window connected to the container. This shell can be used for WP-CLI commands.
