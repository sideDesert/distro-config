#!/bin/bash

path=$(swww query | grep image | awk '{ print $NF }')
path1=$(echo $path | awk '{ print $1 }')

echo $path1

matugen image "$path1"
