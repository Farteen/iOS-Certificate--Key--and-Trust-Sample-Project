Purpose
--------------

This open source repo is designed to provide a convenient wrapper for the inbuilt iOS RSA cryptographic functionality.


Supported OS & SDK Versions
-----------------------------

* Supported build target - iOS 6.0 / Mac OS 10.8 (Xcode 4.5, Apple LLVM compiler 4.1)


ARC Compatibility
------------------

This project is written according to ARC conventions.

Installation
---------------

Copy the crypto library into your project or workspace.  You must link the Security.framework to any targets that will be using this library.  Also add the -ObjC and -all_load linker flags to dependent targets.


Examples
---------------

Examples for usage can be found in ViewController.m.
