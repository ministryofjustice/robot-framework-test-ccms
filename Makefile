
help:
	@echo -- Commands available --
	@echo.
	@echo list                    List all available tasks to run.
	@echo command task/t=^<task^>   Generate a robot command for a task.
	@echo run task/t=^<task^>       Run a task by name.
	@echo variables               Edit variables that are fed into robot framework for different tasks.
	@echo install                 Install dependencies for robot framework.
	@echo report                  Open the html report for the last task run.
	@echo help                    This menu.
	@echo.
	@echo example usage: make run task=search_case

list:
	@echo Listing available tasks:
	@echo.
	@for /F "delims= eol=" %%A IN ('dir /A-D /B robot_scripts\tasks') do echo %%~nA

command:
	@echo robot --variablefile variables.py --task $(task) $(t) robot_scripts

run:
	robot --variablefile variables.py --task $(task) $(t) robot_scripts

variables:
	notepad variables.py

install:
	choco --version

	pip install --user robotframework
	pip install --user robotframework-SikuliLibrary
	pip install --user pyttsx3
	pip install --user robotframework-selenium2library
	pip install --user robotframework-autoitlibrary
	npm install

	cmd /c copy robot_scripts\secrets.robot.template robot_scripts\secrets.robot	
	cmd /c copy variables.py.template variables.py
	cmd /c type nul > cypress.env.json
	echo {} > cypress.env.json

config:
	notepad robot_scripts\secrets.robot
	notepad cypress.env.json

verify:
	systeminfo |find "Memory"
	python --version
	make --version
	choco --version
	python -m robot --version
	robot --version
	cmd /c IEDriverServer.exe --version
	npm --version

	dir cypress.config.js
	dir robot_scripts\secrets.robot
	python variables.py

report:
	cmd /c report.html

update:
	git pull origin main
