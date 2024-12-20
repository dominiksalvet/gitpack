# GitPack

<p align="center">
    <img src="img/example.gif" alt="GitPack example">
</p>

[![CI status](https://github.com/dominiksalvet/gitpack/workflows/CI/badge.svg)](https://github.com/dominiksalvet/gitpack/actions)
[![GitPack](https://img.shields.io/badge/-GitPack-571997)](https://github.com/topics/gitpack)
[![POSIX Shell](https://img.shields.io/badge/POSIX-Shell-111111)](https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html)
[![Hits](https://hits.seeyoufarm.com/api/count/incr/badge.svg?url=https%3A%2F%2Fgithub.com%2Fdominiksalvet%2Fgitpack&count_bg=%2379C83D&title_bg=%23555555&icon=&icon_color=%23E7E7E7&title=hits&edge_flat=false)](https://hits.seeyoufarm.com)

GitPack stands on a simple idea – a Git repository is a package, its URL is the package name. Based on that it is possible to **install/update** your favorite Git projects as shown:

```
gitpack install <url>
```

And when they are no longer needed, **uninstall** them that way:

```
gitpack uninstall <url>
```

GitPack not only saves time for end-users to figure out how to install a Git project, but it also **unifies the project development and distribution** in a convenient place; its Git repository.

> Do you want to try GitPack in your project? The [section for developers](#for-developers) will help you get started.

## Table of Contents

- [GitPack](#gitpack)
  - [Table of Contents](#table-of-contents)
  - [Requirements](#requirements)
  - [Installation](#installation)
  - [Usage](#usage)
    - [Examples](#examples)
  - [For Developers](#for-developers)
    - [Badge](#badge)
  - [Useful Resources](#useful-resources)

## Requirements

All you need to install and run GitPack is **Linux/Unix environment** and **Git**.

> Windows users may simply use [Git for Windows](https://gitforwindows.org).

## Installation

**Local** (user) installation:

```sh
wget -qO- https://raw.githubusercontent.com/dominiksalvet/gitpack/master/.install/initl.sh | sh
```

**Global** (system) installation:

```sh
wget -qO- https://raw.githubusercontent.com/dominiksalvet/gitpack/master/.install/initg.sh | sh
```

> If you do not have `wget`, copy-paste the source code of one of the scripts into a shell terminal and execute it.

Once installed, you will **use GitPack to manage even itself** (e.g., for updating). Now [start exploring](https://github.com/topics/gitpack).

## Usage

If GitPack is run with root permissions (e.g., using `sudo`), it will use global access and perform global installations. Otherwise, a local approach for the current user will be used.

Install/update to the **latest version**:

```
gitpack install <url>
```

> It uses the latest tag (latest commit if no tag) of the repository default branch.

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

* Use URL with no HTTPS and other adjustments (e.g., for SSH):

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
lock-path /tmp/gitpack-1000.lock

$ sudo gitpack paths
state-dir /var/lib/gitpack
cache-dir /var/cache/gitpack
lock-path /tmp/gitpack-0.lock
```

> Did you know that **GitPack has sleek tab completion** for Bash shells?

## For Developers

There are many reasons why **developers should like GitPack**:

* Tight integration with Git
* Any programming language may be used
* Runs on Linux, macOS, and other Unixes
* Runs on Windows (after [some setup](#requirements))
* Easy and flexible repository adaptation

**GitPack shines when installing** the following:

* Scripts with no/few dependencies
* Binaries directly present in the repository
* Simple compiled programs
* Other repository content (e.g., themes)

Unsure? There is **even more in GitPack**:

* Simple by design
* Delta updates
* Smart repository cache
* POSIX-friendly (i.e., very portable)
* [Standalone script](src/gitpack) (for advanced uses)
* Suitable even for self-hosted Git services

So are you ready to try GitPack in your project? Then see [how it works](how-it-works.md).

### Badge

Projects that use GitPack work best with the following sleek badge:

[![GitPack](https://img.shields.io/badge/-GitPack-571997)](https://github.com/topics/gitpack)

In markdown:

```markdown
[![GitPack](https://img.shields.io/badge/-GitPack-571997)](https://github.com/topics/gitpack)
```

## Useful Resources

* [support.md](support.md) – questions, answers, help
* [contributing.md](contributing.md) – get involved, suggestions, bug reports
* [license](license) – author, license text
