#!/bin/bash

# Vrsi se generisanje oba izvrsna objekta, za izvrsavanje na razvojnoj masini, kao i RPI!
make clean
make
scp program root@192.168.23.200:/home/root/team3

