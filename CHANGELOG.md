# Capistrano::Jetty Changelog

This is the Changelog for Capistrano::Jetty.

## v1.2.1 (2016-02-09)

* Fix error message for missing variable during validation

## v1.2.0 (2014-06-09)

* Refactor deployment to be zero-downtime courtesy of evertrue/et_haproxy-cookbook@v3.1.0

## v1.1.0 (2014-02-13)

* Add validation to check for necessary Capistrano variables

## v1.0.0 (2014-02-12)

* Initial production release, idential to 0.0.6

## v0.0.6 (2014-02-12)

* Use correct filepaths for better namespacing

## v0.0.5 (2014-02-11)

* Revert previous change, as they should work inside `:deploy` namespace
* Make task hooks explicit

## v0.0.4 (2014-02-11)

* Move task hooks into global namespace so tasks actually hook in & are run

## v0.0.3 (2014-02-11)

* Add missing, empty Ruby file to load Gem properly

## v0.0.2 (2014-02-11)

* Fix incorrect `require` in gemspec

## v0.0.1 (2014-02-11)

* Initial release
