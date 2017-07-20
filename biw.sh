#!/bin/sh

#This is a Work In Progress

###########
# Title: PymageWatch.sh
# Descripton: A linux shell script that monitors a folder for new images and displays them as they are added.
# Author: Jonathan N. Winters, Jonathan@Winters.im
# Date:   July 19, 2017
# Version: 0.1
#
# Requirements / Dependencies
# Install  inotify-tools pakage
#     $sudo apt-get install inotify-tools
# Install  imagemagick
#     $sudo apt-get install imagemagick
#

#resources http://www.imagemagick.org/Usage/anim_basics/

# set your parameters
path_to_app="/REPLACE/WITH/FULL/PATH/TO/THIS/APP/DIRECTORY"  #next iteration use ${BASH_SOURCE[0]}
path_to_images="/REPLACE/WITH/FULL/PATH/TO/IMAGES/DIRECTORY"
path_to_splash="/REPLACE/WITH/FULL/PATH/TO/SPLASH/IMAGE/FILE"

# generate the path that will be used as the currently displayed file
path_to_current_image="${path_to_app}/current"

# Copy the  splash screen image to the current image location
cp ${path_to_splash} ${path_to_current_image}
display -update 1 $path_to_current_image &

inotifywait -m $path_to_images -e create -e moved_to | 
    while read path action file; do

        #rename new image to current.jpg
        echo "HelloWorld $file"
        #rm $path_to_current_image
        cp -f $path$file ${path}displayed${file}
        mv -f $path$file $path_to_current_image
        echo $path$file $path_to_current_image
    done




