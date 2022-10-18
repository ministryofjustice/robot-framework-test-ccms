import os
from robot.libraries.BuiltIn import BuiltIn


def get_all_images(image_directory):
    images = []

    directory = os.fsencode(image_directory)
    for image in os.listdir(directory):
        found = False
        imageStr = image.decode('UTF-8')
        if os.path.isfile(os.path.join(image_directory, imageStr)):
            images.append(imageStr)
        elif os.path.isdir(image_directory + imageStr):
            images.extend(get_all_images(image_directory + imageStr))

    return images

def get_all_files(task_directories):
    files = []

    for task_directory in task_directories:
        directory = os.fsencode(task_directory)
        for taskFile in os.listdir(directory):
            taskFileStr = taskFile.decode('UTF-8')
            if taskFileStr.endswith('.robot'):
                filePath = os.path.join(task_directory, taskFileStr)
                files.append(filePath)

    return files

def find_unused_images_in_directory(image_directory, task_directories):
    images = get_all_images(image_directory)
    files = get_all_files(task_directories)

    BuiltIn().log_to_console("Images count: ")
    BuiltIn().log_to_console(len(images))

    BuiltIn().log_to_console("Robot files count: ")
    BuiltIn().log_to_console(len(files))

    count = 0
    for image in images:
        found = False

        for taskFile in files:
            with open(taskFile) as f:
                contents = f.read().lower()
                if contents.find(image.lower()) >= 0:
                    found = True
                    break

        if found == False:
            BuiltIn().log_to_console("Unused image: " + image)
            count+=1

    BuiltIn().log_to_console("Unused image count: " + str(count) + " (" + str(round(count/len(images)*100)) + "%)")