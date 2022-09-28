.PHONY: test


test: ## run robotframework tests
		python -m robot --task  search_for_case  robot_scripts