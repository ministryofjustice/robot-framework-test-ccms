Introduction
====

EBS automated tasks (RPA) to facilitate testing of EBS using Robot framework utilising SikuliX and AutoIT.

Issues
====

Had an issue? Chances are the solution is already logged here https://dsdmoj.atlassian.net/wiki/spaces/LAA/pages/4175626273/Common+Issues+Log. If not, please log it.

Other guides
====

[Coding Standards For This CodeBase](Coding-Standards.md)

[Sikuli Screenshot Guide](Sikuli-Screenshot-Guide.md)

[Robot Builtin Keywords Guide](https://robotframework.org/robotframework/latest/libraries/BuiltIn.html)

[Sikuli Keywords Guide](https://rainmanwy.github.io/robotframework-SikuliLibrary/doc/SikuliLibrary.html)

[Selenium Keywords Guide](https://robotframework.org/SeleniumLibrary/SeleniumLibrary.html)

[Sikuli Python Library Guide](http://doc.sikuli.org/index.html)

Setup
====
- *Note due to dependency on AutoIT this is only expected to work on Windows OS*
- *Installation has been tested using standard Windows CMD terminal. It is unclear if other ways work*
- *Install using choco found here https://chocolatey.org/install#individual.

Quick install (AWS workspace):
====

*Note: You need to be setup with access to the github repository.

Dependencies install:

```
choco install make
choco install git
git clone git@github.com:ministryofjustice/robot-framework-test-ccms.git
cd robot-framework-test-ccms.git && make -i install-dependencies
```

To proceed with installing robot framework and its dependencies, run the following commands:

```
make install
make config
```

The last command will open a config file for you to fill:

- secrets.robot

Note Robot Framework enforces 2 spaces after each keyword. Values are assigned in the file like this:

```
# example: robot_scripts/secrets.robot

${login_username}  TEST_USER1
${login_password}  abc123
```

```
# Creds for Apply case submission example: robot_scripts/secrets.robot

${apply_username}  username
${apply_password}  password

```

Verify your installation
====

```
make -i verify
```

Step by step
====

Download and install Java 8 (tested with 1.8.0_251).    
Download and install Python 3 (tested with 3.10).
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

Running a script
====

For a list of tasks:

```
make list
```

To run a task:

```
make run task=<task name from above command>
```

For all commands available:

```
make help
```

Raw version:

```
robot --task <task name> robot_scripts
```

Development
=====

The scripts are meant to be modular i.e this is not an automation suite that can continuously to validate EBS, but a set of automated scripts to facilitate with EBS tasks.

VsCode has great support for Robot Framework. You may also use Robot IDE (RIDE) or any other editor for this project.

Find the files in the robot_scripts folder. Script name starting with 'task' are meant to be run to achieve that task. The browser is then left open for follow up manual actions by the user.

For Sikuli OCR use Windows 'Snipping Tool' to take images of the screen you want to use in your scripts.

To further aid development, install the robotframework linter. (Note: If you've installed robot using the make install command you may already have this).

```
pip install --upgrade --user robotframework-lint
```

Activate automated runs before git commit using this command:

```
make activate-pre-commit-hook
```