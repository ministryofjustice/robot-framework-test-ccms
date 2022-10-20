*** Settings ***
Library     ../Support/find_in_files.py

*** Variables ***
@{directories_to_scan}  robot_scripts/PageObjects  robot_scripts/Support  robot_scripts/tasks  robot_scripts
${images_directory}  robot_scripts/Images/

*** Tasks ***
Flag Unused Images
    find_in_files.find_unused_images_in_directory  ${images_directory}  ${directories_to_scan}
