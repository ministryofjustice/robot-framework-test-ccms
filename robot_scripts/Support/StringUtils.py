from robot.api import logger
import datetime
import re

class StringUtils:
    def cleanse(self, string):
        return string.replace('\n', ' ')
    
    def stringContains(self, string, subString):
        if isinstance(string, bytes):
            string = string.decode('utf-8')

        return string.find(subString) != -1

    def adddatetime(self,string):
        today = datetime.datetime.now()
        date_time = today.strftime("%m/%d/%Y, %H:%M:%S")
        return date_time + string.replace('\n', ' ')

    def caseidstr(self, string):
        caseidPattern = re.compile(r'\d\d\d\d\d\d\d\d\d\d\d\d')
        str = caseidPattern.search(string)
        return str