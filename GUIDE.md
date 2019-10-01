# Guide

This file contains **everything you need to start** using GitPack in your awesome Git projects. Once you follow this guide, end users can immediately install, update or uninstall your projects. Immediately.

## General

In default, GitPack works with the master branches using their either latest tag (preferred) or latest commit.

## Files

GitPack works with the *.gitpack* directory of Git repositories matching the following structure:

* *.gitpack/install/*`<method>` is a directory:
  * Its name starts with either `global` or `local` based on **installation type**.
  * To target a particular system, append its name as `-<system>`.
  * E.g., `local-Darwin` represents local installation for macOS.
* *.gitpack/install/\<method\>/*`map` is a file:
  * Describes **how project files are copied/removed** during installation/uninstallation.
  * Has file paths to be copied and a target directory per line.
  * E.g., line `bin/vhdldep /usr/local/bin` copies *vhdldep* file to */usr/local/bin* directory.

## Optional files

GitPack also works with optional files located in the *.gitpack* directory as follows:

* *.gitpack/install/\<method\>/*`<script>` is an executable file:
  * Its name is `precp`, `postcp`, `prerm`, or `postrm`.
  * It is run before the copying, after, before the removal, or after.
  * E.g., `postcp` modifies */etc/rc.local* file to execute *asus-fan-control* after boot.
* *.gitpack/*`data` is a directory:
  * It contains any additional data related to the installation.
  * E.g., it contains `.bash_completion` file, which is copied during *precp* script execution.
* *.gitpack/*`deps` is a file:
  * It represents a list of the project's Git dependencies.
  * Has one dependency per line in the same format as the GitPack URL arguments.
  * E.g., line `github.com/dominiksalvet/ux430ua-jack-volume=2.4.0` is a valid dependency.

## Examples

If you are interested in **examples of projects using GitPack**, take a look at the [gitpack topic](https://github.com/topics/gitpack).
