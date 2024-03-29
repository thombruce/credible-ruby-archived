# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.13.0]

### Changed

- Access token remains valid until expiry - authentication no longer depends on Session still existing

## [0.12.0]

### Added
- Created CHANGELOG.md to track changes
- Add IAT and EXP to JWT and verify in Warden
- Create and issue refresh token with authenticated session
- Add refresh strategy and action for regenerating the Session upon request
- Document API endpoints in the README

### Changed

- Changed jwt to access_token on model and views for user and session

### Fixed

- Fix 500 server error on failed JWT decode by rescuing all StandardError errors

### Deprecated

- JSON response will return :access_token alongside :jwt, deprecating :jwt

## [0.11.0]

## [0.10.0]

## [0.9.1]

## [0.9.0]

## [0.8.0]

## [0.7.0]

## [0.6.0]

## [0.5.0]

## [0.4.0]

## [0.3.0]

## [0.2.1]

## [0.2.0]

## [0.1.3]

## [0.1.2]

## [0.1.1]

## [0.1.0]

[Unreleased]: https://github.com/thombruce/credible/compare/v0.13.0...HEAD
[0.13.0]: https://github.com/thombruce/credible/compare/v0.12.0...v0.13.0
[0.12.0]: https://github.com/thombruce/credible/compare/v0.11.0...v0.12.0
[0.11.0]: https://github.com/thombruce/credible/compare/v0.10.0...v0.11.0
[0.10.0]: https://github.com/thombruce/credible/compare/v0.9.1...v0.10.0
[0.9.1]: https://github.com/thombruce/credible/compare/v0.9.0...v0.9.1
[0.9.0]: https://github.com/thombruce/credible/compare/v0.8.0...v0.9.0
[0.8.0]: https://github.com/thombruce/credible/compare/v0.7.0...v0.8.0
[0.7.0]: https://github.com/thombruce/credible/compare/v0.6.0...v0.7.0
[0.6.0]: https://github.com/thombruce/credible/compare/v0.5.0...v0.6.0
[0.5.0]: https://github.com/thombruce/credible/compare/v0.4.0...v0.5.0
[0.4.0]: https://github.com/thombruce/credible/compare/v0.3.0...v0.4.0
[0.3.0]: https://github.com/thombruce/credible/compare/v0.2.1...v0.3.0
[0.2.1]: https://github.com/thombruce/credible/compare/v0.2.0...v0.2.1
[0.2.0]: https://github.com/thombruce/credible/compare/v0.1.3...v0.2.0
[0.1.3]: https://github.com/thombruce/credible/compare/v0.1.2...v0.1.3
[0.1.2]: https://github.com/thombruce/credible/compare/v0.1.1...v0.1.2
[0.1.1]: https://github.com/thombruce/credible/compare/v0.1.0...v0.1.1
[0.1.0]: https://github.com/thombruce/credible/releases/tag/v0.1.0
