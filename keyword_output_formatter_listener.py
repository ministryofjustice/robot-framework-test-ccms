from robot.libraries.BuiltIn import BuiltIn
from robot.output.console.highlighting import Highlighter
from variables import *
import sys

class keyword_output_formatter_listener:
    ROBOT_LISTENER_API_VERSION = 2

    def end_keyword(self, name, attributes):
        if not 'keyword_output' in globals() or not keyword_output:
            return

        if self.is_excluded_keyword(
            attributes['type'],
            attributes['kwname'],
            attributes['source'],
            expose_keywords_where_in_path,
            exlcude_keywords
        ):
            return

        writer = Highlighter(sys.__stdout__)

        if attributes['status'] == 'PASS':
            writer.green()
        elif attributes['status'] == 'FAIL':
            writer.red()
        elif attributes['status'] == 'WARN':
            writer.yellow()
        else:
            writer._set_colors(dull_cyan)

        if self.is_special_keyword(attributes['source'], highlight_especially_in_path):
            writer._set_colors(highlight_special)

        self.newline()
        self.log(name, no_newline=True)
        self.log_keyword_args(attributes['args'])
        self.log_path_of_keyword(writer, output_file_path, attributes['status'], attributes['source'], attributes['lineno'])
        self.newline()

        writer.reset()

    def log_keyword_args(self, args):
        if len(args) > 0:
            self.log(' ' + str(args), no_newline=True)

    def log_path_of_keyword(self, writer, output_file_path, status, source, lineno):
        if output_file_path == 'all' or (output_file_path == 'fail_only' and status == 'FAIL'):
            writer._set_colors(grey)
            self.log(' ('+str(source) + ':' + str(lineno) + ')', no_newline=True)

    def is_special_keyword(self, keyword_path, highlight_especially_in_path):
        if str(keyword_path).find(highlight_especially_in_path) != -1:
            return True

        return False

    def is_excluded_keyword(self, type, kwname, keyword_path, expose_keywords_where_in_path, exlcude_keywords):
        exclude = True
        if type != 'KEYWORD' or kwname in exlcude_keywords:
            return exclude

        for folder in expose_keywords_where_in_path:
            if str(keyword_path).find(folder) >= 0:
                exclude = False
                break

        return exclude

    def log(self, message, no_newline=False):
        BuiltIn().log_to_console(message, no_newline=no_newline)

    def newline(self):
        BuiltIn().log_to_console('')
