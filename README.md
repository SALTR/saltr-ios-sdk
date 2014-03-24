This is the README file of the "Saltr" iOS SDK.

CONTENTS
========
1. INTRODUCTION
2. USAGE
3. DIRECTORY STRUCTURE
4. DOCUMENTATION

1. INTRODUCTION
===============

Saltr iOS SDK is a library aimed to simplify data transmission between saltr
portal and iOS mobile game apps. 

This includes mechanism to connect with the portal and receive the set of data
that corresponds to the client app instance. The server sends JSON data and the
SDK parses to the corresponding hierarchy of objects by initializing them with
the received values.

At the moment two types of data are being requested from the portal and parsed: app
data and level data.
After the objects are ready to use, the iOS client application uses that
objects for getting/setting needed info.

2. USAGE
========

Please refer to the included SaltrTestApp for the reference on the library usage.
You can copy the test app and further enhance it as you see need.

Note, that the client or test app should include the library with the data
bundle, which is used when there is no internet connection. See the detailed
usage in the test app.

The sdk supports iOS v5.0+ platforms.

3. DIRECTORY STRUCTURE
======================

Library and test app source code is available on github with the following URL:

https://github.com/plexonic/saltr-ios-sdk.git

The sdk has the following directory structure:

- Saltr.xcodeproj - xcode main project configuration file
- Saltr - the sources of the sdk
- SaltrResource - the bundle of the sdk resources
- SaltrTests - sdk unit tests built with XCTestFramework
- SaltrTestApp - a sample app which uses the sdk
- SaltrTestAppTests - an empty test project for the sample app
- testdata - test data samples

4. DOCUMENTATION
================

The ChangeLog and ReleaseNotes of the project are available within the sources.

The detailed SDK documentation is generated with doxygen after building the project.
