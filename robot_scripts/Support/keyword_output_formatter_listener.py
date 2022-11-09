from robot.libraries.BuiltIn import BuiltIn
from robot.output.console.highlighting import Highlighter
import sys

class keyword_output_formatter_listener:
	ROBOT_LISTENER_API_VERSION = 2

	def end_keyword(self, name, attributes):
		
		print('')
		writer = Highlighter(sys.__stdout__)
		str = attributes["status"]
		if (str == "PASS"):
			writer.reset()
			writer.green()
			BuiltIn().log_to_console(name, no_newline=True)
			BuiltIn().log_to_console(, no_newline=True)
			print('')
			BuiltIn().log_to_console(attributes["status"],no_newline=False)
		if (str == "FAIL"):
			writer.reset()
			writer.red()
			BuiltIn().log_to_console(name, no_newline=True)
			print('')
			BuiltIn().log_to_console(attributes["status"],no_newline=False)
		if (str == "SKIP"):
			writer.reset()
			writer.yellow()
			BuiltIn().log_to_console(name, no_newline=True)
			print('')
			BuiltIn().log_to_console(attributes["status"],no_newline=False)
