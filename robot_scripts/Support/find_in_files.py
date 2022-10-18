import os
from robot.libraries.BuiltIn import BuiltIn

def find_unused_images_in_directory(image_directory, task_directory):
    directory = os.fsencode(image_directory)
    for image in os.listdir(directory):
        found = False
        # BuiltIn().log_to_console(image)
        imageStr = image.decode('UTF-8')

        directory = os.fsencode(task_directory)
        for taskFile in os.listdir(directory):
            BuiltIn().log_to_console(taskFile)
            taskFileStr = taskFile.decode('UTF-8')
            if taskFileStr.endswith('.robot'):
                with open(os.path.join(task_directory, taskFileStr)) as f:
                    if imageStr.lower() in f.read().lower():
                        # Found the image referenced in a file, skip for image.
                        found = True
                        continue

        if found == False:
            BuiltIn().log_to_console("Unused image: " + imageStr)
