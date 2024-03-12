#!/bin/bash
## Clean up old files
echo Clean up old files
rm -f *.o *.mod a.out *.x

## To compile using ifort
echo compile using ifort
echo ifort basics.F90
ifort basics.F90
echo Created a.out.  This is the default
ls -lrth a.out
## This will create a.out.  This is the default

## Run a.out
echo Run a.out
./a.out


## You can name the executable created from compiling by using it -o option to ifort
echo ifort basics.F90 -o mybasics.x
ifort basics.F90 -o mybasics.x
## This will create mybasics.x
echo Created mybasics.x
ls -lrth mybasics.x
echo run mybasics.x
echo ./mybasics.x
## Run mybasics.x
./mybasics.x
