from robot.libraries.BuiltIn import BuiltIn
from robot.output.console.highlighting import Highlighter
import sys

class keyword_output_formatter_listener:
	ROBOT_LISTENER_API_VERSION = 2

	def end_keyword(self, name, attributes):
		BuiltIn().log_to_console(name)
		writer = Highlighter(sys.__stdout__)
		writer.red()
		BuiltIn().log_to_console("Green  Green  Green")
		writer.reset()
		BuiltIn().log_to_console(attributes["status"])
		BuiltIn().log_to_console("------")
