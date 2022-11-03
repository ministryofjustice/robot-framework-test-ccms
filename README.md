Introduction
====

EBS automated tasks (RPA) to facilitate testing of EBS using Robot framework utilising SikuliX and AutoIT.

Issues
====

Had an issue? Chances are the solution is already logged here https://dsdmoj.atlassian.net/wiki/spaces/LAA/pages/4175626273/Common+Issues+Log. If not, please log it.

Other guides
====

[The EBS Robot Framework Documentation](https://ministryofjustice.github.io/robot-framework-test-ccms/Documentation/index.html)

[Coding Standards For This CodeBase](Coding-Standards.md)

[Sikuli Screenshot Guide](Sikuli-Screenshot-Guide.md)

[Robot Core Libraries Keywords Guide](https://robotframework.org/robotframework/)

[Sikuli Keywords Guide](https://rainmanwy.github.io/robotframework-SikuliLibrary/doc/SikuliLibrary.html)

[Selenium Keywords Guide](https://robotframework.org/SeleniumLibrary/SeleniumLibrary.html)

[Sikuli Python Library Guide](http://doc.sikuli.org/index.html)

[AutoIt Special Keys](https://www.autoitscript.com/autoit3/docs/functions/Send.htm)

AutoIt Library Keywords Guide (AutoIt must be installed): C:\RobotFramework\Extensions\AutoItLibrary\AutoItLibrary.html

FAQs
====

<details>
  <summary>How to click on different elements?</summary>

  ### Click on EBS elements.
  Clicking on EBS elements is done in two ways.
  1. Matching on the image of the element and clicking on that.

  ```robot
    Click On  ${button_image}
  ```

  1. Pressing a shortcut key to activate the functionality.
  ```
    Press Shortcut Keys  ${button_shortcut_keys}
  ```
</details>

<details>
  <summary>How to fill in text fields?</summary>

  You can fill in text using this keyword.
  ```robot
    Input Text Until Appears   ${input_text_image}   hello I am the text to fill in.
  ```

</details>

<details>
  <summary>How to press shortcuts?</summary>

  Use the following keyword:
  ```robot
      Press Shortcut Keys   ${shortcut_keys}
  ```
  Note, if you need to press special keys (autoit based), these are documented here: https://www.autoitscript.com/autoit3/docs/functions/Send.htm
</details>

<details>
  <summary>How to verify the current screen window?</summary>

  To verify which window you're on, you can use one of the following
  ```robot
      Image With Text Exists On Screen  ${img}  ${text}
      Window With Title Exists  ${title}
      Wait Until Screen Contains  {image}
      Wait Until Screen Contains With Text  ${image}  ${text}
  ```

</details>

<details>
  <summary>How to verify screen text content?</summary>

  If you have a situation where you need to verify content that is generated dynamically and the
  image cannot be captured before hand, you can capture a region around it and extend it
  to capture the contents like so:
  ```robot
      ${extended_image}=  Get Extended Region From Image  ${region}  right  2
      ${text}=            Get Text From Image Matching  ${extended_image}
      Should Be Equal   ${text}   Hello I should be on the screen
  ```

</details>

<details>
  <summary>How to add a new image to our framework?</summary>

  If you've snipped a new image for Sikuli, this should go in the robot_scripts/Images folder. Guidance on how to take a snippet can be found [here](Sikuli-Screenshot-Guide.md).

</details>

<details>
  <summary>How to read text from the screen?</summary>

  To read text off of EBS screens, you'll have to specify the region where the text is. This can be done in a few ways:
  ```robot
  ${coordinates}	Create List 	x	y	w	h
  ${region_image}=  Capture Region   ${coordinates}
  ```

  or

  ```robot
  ${region_image}=  Get Extended Region From Image  ${image}  top   3
  ```

  The above will extend the image region to the top 3 times the height of the image you've provided.

  This region should span over your text that you'd like to read. Now use the following keyword to
  read the text within this region:

  ```robot
  ${text}=  Get Text  ${region_image}
  ```

</details>

Setup
====
- *Note due to dependency on AutoIT this is only expected to work on Windows OS*
- *Installation has been tested using standard Windows CMD terminal. It is unclear if other ways work*
- *Install using choco found here https://chocolatey.org/install#individual.

Quick install (AWS workspace):
====

*Note: You need to be setup with access to the github repository.

Dependencies install:

```cmd
choco install make
choco install git
git clone git@github.com:ministryofjustice/robot-framework-test-ccms.git
cd robot-framework-test-ccms.git && make -i install-dependencies
```

To proceed with installing robot framework and its dependencies, run the following commands:

```cmd
make install
make config
```

The last command will open a config file for you to fill:

- secrets.robot

Note Robot Framework enforces 2 spaces after each keyword. Values are assigned in the file like this:

```robot
# example: robot_scripts/secrets.robot

${login_username}  TEST_USER1
${login_password}  abc123
```

```robot
# Creds for Apply case submission example: robot_scripts/secrets.robot

${apply_username}  username
${apply_password}  password

```

Verify your installation
====

```cmd
make -i verify
```

Step by step
====

Download and install Java 8 (tested with 1.8.0_251).    
Download and install Python 3 (tested with 3.10).
Download and install 32 bit IEDriverServer.exe (tested with 4.3.0.0 for IE version 1607)

Please include the IEDriverServer.exe in your PATH environment variable.

Use pip to install the following Python packages:

```cmd
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

Generating/Updating Documentation
======

To generate documentation, run the following command:

```
make documentation
```

Note that this will only create documentation for keywords, to edit the index files please look in the Documentation folder.
