from subprocess import check_output

def get_pid(name):
    return check_output(["pidof",name])

def get_process_by_name(name):
    processes = active_children()
    for process in processes:
        print(process)
