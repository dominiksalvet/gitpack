# Changelog

All notable changes to GitPack will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and GitPack adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## Unreleased

The changes not yet present in any release are listed in this section.

### Added

* The `list` command has been added to list all installed Git projects using GitPack.
* The support for processing dependencies has been added.

### Changed

* GitPack transforms every URL it works with to the lowercase form.

## 0.1.0 (2019-06-27)

### Added

* Add support for installation of a given version.
* Installation and uninstallation of GitPack projects has been implemented.

### Changed

* States of status action have been renamed; `old`, `dev`, `latest` -> `older`, `newer`, `ok`.
