#!/bin/bash

echo $(osx-cpu-temp -cg -F | tr '\n' ' ')
