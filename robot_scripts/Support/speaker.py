import pyttsx3
from robot.libraries.BuiltIn import BuiltIn

class speaker:
    def say(self, text):
        narrator = pyttsx3.init()

        # Optional voice setting - male or female 0 or 1
        voices = narrator.getProperty('voices')
        narrator.setProperty('voice', voices[0].id)

        # Optional but fun - can set the speed
        narrator.setProperty('rate', 200)

        # These just queue things up
        narrator.say(text)
        # Need to do the below to produce the sound
        narrator.runAndWait()

        narrator.stop()

    def say_if_human(self, text):
        """ Works out if task is being executed by human or machine based on the setting EXECUTION_MODE."""

        mode = BuiltIn().get_variable_value("${EXECUTION_MODE}")

        if (mode == 'Human'):
            self.say(text)
