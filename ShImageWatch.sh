#!/bin/sh


############################################################################
# Title: ShImageWatch.sh                                                   
#                                                                          
# Descripton: A linux shell script that monitors a folder for new images   
# and displays them as they are added.                                     
#                                                               
# Author: Jonathan N. Winters, jnw25@cornell.edu                           
# Date:   July 19, 2017
# Version: 0.2
#
# Requirements / Dependencies
# Install  inotify-tools pakage
#     $sudo apt-get install inotify-tools
# Install  imagemagick
#     $sudo apt-get install imagemagick
############################################################################


#resources http://www.imagemagick.org/Usage/anim_basics/

# set your parameters
expected_image_type=".TYPE" #replace the string .TYPE value with .jpg, .gif, or .png

path_to_this_app="/REPLACE/WITH/FULL/PATH/TO/THIS/APP/DIRECTORY/"
path_to_new_images="/REPLACE/WITH/FULL/PATH/TO/LOCATION/OF/INCOMING/IMAGES/"
path_to_past_images="/REPLACE/WITH/FULL/PATH/TO/SPLASH/IMAGE/FILE/"


# sets the path to splash based on the location of this folder
path_to_splash="${path_to_this_app}splash${expected_image_type}"

# generate the path that will be used as the currently displayed file
# note the filename becomes "current" without any extension, this is to handle any file type
path_to_current_image="${path_to_this_app}current${expected_image_type}"

# Copy the splash screen image to the current image location
cp $path_to_splash $path_to_current_image

#display the splash "current" image
display -update 1 $path_to_current_image &

inotifywait -m $path_to_new_images -e create -e moved_to | 
    while read path action file; do
        cp -f $path$file ${path_to_past_images}${file}
        mv -f $path$file $path_to_current_image
        #echo $path$file $path_to_current_image
    done




