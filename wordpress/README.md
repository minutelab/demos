WordPress development environment
=================================

This directory described how to run a WordPress development environment in Minute Lab.
It allows a user to initialize and run an isolated WordPress environment for every worpress project.
Each environment (or a 'setup') is distinguished from other WordPress projects in Minute Lab by its project name.

### Prerequisites

1. On-board the Minute Lab service. It is recommended to use the
   [Minute Lab's QuickStart Guide](http://docs.minutelab.io/user-guide/quickstart/).
2. Configure a shared sync that includes the example directory.
   (it is recommended to share the whole demos directory, but you can be more specific)

### Running WordPress

The setup is composed of several components or containers. The main container, `main.mlab`(henceforth called `main`), starts the entire setup.
Launching the setup is done using Minute Lab's desktop client to run main. When running the setup, a 'project name' (an input parameter) is required. This project name should be unique, and is used from that point on as an identifier to re-open a specific project in wordpress.


The WordPress setup includes the following tools, commonly required by wordpres developers:
* WordPress
* Database
* phpMyAdmin
* WP-CLI

## Working with a WordPress development environment

### Creating a new project

To create a new project, enter a new project name as the input parameter needed when running the WordPress setup. 
The given project name will be used as a project identifier for the entire project lifecycle.

The following steps are required to initiate a new project:

* Run `main.mlab` with a new project name as a parameter.
* Wait as the setup initializes, until all four containers are active and the associated command prompt reports "Lab is ready....".
* In the mlab desktop client, go to 'Setups' and hover over the main container, represented by the project name. On the right side, a 'terminate container' and a 'connect' buttons will appear. Click the connect button and select 'WordPress' from the menu. This will activate the `WordPress` action enabled by the main container.
* Start to work with WordPress dashboard to create your new project.

### Reopening an existing project

To re-open an existing project, The required project name should be entered when launching the setup.
The project name is used as a project identifier throughout the entire lifecycle of the project and its content.

Follow these steps to reopen an existing project:

* Run `main.mlab` with the desired project name as a parameter.
* Wait as the setup initializes, until all 4 containers are active and the associated command prompt reports "Lab is ready....".
* Continue working on the project via WordPress dashboard or any other tool.

## Setup description

Minute Lab setup for WordPress development environment is composed of several containers, each defined by `.mlab` script.

### `main.mlab` - orchestrates the other containers in the setup.

Creates a full environment including WordPress + database + phpMyAdmin interconnected via a private network.

**NAME**

The main container name is the `project name` parameter.

**PARAMETERS**

* project name. The project name is used as a unique identifier of a project. (default: myproj)

**ACTIONS**

* wordpress - Opens the WordPress dashboard in a web browser window.
* shell - opens a bash command line window connected to the container.

### `wordpress.mlab` - a WordPress server.

This script initializes a WordPress server including a WP-CLI tool.

**NAME**

The WordPress container name is [project name]-wp.

**PARAMETERS**

While activating the WordPress setup as a single unit (main.mlab), the main container controls the parameters.

* Database host. The IP address of the setup database.
* project name. The project name is used as a unique identifier.
* external allocated port.

**ACTIONS**

* shell - opens a bash command line window connected to the container. This shell can be used for WP-CLI commands (addressed as 'wp').


### `db.mlab` - a generic mariadb server

This script initializes a mariadb database.
The database is created with user: root, and password: example.

**NAME**

The database container name is [project name]-db.

**PARAMETERS**

While activating the WordPress development environment as a single unit (main.mlab), the main container controls the parameters.

* Database IP Address. The database's IP address.
* project name. Used as the project unique identifier.

**ACTIONS**

* mysql - opens a mysql command-line client.
* shell - open a bash command-line window connected to the container.

### `phpMyAdmin.mlab` - MySQL/MariaDB administration over the Web

This script initializes a phpMyAdmin application server.

**NAME**

The phpMyAdmin container name is [project name]-pma.

**PARAMETERS**

While activating the WordPress setup as single unit (main.mlab), the main container controls the parameters.

* Database host. The IP address of the setup database.
* project name. Used as the project unique identifier.

**ACTIONS**

* admin - Opens a phpMyAdmin dashboard in a web browser.
* shell - open a bash command-line window connected to the container. This shell can be used for WP-CLI commands.
