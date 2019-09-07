# Changelog

All notable changes to GitPack will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and GitPack adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## Unreleased

The changes not yet present in any release are listed in this section.

### Added

* A simple mechanism for cyclic dependencies prevention has been added.
* GitPack now keeps one backup copy of *status* file and recovers from it when *status* file does not exist.

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
