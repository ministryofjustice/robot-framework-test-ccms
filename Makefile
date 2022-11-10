help:
	@echo -- Commands available --
	@echo.
	@echo list                         List all available tasks to run.
	@echo command task/t=^<task^>        Generate a robot command for a task.
	@echo run task/t=^<task^>            Run a task by name.
	@echo variables                    Re-create the variables file from the existing template.
	@echo edit-variables               Edit variables that are fed into robot framework for different tasks.
	@echo install-dependencies         Install software dependencies for this project (Elevated CMD).
	@echo install                      Install dependencies for robot framework.
	@echo view-report                  Open the html report for the last task run.
	@echo find-stale-images            Will list stale images.
	@echo find-stale-image-references  Will list stale image references.
	@echo lint                         Lints all robot files.
	@echo activate-pre-commit-hook     Activate automatic checks before commit.
	@echo documentation                Regenerate documentation for all keywords.
	@echo env-variables                Open the Windows environment variables dialogue for configuration.
	@echo help                         This menu.
	@echo.
	@echo example usage: make run task=search_case

e2e:
	$(MAKE) run task=create_a_case
	echo case_reference = '%case_reference%' > variables.py
	$(MAKE) run task=search_case  $case_reference
	$(MAKE) run task=propagate_case_status

list:
	@echo Listing available tasks:
	@echo.
	@for /F "delims= eol=" %%A IN ('dir /A-D /B robot_scripts\Tasks\*.robot') do echo %%~nA

command:
	@echo robot --variablefile variables.py --outputdir results --task $(task) $(t) robot_scripts

run:
	robot --variablefile variables.py --outputdir results --listener keyword_output_formatter_listener.py --console verbose  --task $(task) $(t) robot_scripts

edit-variables:
	notepad variables.py

variables:
	cmd /c copy variables.py.template variables.py

activate-pre-commit-hook:
	copy helpers\pre-commit .git\hooks\pre-commit

find-stale-images:
	@robot --output NONE --report NONE --log NONE robot_scripts\Utils\flag_unused_images.robot

.PHONY: documentation
documentation:
	rmdir /Q /S Documentation\Support
	python robot_scripts\Utils\generate_library_documentation.py -i robot_scripts\\Support -o Documentation\\Support
	rmdir /Q /S Documentation\PageObjects
	python robot_scripts\Utils\generate_library_documentation.py -i robot_scripts\\PageObjects -o Documentation\\PageObjects

find-stale-image-references:
	@robot --output NONE --report NONE --log NONE robot_scripts\utils\flag_stale_image_references.robot

lint:
	python -m rflint -A helpers\rflint-arguments-file -r robot_scripts

install-dependencies:
	@echo -- The following software will be installed on your machine:
	@echo.
	@echo python@3.10.6
	@echo java 8.0.251
	@echo IEDriverServer@4.3.0.0
	@echo.
	@echo You can choose to install them or not one by one.
	@echo.
	@pause

	@echo.
	@echo Installing python:
	powershell -Command "Start-Process cmd \"/c choco install python --version=3.10.6 & pause \" -Verb RunAs"
	@pause

	@echo.
	@echo Installing java:
	where java
	java -version
	cmd /c start p:\TAP_Files\Installers\jdk-8u251-windows-x64.exe
	@pause

	@echo.
	@echo Setting up IEDriverServer:
	mkdir %USERPROFILE%\projects\IEDriverServer
	copy "p:\TAP_Files\Installers\Webdrivers\IEDriverServer.exe" "%USERPROFILE%\projects\IEDriverServer"
	@pause

	@echo.
	@echo -- Add the following to your PATH variable and move them up in the list:
	@echo "%USERPROFILE%\AppData\Roaming\Python\Python310\Scripts"
	@echo "%USERPROFILE%\projects\IEDriverServer"
	@echo.

	$(MAKE) env-variables

install:
	choco --version

	pip install --user robotframework==5.0.1
	pip install --user robotframework-SikuliLibrary==2.0.3
	pip install --user pyttsx3==2.90
	pip install --user robotframework-selenium2library==3.0.0
	powershell -Command "Start-Process cmd \"/c pip install --user robotframework-autoitlibrary==1.2.8 & pause \" -Verb RunAs"

	cmd /c copy robot_scripts\secrets.robot.template robot_scripts\secrets.robot
	cmd /c copy variables.py.template variables.py

	@echo.
	@echo Add the robot.exe directory path to the PATH variables:
	pip show robotframework

	$(MAKE) refresh

refresh:
	@refreshenv

env-variables:
	@rundll32 sysdm.cpl,EditEnvironmentVariables
	$(MAKE) refresh

edit-config:
	notepad robot_scripts\secrets.robot

config:
	cmd /c copy robot_scripts\secrets.robot.template robot_scripts\secrets.robot

verify:
	systeminfo |find "Memory"
	@echo.
	python --version
	@echo.
	make --version
	@echo.
	choco --version
	@echo.
	python -m robot --version
	@echo.
	robot --version
	@echo.
	cmd /c IEDriverServer.exe --version
	@echo.
	java -version
	where java
	@echo.

	@echo.
	dir robot_scripts\secrets.robot
	@echo.
	python variables.py
	@echo.

view-report:
	cmd /c results\report.html

update:
	git pull origin main
