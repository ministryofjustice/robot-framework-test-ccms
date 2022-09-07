Introduction
====

EBS automated tasks (RPA) to facilitate testing of EBS using Robot framework utilising SikuliX and AutoIT.

Setup
====

Download and install Java 8 (tested with 1.8.0_202).
Download and install python 3 (tested with 3.10).
Download and install AutoIt (tested with 3.3.16.0).
Download and install SikuliX (tested with 2.0.5).

```
pip install --user robotframework
pip install --user robotframework-autoitlibrary
pip install --user robotframework-SikuliLibrary
```

Use any editor of choice to edit .robot files.

Copy the `robot_scripts/secrets.robot.template` file to `robot/scripts/secrets.robot` and fill in details. Note Robot Framework enforces 2 spaces after each keyword.

Running a script
====

```
robot <script_path>
```

Development
=====

The scripts are meant to be modular i.e this is not an automation suite that can continuously to validate EBS, but a set of automated scripts to facilitate with EBS tasks.

VsCode has great support for Robot Framework. You may also use Robot IDE (RIDE) or any other editor for this project.

Find the files in the robot_scripts folder. Script name starting with 'task' are meant to be run to achieve that task. The browser is then left open for follow up manual actions by the user.

For Sikuli OCR use Windows 'Snipping Tool' to take images of the screen you want to use in your scripts.
