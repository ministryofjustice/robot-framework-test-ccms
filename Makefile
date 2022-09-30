all: case-search means-merits
case-search: ## run case search
		python -m robot --task Search_For_Case  robot_scripts

means-merits: ## run means and merits assessment
		python -m robot --task  Propagate_Case_Status  robot_scripts
