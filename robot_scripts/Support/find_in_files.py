import os, glob
from robot.libraries.BuiltIn import BuiltIn

def get_all_images(image_directory):
    images = {}

    directory = os.path.join(os.getcwd(), image_directory, "**", "*.png")
    for qualified_path in glob.glob(directory, recursive=True):
        image_str = os.path.basename(qualified_path)
        if os.path.isfile(qualified_path):
            images[image_str] = qualified_path 
        elif os.path.isdir(qualified_path):
            images = images | get_all_images(qualified_path)

    return images

def get_all_files(task_directories):
    files = []

    for task_directory in task_directories:
        directory = os.fsencode(task_directory)
        for task_file in os.listdir(directory):
            task_file_str = task_file.decode('UTF-8')
            if task_file_str.endswith('.robot'):
                file_path = os.path.join(task_directory, task_file_str)
                files.append(file_path)

    return files

def find_unused_images_in_directory(image_directory, task_directories):
    images = get_all_images(image_directory)
    files = get_all_files(task_directories)

    BuiltIn().log_to_console(images)

    BuiltIn().log_to_console(" ")
    BuiltIn().log_to_console("Images count: ")
    BuiltIn().log_to_console(len(images))

    BuiltIn().log_to_console("Robot files count: ")
    BuiltIn().log_to_console(len(files))

    count = 0
    for image_name, image_path in images.items():
        found = False

        for task_file in files:
            with open(task_file) as f:
                contents = f.read().lower()
                if contents.find(image_name.lower()) >= 0:
                    found = True
                    break

        if found == False:
            BuiltIn().log_to_console("Unused image: " + image_path)
            count+=1

    BuiltIn().log_to_console("Unused image count: " + str(count) + " (" + str(round(count/len(images)*100)) + "%)")