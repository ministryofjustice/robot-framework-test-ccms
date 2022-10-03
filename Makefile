
help:
	@echo -- Commands available --
	@echo.
	@echo list                    List all available tasks to run.
	@echo command task/t=^<task^>   Generate a robot command for a task.
	@echo run task/t=^<task^>       Run a task by name.
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
	@echo robot --task $(task) $(t) robot_scripts

run:
	robot --task $(task) $(t) robot_scripts

install:
	choco --version

	pip install --user robotframework
	pip install --user robotframework-SikuliLibrary
	pip install --user pyttsx3
	pip install --user robotframework-selenium2library
	pip install --user robotframework-autoitlibrary
	npm install

	cmd /c copy robot_scripts\secrets.robot.template robot_scripts\secrets.robot
	cmd /c type nul > cypress.env.json
	echo {} > cypress.env.json

	cmd /c robot_scripts\secrets.robot
	cmd /c cypress.env.json

verify:
	python --version
	make --version
	choco --version
	python -m robot --version
	robot --version
	cmd /c IEDriverServer.exe --version
	npm --version

	dir cypress.config.js
	dir robot_scripts\secrets.robot

report:
	cmd /c report.html

update:
	git pull origin main
