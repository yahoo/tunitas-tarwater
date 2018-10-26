# Instructions

```bash
./buildconf &&
./configure --prefix=/exp/tunitas &&
make &&
make check &&
make install
'''

# Requirements

You will need some other packages.

## Generally

  * the autotools (libtool, autoconf, automake, make)
  * make, the make-4.0 series
  * gcc, or a C++17 compiler

## Red Hat-sphere

### For Building

  * libtool, e.g. libtool-2.4.6-20.fc27.x86_64
  * autoconf, e.g. autoconf-2.69-25.fc27.noarch
  * automake, e.g. automake-1.15.1-2.fc27.noarch
  * make, e.g. make-4.2.1-4.fc27.x86_64
  * gcc-c++, e.g. gcc-c++-7.3.1-6.fc27.x86_64
  * libhttpserver-devel, e.g. libhttpserver-devel-0.9.0-3.fc24.x86_64
  * libmicrohttpd-devel, e.g. libmicrohttpd-devel-0.9.59-1.fc27.x86_64
  * gnutls-devel, e.g. gnutls-devel-3.5.18-2.fc27.x86_64

### For Testing

  * curl, curl-7.55.1-5.fc27.x86_64

## Debian-sphere

### For Building

  * same as above, but the package names are all different.
  * libhttpserver (-dev?)
  * libmicrohttpd (-dev?)
  * gnutls (-dev?)

### For Testing

  * and so on
  * curl

# Testification & Portification

Building and packaging has been tested in the ultra-modern Red Hat-sphere, namely Fedora 27 & 28 with gcc 7.3 & gcc 8.1.  Get thee to C++2a!

There should be only a little work to port to Debian-sphere distros (Debian, Ubuntu, etc.)
