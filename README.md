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

Download and install Java 8 (tested with 1.8.0_202).    
Download and install Python 3 (tested with 3.10).    
Download and install AutoIt (tested with 3.3.16.0).   
Download and install SikuliX (tested with 2.0.5).
Download and install 32 bit IEDriverServer.exe (tested with 4.3.0.0 for IE version 1607)
Download and install npm (node v16)

Please include the IEDriverServer.exe in your PATH environment variable.

Quick install:
====

```
choco install make
make install
```

Open the `robot_scripts/secrets.robot` and fill in details. Note Robot Framework enforces 2 spaces after each keyword. Values are assigned in the file like this:

```
${login_username}  TEST_USER1
${login_password}  abc123
```

Open file `cypress.env.json` in the project root directory and record username, password and URL for Apply in format as below:

```
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

```
make list
make run task=<task name from above command>
```

Raw version:

robot --task <task name> robot_scripts

Development
=====

The scripts are meant to be modular i.e this is not an automation suite that can continuously to validate EBS, but a set of automated scripts to facilitate with EBS tasks.

VsCode has great support for Robot Framework. You may also use Robot IDE (RIDE) or any other editor for this project.

Find the files in the robot_scripts folder. Script name starting with 'task' are meant to be run to achieve that task. The browser is then left open for follow up manual actions by the user.

For Sikuli OCR use Windows 'Snipping Tool' to take images of the screen you want to use in your scripts.
