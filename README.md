# Mozilla Phabricator

The [Phabricator](https://phabricator.services.mozilla.com/) system is part of 
Engineering Operations' larger Conduit project to provide better automation, 
tracking, and visualization of the pipeline from initial patch submission 
through to landing in release branches. 

## Extensions

This repository is extending the vanilla Phabricator with several extensions
mainly to provide integration with other apps from the Conduit project.

* Authentication at Bugzilla
* Integration with Bugzilla bugs
* Security Policy driven by Bugzilla
* Logging via Mozilla Logger
* Link to land the revision in Lando
* Report bugs to Sentry

## Running the app

To access the local code please run the 
`docker-compose -f docker-compose.test.yml`.

To run the full suite please read the 
[Conduit Demo](https://github.com/mozilla-conduit/demo) documentation.

## Rebuilding the library

After adding, renaming, or moving classes, run `arc liberate` to rebuild the
class map:

`$ invoke liberate`

## Testing

You can find tests in the `extensions/src/{EXTENSION}/__tests__/`.

To test extensions please run:

`$ invoke test`

## Patching the upstream

We tried to change the original Phabricator code as little as possible. If it
is necessary please consider to create hooks which will be then used in the 
extensions.

Patches are placed in the `patches/phabricator` directory. Named by the 
Bugzilla bug id and potentially the version of the patch.

## Docker images

You can find the official images on the 
[Docker Hub](https://hub.docker.com/r/mozilla/phabext/)

This app is using the [MozPhab](https://github.com/mozilla-services/mozphab)
project. The images can be found on 
[Docker Hub](https://hub.docker.com/r/mozilla/mozphab/) as well.

