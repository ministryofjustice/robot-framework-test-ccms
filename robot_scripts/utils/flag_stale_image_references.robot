*** Settings ***
Library     ../Support/find_in_files.py

*** Variables ***
@{directories_to_scan}  robot_scripts/PageObjects  robot_scripts/Support  robot_scripts/tasks  robot_scripts
${images_directory}  robot_scripts\\Images

*** Tasks ***
Flag Stale Image References
    [Documentation]  Find .PNG filenames listed in robot files that don't have corresponding
    ...              files within the img directory. Ignores case.
    find_in_files.Find Stale Image References  ${images_directory}  ${directories_to_scan}
