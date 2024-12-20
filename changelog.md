# Changelog

All notable changes to GitPack will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and GitPack adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## Unreleased

The changes not yet present in any release are listed in this section.

### Fixed

* The Bash completion now uses only files that are in its current access scope (root vs user).

## 1.2.0 (2024-11-27)

### Changed

* For Linux, changed the lock directory base from `/var/lock` to `/tmp`.

## 1.1.0 (2021-08-17)

### Changed

* Removed `-S` option, replaced by `GITPACK_SKIP_LOCK` environment variable.

## 1.0.0 (2021-02-11)

### Added

* Error messages contain also a unique ID. No reuse allowed.
* Added messages to ease watching the progress of GitPack execution.
* Added package index – fetch repositories updates only once an hour, otherwise use cache.
* Added a hint message when bad arguments passed to ease finding GitPack's help.
* Added long hash mode option `-H` forcing to always show full commit hashes.
* Added fetch mode option `-f` making GitPack always fetch from remote.
* Added support for raw URL mode `-r`, in which GitPack performs no HTTPS adjustments.
* Added native mode for Bash completion, allowing it to use more features.
* Added support for cached packages version hints in Bash completion.
* Added option `-n` to never fetch from remote.
* Added option `-S` to skip locking (useful for GitPack wrappers).
* Added option `-d` to disable checking for installed URL basename duplicates.

### Changed

* Travis CI has been replaced by GitHub Actions CI.
* Only optional commands are checked for their existence before execution.
* The format of `paths` command output has been changed.
* Warnings of ambiguous references are no longer suppressed.
* GitPack repository directory `.gitpack` was renamed to `.install`.
* Installation and uninstallation are accomplished exclusively using GitPack scripts.
* The output of actions uses significantly different format.
* The Bash tab completion now uses `status` and `fetched` files to create URL hints.
* All options have been moved to right after `gitpack` command, not per action/command basis.
* If more than one `=` is used in `URL=VERSION` argument, `URL` contains additional `=` rather than `VERSION`.
* Bash tab completion considers previous arguments and dynamically generates hints.
* When running on macOS, more predictable file paths are used.
* When not running on a recognized system, fallback file paths are used.
* Check URL basename against installed URL basenames for possible duplicates.

### Fixed

* When fetching a repository fails, it is no longer present in Bash tab completion hints.
* Only one instance of GitPack per user may be running at a time.
* Unless raw URL mode used, GitPack removes or merges unnecessary `/` of URLs before processing.
* Handle invalid URL hashes stored in `status`.

### Removed

* The support for dependencies has been completely removed.
* The support for logging has been removed.
* Support for `status` backup mechanism has been removed.
* Support for GitPack `map` has been removed.
* The offline mode, including the `-o` option, has been removed.

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
