Introduction
====

EBS automated tasks (RPA) to facilitate testing of EBS using Robot framework utilising SikuliX and AutoIT.

Issues
====

Had an issue? Chances are the solution is already logged here https://dsdmoj.atlassian.net/wiki/spaces/LAA/pages/4175626273/Common+Issues+Log. If not, please log it.

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

The last command will open 2 config files for you to fill:

- secrets.robot
- cypress.env.json

Note Robot Framework enforces 2 spaces after each keyword. Values are assigned in the file like this:

```
# example: robot_scripts/secrets.robot

${login_username}  TEST_USER1
${login_password}  abc123
```

```
# example: cypress.env.json

{
  "APPLY_USERNAME": "username",
  "APPLY_PASSWORD": "password",
  "APPLY_URL": "https://main-applyforlegalaid-uat.cloud-platform.service.justice.gov.uk/"
}
```

This should automatically be picked up by Cypress, whether run via Robot Framework or run directly.

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
Download and install npm (node v16)

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

### Cypress Setup (for case creation in Apply)
Download and install install **npm** (and nodejs too?)

Install Google Chrome (script has failed with Cypress electron browser emulation)

Install Cypress by running the below in the project top directory (this uses details already in `package.json`). 

```
npm install
```

Running a script
====

For a list of commands:

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
