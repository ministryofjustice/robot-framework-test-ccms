from robot.libraries.BuiltIn import BuiltIn
from robot.output.console.highlighting import Highlighter
import sys

class keyword_output_formatter_listener:
	ROBOT_LISTENER_API_VERSION = 2

	grey = 0x8
	dull_cyan = 0x3
	blue = 0x9
	purple = 0x5

	# The color for special highlighting.
	highlight_special = purple
	# Exlcude the following keywords where ever they appear.
	exlcude_keywords = ['Log', 'LogV', 'Log To Console', 'Say']
	# None is used for Hooks.
	expose_keywords_where_in_path = ['PageObjects', 'Tasks']
	# The keywords that exist in this path will be highlighted especially.
	highlight_especially_in_path = 'Tasks'

	def end_keyword(self, name, attributes):
		if attributes['type'] != 'KEYWORD' or attributes['kwname'] in self.exlcude_keywords:
			return

		# Exclude reporting on keywords that are not in the defined folders.
		allow = False
		for folder in self.expose_keywords_where_in_path:
			if str(attributes['source']).find(folder) != -1:
				allow = True
				break

		if not allow:
			return

		writer = Highlighter(sys.__stdout__)

		if attributes['status'] == 'PASS':
			writer.green()
		elif attributes['status'] == 'FAIL':
			writer.red()
		elif attributes['status'] == 'WARN':
			writer.yellow()
		else:
			writer._set_colors(self.dull_cyan)

		# Apply special highlighting.
		if str(attributes['source']).find(self.highlight_especially_in_path) != -1:
			writer._set_colors(self.highlight_special)

		BuiltIn().log_to_console('')
		BuiltIn().log_to_console(name, no_newline=True)

		# If no args, don't display the brackets.
		if len(attributes['args']) > 0:
			BuiltIn().log_to_console(' ' + str(attributes['args']), no_newline=True)

		# Print the path of the keyword.
		writer._set_colors(self.grey)
		BuiltIn().log_to_console(' ('+str(attributes['source'])+')')

		writer.reset()
