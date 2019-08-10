# GitPack

<p align="center">
    <a href="https://github.com/dominiksalvet/gitpack">
        <img src="img/gitpack.png" alt="GitPack logo" height="256"></a>
</p>

<p align="center">
    <a href="https://github.com/dominiksalvet/gitpack">
        <img src="https://img.shields.io/badge/Git-Pack-571997.svg" alt="GitPack"></a>
    <a href="https://reuse.software">
        <img src="https://reuse.software/badge/reuse-compliant.svg" alt="reuse compliant"></a>
    <a href="https://github.com/RichardLitt/standard-readme">
        <img src="https://img.shields.io/badge/readme_style-standard-brightgreen.svg" alt="standard-readme compliant"></a>
    <a href="https://travis-ci.com/dominiksalvet/gitpack">
        <img src="https://travis-ci.com/dominiksalvet/gitpack.svg?branch=master" alt="Build Status"></a>
    <a href="https://discord.gg/BE45Y4j">
        <img src="https://img.shields.io/discord/588895022955495424.svg?logo=discord" alt="Discord chat"></a>
</p>

> The simplest Git-based package manager.

Wouldn't it be great to **install and update** your favorite Git projects like this?

```
gitpack install <url>
```

And when they are no longer needed, **uninstall** them that way?

```
gitpack uninstall <url>
```

If you are in, then GitPack comes in pretty handy. All you need is a URL of a compatible Git project.

---

**Are you a developer?** Do you like the idea stated above? Then keep reading in the [Developer](#developer) section.

> Do you want to support this awesome project? **Then spread the word!**

## Table of Contents

* [Install](#install)
* [Usage](#usage)
* [Developer](#developer)
  * [Badge](#badge)
* [Thanks](#thanks)
* [Contributing](#contributing)
* [License](#license)

## Install

**Global** (system) installation:

```sh
mkdir -p /tmp/gitpack/ && cd /tmp/gitpack/ && # prepare a temporary directory
git clone https://github.com/dominiksalvet/gitpack.git . && # clone repository
git checkout "$(git describe --tags --abbrev=0)" && # use latest version
sudo src/gitpack install github.com/dominiksalvet/gitpack # install GitPack
```

**Local** (user) installation:

```sh
mkdir -p /tmp/gitpack/ && cd /tmp/gitpack/ && # prepare a temporary directory
git clone https://github.com/dominiksalvet/gitpack.git . && # clone repository
git checkout "$(git describe --tags --abbrev=0)" && # use latest version
src/gitpack install github.com/dominiksalvet/gitpack # install GitPack
```

## Usage

**Install or update** a Git project:

```
gitpack install <url>
```

**Uninstall** a Git project:

```
gitpack uninstall <url>
```

Show **status** of a Git project:

```
gitpack status <url>
```

> Your favorite project is not compatible? Then encourage its developers to take a look at the [Developer](#developer) section.

## Developer

Why should you use GitPack in your projects?

* Simple by design
* Language-independent
* Runs on Linux, macOS and Windows (WSL)
* Shell environment and Git is all you need
* Global and local installations
* Delta updates
* POSIX-friendly

How? The [*GUIDE.md*](GUIDE.md) file will show you the way. Then users can **immediately use GitPack to install your projects**.

Not sure? Take a look at [*.gitpack*](.gitpack) directory of GitPack itself. It can be that simple.

### Badge

GitPack projects work best with the following badge:

[![GitPack](https://img.shields.io/badge/Git-Pack-571997.svg)](https://github.com/dominiksalvet/gitpack)

Markdown:

```markdown
[![GitPack](https://img.shields.io/badge/Git-Pack-571997.svg)](https://github.com/dominiksalvet/gitpack)
```

## Thanks

GitPack was born out of [gim](https://github.com/dominiksalvet/gim) from which it has learned a lot.

## Contributing

Do you want to contribute? Do you have any questions? Then the [*CONTRIBUTING.md*](CONTRIBUTING.md) file is here for you.

## License

Licensing policy of GitPack is compliant with [REUSE Specification](https://reuse.software/spec/).

The preferred license is the **MIT License** as stated in the [*MIT.txt*](LICENSES/MIT.txt) file.
