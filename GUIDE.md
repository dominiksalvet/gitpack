# Guide

GitPack works only with master branch of Git projects. It uses either latest tag or latest commit as a default commit.

GitPack works with the *.gitpack* directory of Git repositories with the following structure:

* *.gitpack/install/\<method\>* is a directory
  * **Its name always starts with** either *global* or *local* based on installation type.
  * To restrict execution to a particular system, append its name as *-\<system\>*.
  * E.g., file name *local-Darwin* represents local installation for macOS-only.
* *.gitpack/install/\<method\>/map* is a file
  * Describes which project files are recursively copied and where during installation.
  * **Has only one source path** and one target directory path per line.
  * E.g., line `bin/vhdldep /usr/local/bin` copies *vhdldep* file to */usr/local/bin* directory.
* *.gitpack/install/\<method\>/\<script\>* is an executable file **(optional)**
  * Its name is *precp*, *postcp*, *prerm*, or *postrm*.
  * It is run before file copying, after, before file removal, or after.
  * E.g., *postcp* can modify */etc/rc.local* file to execute *asus-fan-control* after boot.

Git repositories with such *.gitpack* directory can be installed, updated and uninstalled using GitPack by end users.

## Examples

If you are interested in examples of projects using GitPack, take a look at the [gitpack topic](https://github.com/topics/gitpack).
