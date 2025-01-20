# Changelog

## [1.2.0](https://github.com/CloudNationHQ/terraform-azure-mysql/compare/v1.1.0...v1.2.0) (2025-01-20)


### Features

* **deps:** bump github.com/gruntwork-io/terratest in /tests ([#19](https://github.com/CloudNationHQ/terraform-azure-mysql/issues/19)) ([1371d58](https://github.com/CloudNationHQ/terraform-azure-mysql/commit/1371d5838390cd202964b296b84a15bc6994020f))
* **deps:** bump golang.org/x/crypto from 0.29.0 to 0.31.0 in /tests ([#22](https://github.com/CloudNationHQ/terraform-azure-mysql/issues/22)) ([a70c1d7](https://github.com/CloudNationHQ/terraform-azure-mysql/commit/a70c1d7873cd822af27f08b496e514a00dabaf45))
* **deps:** bump golang.org/x/net from 0.31.0 to 0.33.0 in /tests ([#23](https://github.com/CloudNationHQ/terraform-azure-mysql/issues/23)) ([29998d1](https://github.com/CloudNationHQ/terraform-azure-mysql/commit/29998d1a5c9c3e1af66cb2dbee998750bd084f99))
* remove temporary files when deployment tests fails ([#20](https://github.com/CloudNationHQ/terraform-azure-mysql/issues/20)) ([9072f3f](https://github.com/CloudNationHQ/terraform-azure-mysql/commit/9072f3f3bfc5143b6c3d60d91bde33251020d3c1))

## [1.1.0](https://github.com/CloudNationHQ/terraform-azure-mysql/compare/v1.0.0...v1.1.0) (2024-11-12)


### Features

* enhance testing with sequential, parallel modes and flags for exceptions and skip-destroy ([#16](https://github.com/CloudNationHQ/terraform-azure-mysql/issues/16)) ([fb779ce](https://github.com/CloudNationHQ/terraform-azure-mysql/commit/fb779ce3298fca13306c7c0faaeda057b030badd))

## [1.0.0](https://github.com/CloudNationHQ/terraform-azure-mysql/compare/v0.2.1...v1.0.0) (2024-10-24)


### ⚠ BREAKING CHANGES

* Version 4 of the azurerm provider includes breaking changes. The full list of changes can be found [here](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/4.0-upgrade-guide)

### Features

* add question template ([#10](https://github.com/CloudNationHQ/terraform-azure-mysql/issues/10)) ([b734ae0](https://github.com/CloudNationHQ/terraform-azure-mysql/commit/b734ae0d8a3d559a9b2485b3b37c9ea362d9ce96))
* **deps:** bump github.com/gruntwork-io/terratest in /tests ([#13](https://github.com/CloudNationHQ/terraform-azure-mysql/issues/13)) ([30fb05f](https://github.com/CloudNationHQ/terraform-azure-mysql/commit/30fb05fbaa1833b422f83745e70adb1c89a0044c))
* upgrade azurerm provider to v4 ([#15](https://github.com/CloudNationHQ/terraform-azure-mysql/issues/15)) ([b72456e](https://github.com/CloudNationHQ/terraform-azure-mysql/commit/b72456eebce033166825719756626da9cae202ff))

### Upgrade from v0.2.1 to v1.0.0:

- Update module reference to: `version = "~> 1.0"`
## [0.2.1](https://github.com/CloudNationHQ/terraform-azure-mysql/compare/v0.2.0...v0.2.1) (2024-08-14)


### Bug Fixes

* fix wrong module references ([#8](https://github.com/CloudNationHQ/terraform-azure-mysql/issues/8)) ([7ae0cba](https://github.com/CloudNationHQ/terraform-azure-mysql/commit/7ae0cba010e0a2728df6d6fe7067f3f2e280e46a))

## [0.2.0](https://github.com/CloudNationHQ/terraform-azure-mysql/compare/v0.1.0...v0.2.0) (2024-08-08)


### Features

* update documentation ([#4](https://github.com/CloudNationHQ/terraform-azure-mysql/issues/4)) ([2862a14](https://github.com/CloudNationHQ/terraform-azure-mysql/commit/2862a14fcc27cc65db04cf2bcb17b814b737bf84))

## 0.1.0 (2024-08-08)


### Features

* add initial resources ([#2](https://github.com/CloudNationHQ/terraform-azure-mysql/issues/2)) ([b0ffbb8](https://github.com/CloudNationHQ/terraform-azure-mysql/commit/b0ffbb81f101d8e9a8c2dce0ba6cd16060a147e8))
