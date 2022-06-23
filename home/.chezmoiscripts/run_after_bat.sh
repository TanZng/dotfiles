#!/bin/sh

bat cache --build

[ $? -eq 0 ] && printf "\nBat build update successful" || printf "\nBat build update failed"
