# GitPack

`TODO: GitPack example`

[![CI status](https://github.com/dominiksalvet/gitpack/workflows/CI/badge.svg)](https://github.com/dominiksalvet/gitpack/actions)
[![GitPack](https://img.shields.io/badge/-GitPack-571997)](https://github.com/dominiksalvet/gitpack)
[![POSIX Shell](https://img.shields.io/badge/POSIX-Shell-111111)](https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html)
[![Hits](https://hits.seeyoufarm.com/api/count/incr/badge.svg?url=https%3A%2F%2Fgithub.com%2Fdominiksalvet%2Fgitpack&count_bg=%2379C83D&title_bg=%23555555&icon=&icon_color=%23E7E7E7&title=hits&edge_flat=false)](https://hits.seeyoufarm.com)

> Simple Git-based package manager.

GitPack stands on a simple idea – a Git repository is a package, its URL is the package name. Based on that it is possible to **install/update** your favorite Git projects as shown:

```
gitpack install <url>
```

And when they are no longer needed, **uninstall** them that way:

```
gitpack uninstall <url>
```

GitPack not only saves time for end users to figure out how to install a Git project, but it also **unifies the project development and distribution** in a convenient place; its Git repository.

> Do you want to try GitPack in your project? The [Developer](#developer) section will help you get started.

## Table of Contents

* [Install](#install)
  * [Dependencies](#dependencies)
* [Usage](#usage)
  * [Examples](#examples)

## Install

**Local** (user) installation:

```sh
wget -qO- https://raw.githubusercontent.com/dominiksalvet/gitpack/master/.install/initl.sh | sh
```

**Global** (system) installation:

```sh
wget -qO- https://raw.githubusercontent.com/dominiksalvet/gitpack/master/.install/initg.sh | sh
```

> If you do not have `wget`, copy-paste the source code of one of the scripts into a shell terminal and execute it.

Once installed, you will **use GitPack to manage even itself** (e.g., for updating).

### Dependencies

* **Git** software

## Usage

If GitPack is run with root permissions (e.g., using `sudo`), it will use global access and perform global installations. Otherwise, a local approach for the current user will be used.

Install/update to the **latest version**:

```
gitpack install <url>
```

> It uses the latest tag of the repository default branch.

Install/update/downgrade to a **particular version**:

```
gitpack install <url>=<version>
```

> The `<version>` is any Git revision (tag name, branch name, commit hash).

**Uninstall** (version is detected automatically):

```
gitpack uninstall <url>
```

**Show the status** of a project:

```
gitpack status <url>
```

**List all installed** projects:

```
gitpack list
```

Use `gitpack help` to **see more arguments**.

### Examples

To better understand how GitPack works, there are some examples below.

* Install a simple game with pathfinding locally (latest version):

```
$ gitpack install github.com/dominiksalvet/pathfinding-robots
>>> running install for github.com/dominiksalvet/pathfinding-robots
downloading repository
reading status database
using automatic candidate version
installing version 1.1.0
running script .install/install-local
copying files
adding to status database
<<< done; successfully installed
```

* Use URL exactly as delivered and perform no HTTPS adjustments (e.g., for SSH):

```
$ gitpack -r status git@github.com:dominiksalvet/vhdldep.git
>>> running status for git@github.com:dominiksalvet/vhdldep.git
downloading repository
reading status database
using automatic candidate version
<<< not installed; candidate is 2.2.0
```

* List globally installed projects (display full commit hashes):

```
$ sudo gitpack -H list
github.com/dominiksalvet/gitpack 4ca05c10a9903251826a8d0addc25daf6808fffa
github.com/dominiksalvet/asus-fan-control cb6be871cdbf4453d9072118194198d75dd0b380
github.com/dominiksalvet/ux430ua-jack-volume 208f1a7bce8644482abdfa14107f90358a75bb1b
```

* GitPack uses different paths for local and global access:

```
$ gitpack paths
state-dir /home/dominik/.local/share/gitpack
cache-dir /home/dominik/.cache/gitpack
lock-path /var/lock/gitpack-1000

$ sudo gitpack paths
state-dir /var/lib/gitpack
cache-dir /var/cache/gitpack
lock-path /var/lock/gitpack-0
```

> Did you know that **GitPack has sleek tab completion** for Bash shells?
