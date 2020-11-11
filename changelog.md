# Changelog

All notable changes to GitPack will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and GitPack adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## Unreleased

The changes not yet present in any release are listed in this section.

### Added

* Error messages contain also a unique ID. No reuse allowed.
* Added diagnostic messages to ease watching the progress of GitPack execution.

### Changed

* Travis CI has been replaced by GitHub Actions CI.
* Only optional commands are checked for their existence before execution.
* The format of `paths` command output has been changed.
* Warnings of ambiguous references are no longer suppressed.
* GitPack repository directory `.gitpack` was renamed to `.install`.
* Installation and uninstallation are accomplished exclusively using GitPack scripts.

### Removed

* The support for dependencies has been completely removed.
* The support for logging has been removed.
* Support for `status` backup mechanism has been removed.
* Support for GitPack `map` has been removed.
* The formatted output to stdout of the action result has been removed.

## 0.7.0 (2019-10-23)

### Added

* The automatic default branch detection has been added.
* The `paths` command to show all GitPack-specific paths has been added.
* GitPack beautifies branch latest commit hashes by default.
* Hash mode option `-h` forcing to always show commit hashes has been added.

### Changed

* GitPack output does not contain `HEAD` as a version.
* Any URL not conflicting with necessary internal limitations is now supported.

### Fixed

* Version name collisions are resolved in the following order: `HEAD`, tags, branches, commit hashes.

## 0.6.0 (2019-10-08)

### Added

* The support for GitPack to work with any Git branch has been added.
* Offline mode option `-o` has been introduced.

### Changed

* GitPack *map* files may contain more than one source path per line.

### Fixed

* Removing a file with a space in its path no longer causes issues.

## 0.5.0 (2019-09-19)

### Added

* The support for tab completion in Bash shells has been added.

### Changed

* Stop following REUSE Specification - Version 3.0.

### Fixed

* There is no empty line created in *status* file during the last item deletion.

### Removed

* The custom script timeout has been removed.

## 0.4.0 (2019-09-11)

### Added

* A simple mechanism for cyclic dependencies prevention has been added.
* GitPack now keeps a backup copy of *status* file and recovers from it when *status* file does not exist.

### Changed

* If there is a fail, it will get logged with the `[fail]` logtype.

## 0.3.0 (2019-09-02)

### Added

* The support for execution logging has been added.
* Custom scripts of GitPack projects are called with a timeout.
* The support for handling signals has been added.

### Fixed

* GitPack files *map* and *deps* may be empty.

## 0.2.0 (2019-08-10)

### Added

* The `list` command has been added to list all installed Git projects using GitPack.
* The support for processing dependencies has been added.

### Changed

* GitPack transforms every URL it works with to the lowercase form.
* Meet REUSE Specification - Version 3.0.

## 0.1.0 (2019-06-27)

### Added

* Add support for installation of a given version.
* Installation and uninstallation of GitPack projects has been implemented.

### Changed

* States of status action have been renamed; `old`, `dev`, `latest` -> `older`, `newer`, `ok`.
