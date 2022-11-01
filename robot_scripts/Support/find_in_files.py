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

    for directory in task_directories:
        robot_filenames = [os.path.join(directory, f) for f in os.listdir(directory) if f.endswith('.robot')] 
        files = files + robot_filenames

    return files

def find_unused_images_in_directory(image_directory, task_directories):
    """
    This method will search the task directories for each image in the image directory by name.
    Note there is a limitation in that the search is done by file name and not path. Duplicate file
    names will therefor not be reported but will be picked up by subsequent calls once the stale images
    are removed.
    """
    images = get_all_images(image_directory)
    files = get_all_files(task_directories)

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

def find_filename_references_in_file(filename, extension=".PNG"):
    """
    Search each line of file for filenames with the given extension.
    Return dictionary with found filenames as keys and list of line numbers where found 
    as values. 
    e.g. If we have a file with "one.png" in line 1, "one.png" also twice in line 2, and 
    "two.PNG" in line 7, then get: {'one.png': [1, 2, 2], 'two.PNG': [7]}
    """
    results = {}
    with open(filename) as exam_file:
        for lindex, line in enumerate(exam_file):
            filenames = [e for e in line.split() if e.upper().endswith(extension)]
            if filenames:
                for filename in filenames:
                    line_number = lindex + 1
                    if filename not in results:         
                        results[filename] = [line_number]
                    else:
                        results[filename].append(line_number)
    return results

def find_filename_references_in_multiple_files(task_directories, extension="PNG"):
    """
    Find all robot files, in each one look for references to filenames with particular extension.
    Provide details of line numbers in each file where reference found by returning dictionary
    with this structure
    {
     image_filename1: {robot_filename1: [line numbers], robot_filename2: [line_numbers]},
     image_filename2: {robot_filename1: [line numbers], robot_filename3: [line_numbers]},
     image_filename3: {robot_filename4}: [line numbers]}
     }
    But exclude robot_filenames where no
    """
    image_file_references = {}
    robot_filenames = get_all_files(task_directories)
    for robot_filename in robot_filenames:
        file_results = find_filename_references_in_file(robot_filename, extension)
        for image_filename in file_results:
            if image_filename not in image_file_references:
                image_file_references[image_filename] = {robot_filename: file_results[image_filename]}
            else:
                image_file_references[image_filename][robot_filename] = file_results[image_filename]
    return image_file_references


def find_stale_image_references(image_directory, task_directories):
    image_file_references = find_filename_references_in_multiple_files(task_directories)
    images = get_all_images(image_directory)
    lower_case_images = [i.lower() for i in images.keys()]
    for image_reference in image_file_references:
        if image_reference.lower() not in lower_case_images:
            print(f"Reference Filename: {image_reference}", image_file_references[image_reference])
    return images, image_file_references


if __name__ == "__main__":
    #results = find_filename_references_in_multiple_files(["../PageObjects", "../Support"])
    img, ifr = find_stale_image_references("../Images", ["../PageObjects", "../Support"])
    #images = get_all_images("../Images")
