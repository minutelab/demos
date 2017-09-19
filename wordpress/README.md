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
* phpInfo

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

### Exporting an existing project

You can use this framework to export a WordPress project. this is useful to transfer the products of a project under development to testing or production. Use the Export script to export DB tables as `.sql` file and deliver the themes, plugins and uploads folders from the wp-content.

In case the `migrate` parameter is turned on and a new `URL` parameter is given, the export script will migrate the DB content accordingly.

All files are delivered to an output local folder as specified in the `out` parameter.

Follow these step to Export an existing project:

* Run `export.mlab` with the required project name, migrate flag, new URL to assign and the output path on your local desktop as parameters.


The Export folder files structure:

```
<output folder>
      - <export>.sql      (file)
      - wp-content        (folder)
            - plugins     (folder + content)
            - themes      (folder + content)
            - uploads     (folder + content)
```

### Cloning an existing project

Cloning a project, creates an exact duplicate of a project with a new given name.
Cloning a project can be useful to create backups or project templates.

Follow these step to Clone an existing project:

* Run `clone.mlab` with the original project name and a new project name as parameters.

### Importing an existing project

You can import an existing project using the import script. The script imports DB tables from an `.sql` file, during DB import, it migrates the DB content based on its current URL.
In addition to the `.sql` file, the import script retrieves the themes, plugins and uploads folders.
All files are imported from an input folder on the user desktop that is given as a parameter to the script.

The Input folder files structure should match the export folder file structure.

Follow these step to Import a new project:

* Run `import.mlab` with a new project name and Input folder as parameters.


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
* phpInfo - View PHP settings
* shell - opens a bash command line window connected to the container.

### `wordpress.mlab` - a WordPress server.

This script initializes a WordPress server including a WP-CLI tool.

**NAME**

The WordPress container name is wp.[project name].

**PARAMETERS**

While activating the WordPress setup as a single unit (main.mlab), the main container controls the parameters.

* project name. The project name is used as a unique identifier.
* URL. The URL of the WordPress project.
* external allocated port.

**ACTIONS**

* shell - opens a bash command line window connected to the container. This shell can be used for WP-CLI commands (addressed as 'wp').


### `db.mlab` - a generic mariadb server

This script initializes a mariadb database.
The database is created with user: root, and password: example.

**NAME**

The database container name is db.[project name].

**PARAMETERS**

While activating the WordPress development environment as a single unit (main.mlab), the main container controls the parameters.

* project name. Used as the project unique identifier.

**ACTIONS**

* mysql - opens a mysql command-line client.
* shell - open a bash command-line window connected to the container.

### `phpMyAdmin.mlab` - MySQL/MariaDB administration over the Web

This script initializes a phpMyAdmin application server.

**NAME**

The phpMyAdmin container name is pma.[project name].

**PARAMETERS**

While activating the WordPress setup as single unit (main.mlab), the main container controls the parameters.

* project name. Used as the project unique identifier.

**ACTIONS**

* admin - Opens a phpMyAdmin dashboard in a web browser.
* shell - open a bash command-line window connected to the container. This shell can be used for WP-CLI commands.
