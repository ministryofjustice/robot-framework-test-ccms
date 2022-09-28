Introduction
====

EBS automated tasks (RPA) to facilitate testing of EBS using Robot framework utilising SikuliX and AutoIT.

Setup
====
- *Note due to dependency on AutoIT this is only expected to work on Windows OS*
- *Installation has been tested using standard Windows CMD terminal. It is unclear if other ways work*

Download and install Java 8 (tested with 1.8.0_202).    
Download and install Python 3 (tested with 3.10).    
Download and install AutoIt (tested with 3.3.16.0).   
Download and install SikuliX (tested with 2.0.5).
Download and install 32 bit IEDriverServer.exe (tested with 4.3.0.0 for IE version 1607)

Please include the IEDriverServer.exe in your PATH environment variable.

Use pip to install the following Python packages:

```
pip install --user robotframework
pip install --user robotframework-SikuliLibrary
pip install --user pyttsx3
pip install --user robotframework-selenium2library
```

As administrator
  
```
pip install --user robotframework-autoitlibrary
```

Use any editor of choice to edit .robot files.

Copy the `robot_scripts/secrets.robot.template` file to `robot_scripts/secrets.robot` and fill in details. Note Robot Framework enforces 2 spaces after each keyword. Values are assigned in the file like this:

```
${login_username}  TEST_USER1
${login_password}  abc123
```

Running a script
====
If the robot executable is included in your path, run as follows:

```
robot --task search_for_case robot_scripts
```
Otherwise can use the below:

```
python -m robot --task search_for_case robot_scripts
```
Running script using MakeFile
====
If we want to use Makefile to run the scripts, please follow as below.

1. Install the chocolatey package manager for Windows

2. Run choco install make
3. command "make" in commmand promt will trigger the tests


Development
=====

The scripts are meant to be modular i.e this is not an automation suite that can continuously to validate EBS, but a set of automated scripts to facilitate with EBS tasks.

VsCode has great support for Robot Framework. You may also use Robot IDE (RIDE) or any other editor for this project.

Find the files in the robot_scripts folder. Script name starting with 'task' are meant to be run to achieve that task. The browser is then left open for follow up manual actions by the user.

For Sikuli OCR use Windows 'Snipping Tool' to take images of the screen you want to use in your scripts.
