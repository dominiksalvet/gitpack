# How It Works

This file describes how GitPack works. It is basically **everything you need to start** using GitPack in your awesome projects. Once a project (repository) is prepared, end users may **immediately install it**.

## Installation Files

GitPack uses files in the `.install` directory of your repository to perform all required operations. Basically, GitPack uses two types of executable files placed there – one for installation and one for uninstallation.

Whenever GitPack runs those executables, the current working directory is set to the repository root. If the execution succeeds (i.e., returns 0), GitPack will mark your project as installed or not installed, respectively. Note that the executables do not have to be Shell scripts, they may be of any type (e.g., Python).

Since GitPack is very flexible, there are multiple methods of how GitPack may install your project. You may decide to support only one, or **you can support more installation methods** at once. Based on that, there may be multiple installation and uninstallation executables.

### Universal Local Installation

Used for installations within the current user home directory. To support this installation in your project, create the following executable files:

* `.install/install-local`
  * When run, it installs (e.g., copy files) the current commit (version) locally.
* `.install/uninstall-local`
  * When run, it uninstalls (e.g., remove files) the local installation.

### Universal Global Installation

Used for installations within the whole system. To support, create the following executable files:

* `.install/install-global`
  * When run, it installs the current commit globally.
* `.install/uninstall-global`
  * When run, it uninstalls the global installation.

> GitPack runs all `global` executables with root permissions.

### Operating System Specific Installation

Used for installations on a particular operating system. Installing on other operating systems will fail. To support, create the following executable files:

* `.install/install-<access>-<system>`
  * `<access>` is either `local` or `global` with the same meaning as above.
  * `<system>` is the supported operating system name.
  * Before running, GitPack checks that `<system>` matches the `uname` output.
  * When run, it installs the current commit.
* `.install/uninstall-<access>-<system>`
  * When run, it uninstalls the current commit.

> GitPack prefers this installation method to others, when available.

### Auxiliary Files

Sometimes it is required to have more than just the executable files above (e.g., a systemd service file). For this purpose, you may put auxiliary files associated with the installation process to the `.install` directory as well. As long as their names do not start with `install` or `uninstall`, there are no special restrictions.

## Examples

It is always **good to see some examples**. [Here](https://github.com/topics/gitpack) is a list of projects that use GitPack. Feel free to find their `.install` directories and get inspired.
