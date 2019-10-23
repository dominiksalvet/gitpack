# Guide

This file contains **everything you need to start** using GitPack in your awesome Git projects. Once you follow this guide, end users can immediately install, update or uninstall your projects. Immediately.

## General

In default, GitPack works with Git default branches using their either latest tag (preferred) or latest commit.

## Files

GitPack works with the *.gitpack* directory of Git repositories matching the following structure:

* *.gitpack/install/*`<method>` is a directory:
  * Its name starts with either `global` or `local` based on **installation type**.
  * To target a particular system, append its name as `-<system>`.
  * E.g., `global-Darwin` represents global installation for macOS.
* *.gitpack/install/\<method\>/*`map` is a file:
  * Describes how project files are copied/removed during **installation/uninstallation**.
  * Each nonempty line contains file paths to be copied and a target directory path.
  * Each nonempty line is evaluated as a shell function argument. Be careful.
  * E.g., line `bin/vhdldep ~/.local/bin` copies *vhdldep* file to *~/.local/bin* directory.

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
  * Each nonempty line contains one dependency in the same format as GitPack URL arguments.
  * E.g., line `github.com/dominiksalvet/ux430ua-jack-volume=2.4.0` is a valid dependency.

## Environment variables

GitPack provides the following environment variables to all called scripts:

* `OFFLINE_MODE`
  * Equals either `false` or `true`.
  * Once set to `true`, any online access should be avoided.

## Examples

If you are interested in **examples of projects using GitPack**, take a look at the [gitpack topic](https://github.com/topics/gitpack).
