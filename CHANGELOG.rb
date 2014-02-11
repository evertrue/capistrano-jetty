# Capistrano::Jetty Changelog

This is the Changelog for Capistrano::Jetty.

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
