*** Settings ***
Library     ../Support/find_in_files.py

*** Tasks ***
Flag Unused Images
    find_in_files.find_unused_images_in_directory  robot_scripts/Images/  robot_scripts/tasks/
