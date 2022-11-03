from robot.api import logger

class string_utils:
    def cleanse(self, string):
        """
        Remove newlines from a string. Returns a string.
        """
        return string.replace('\n', ' ')

    def stringContains(self, string, subString):
        """
        Check if a string contains a substring. Returns a number.
        """
        if isinstance(string, bytes):
            string = string.decode('utf-8')

        return string.find(subString) != -1

    def addnewline(self,string):
        """
        Appends a newline to a string.
        """
        return string + '\n'
