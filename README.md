# Tunitas Tarwater

This repository contains a reference implementation of the [Digi-Trust](http://www.digitru.st) universal identity system.
It is an an application hosted within the <em>httpserver</em> surface of [microhttpd](https://www.gnu.org/software/libmicrohttpd/).  As such, it is a "<em>micro</em>service" approach to delivering the identity linking function.

The main body of documentation for the Tunitas family of components and services can be found with the [packaging](https://github.com/yahoo/tunitas-packaging) and with [build system](https://github.com/yahoo/temerarious-flagship]).  The overview and administrative declarations herein are necessarily summary in nature. The declarations and definitions in the packaging and build system areas are complete and should be interpreted as superceding these when the two are in conflict.

![banner](logo.png)

## Table of Contents

- [Background](#background)
- [Dependencies](#dependencies)
- [Installation](#installation)
- [Configuration](#configuration)
- [Build](#build)
- [Usage](#usage)
- [References](#references)
- [Security](#security)
- [Contribute](#contribute)
- [License](#license)
- [Origin of the Name](#Origin_of_the_name)

## Background

The implementation herein follows the [User Sync Service](https://github.com/digi-trust/dt-cdn/wiki/User-Sync-Service-%28Draft%29) draft specification.

## Dependencies

The [configuration](#configuration) step will check for many but not all required packages and operating system features.  There is a list of known [package-dependencies](https://github.com/yahoo/tunitas-tarwater/blob/master/PACKAGES.md) which you will need to install beyond your base operating system.

Generally, the dependencies are among:
- Certain other components of the Tunitas system; <em>e.g.</em> the [Basic Components](https://github.com/yahoo/tunitas-basic).
- A modern (C++2a) development environment.
- A recent Fedora, but any recent Linux distro should suffice.

The Tunitas project was developed on Fedora 27 through Fedora 30 using GCC 7 and GCC 8 with `-fconcepts` and at least `-std=c++1z`.  More details on the development environment and the build system can be found in [temerarious-flagship](https://github.com/yahoo/temerarious-flagship/blob/master/README.md).

## Installation

You may install this repo and its dependents by running the following command:

``` bash
git clone https://github.com/yahoo/tunitas-tarwater.git
```

This will create a directory called `tunitas-tarwater` and download the contents of this repo to it.

Alternatively, if your organization already has made available the packaged version, then the following recipe will install the service:

``` bash
sudo dnf install tunitas-tarwater
```

## Configuration

The build system is based upon [GNU Autotools](https://www.gnu.org/software/automake/manual/html_node/index.html).

The configuration of the repo consists of two steps which must be done once.
1. `./buildconf`
2. `./configure`

The first step performs some crude assessments of the build environment and creates the site-specific `configure'. Of course `configure --help` will explain the build options.  The general options to `configure` are widely [documented](https://www.gnu.org/prep/standards/html_node/Configuration.html).

The `buildconf` component is boilerplate and can be updated from [temerarious-flagship](https://github.com/yahoo/temerarious-flagship/blob/master/bc/template.autotools-buildconf) as needed.  The [Tunitas Build System](https://github.com/yahoo/temerarious-flagship) should be available in `/opt/tunitas` and the template at `/opt/tunitas/share/temerarious-flagship/bc/template.autotools-buildconf`

## Build

The service can be built with the following recipe:

``` bash
./buildconf &&
./configure &&
make &&
make check &&
make install &&
echo OK DONE
```

Alternatively, if your organization already has made available the packaged version, then the following recipe will install the service:

``` bash
sudo dnf install tunitas-tarwater
```

## Usage

The configuration of the service is through the systemd unit files which are supplied.

``` bash
systemctl enable tarwater-service
systemctl start tarwater-service
```

## References

### Identity Synchronization Services

* [User Sync Service](https://github.com/digi-trust/dt-cdn/wiki/User-Sync-Service-%28Draft%29) 

### Digi-Trust

* [Digi-Trust](http://www.digitru.st/), promotional site of the TechLab of the Interactive Advertising Bureau (IAB).
* [digi-trust](https://github.com/digi-trust), organization, hosted at GitHub.
* [[Digi-Trust, Java]](https://github.com/digi-trust/identity-core-java), hosted at GitHub.

## Security

The Tarwater service is intended to facilitate persistent, ubiquitous, "always on" linking of force-placed consumer identifiers across multiple spans of the [Web Same Origin Policy](https://en.wikipedia.org/wiki/Same-origin_policy).  While there are no known security implications around this business practice, there is significant interest in the practice by both jurisdictional commercial regulatory bodies (rules, regulations, laws) as well as voluntary trade representation bodies (self-regulatory codes).  Care should be taken in the operation of this service.

### Server Containers

* [etr/libhttpserver](https://github.com/etr/libhttpserver)
* [microhttpd](https://www.gnu.org/software/libmicrohttpd/)
* [libmicrohttpd](https://git.gnunet.org/libmicrohttpd.git), forked as [libmicrohttpd](https://github.com/scottjg/libmicrohttpd)

## Contribute

Please refer to [the contributing.md file](Contributing.md) for information about how to get involved. We welcome issues, questions, and pull requests. Pull Requests are welcome.

## Maintainers
- Wendell Baker <wbaker@verizonmedia.com>
- The Tunitas Team at Verizon Media.

You may contact us at least at <tunitas@verizonmedia.com>

## License

This project is licensed under the terms of the [Apache 2.0](LICENSE-Apache-2.0) open source license. Please refer to [LICENSE](LICENSE) for the full terms.

## Origin of the Name

[Tarwater Creek](https://en.wikipedia.org/wiki/Tarwater_Creek) is a small river in San Mateo County, California and is a tributary of Pescadero Creek.
