# UPS product build scripts for 0MQ

This repository provides additional files needed to build libzmq
as a [relocatable
ups](https://cdcvs.fnal.gov/redmine/projects/ups/wiki/Documentation)
(Unix Product Support) product.

## Prerequisites

To build the zeromq v4_0_7 ups product, the cetbuildtools ups product must be set up first. The build process has been tested with cetbuildtools v5_14_00.

## Build procedure

After setting up the prerequisite products, clone the zeromq ups product
repository into your desired source directory `SOURCE_DIR`:
```
git clone https://github.com/sjgardiner/zeromq-ups-build.git SOURCE_DIR
```

Then create a new build directory and source the development setup script from
within it:
```
mkdir build
cd build
source SOURCE_DIR/ups/setup_for_development <-d | -p | -o>
```
The flag after `setup_for_development` should be `-d` if you set up the root
product with the `debug` qualifier, `-p` if you used the `prof` qualifier, or
`-o` if you used the `opt` qualifier.

Choose a directory `INSTALL_DIR` in which you would like to install the zeromq 
ups product. Then build and install the product via
```
buildtool -I "INSTALL_DIR" -bti [-jN]
```
where the optional `-j` flag may be used to build using `N` parallel jobs.
