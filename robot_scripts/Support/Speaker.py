import pyttsx3

class Speaker:
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