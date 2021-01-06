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

`TODO: content`

## Install

`TODO: simplify installation`

### Dependencies

* **Git** software

## Usage

If GitPack is run with root permissions (e.g., using `sudo`), it will use global access and perform global installations. Otherwise, a local approach will be used.

Install/update to the **latest version**:

```
gitpack install <url>
```

Install/update/downgrade to a **particular version**:

```
gitpack install <url>=<version>
```

> The `<version>` is any Git revision (tag, branch, hash).

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
