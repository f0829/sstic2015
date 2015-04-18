#!/bin/bash

input_file=$1

avconv -i $input_file -c:v libx264 -acodec null -filter:v "setpts=0.75*PTS,scale=640:-1" -movflags +faststart videos/demo.mp4
avconv -i $input_file -c:v libvpx-vp9 -acodec null -filter:v "setpts=0.75*PTS,scale=640:-1" -b:v 1300K -threads auto videos/demo.webm
