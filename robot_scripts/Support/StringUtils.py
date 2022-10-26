from robot.api import logger

class StringUtils:
    def cleanse(self, string):
        return string.replace('\n', ' ')
    
    def stringContains(self, string, subString):
        if isinstance(string, bytes):
            string = string.decode('utf-8')

        return string.find(subString) != -1

    def addnewline(self,string):
        return string + '\n'