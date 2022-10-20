# Coding Standards For Working In Robot Framework

Variables
----
- Give variables descriptive, meaningful names.
- Do we want an agreed name format (currently some snake, some camel)? Also way of highlighting if global/shared (e.g. all caps)?


Task Files
----
- Place task files in the `robot_framework/tasks` directory
- Only have one task per file
- Use snake case filenames with words matching those in the task's name, e.g. a file containing task "**Search For Case**" will have filename  `search_for_case.robot`

Custom Libraries
----

- It is possible to create libraries in either Robot Framework or Python. Either can be 
used for low level library creation but only use Robot Keywords for a higher level visibility, e.g. we don't expect to see Python in task files.
- Library files should **not** be placed directly in the `robot_framework/tasks` directory 
- Keywords of general use can be placed in `common.robot` but take care that it doesn't become overloaded and consider reorganising into separate files if necessary.

Comments
----
- Minimise the need for comments by writing self-explanatory code. Aim to use comments sparsly and where there is a genuine need. 
- Use comments on variables where possible. [????]
- Single line comments are preferred over paraghraphs for readability. Paragraphs are acceptable for documenting a keyword, although `[Documentation]` tags may be prefereable here to plain comments.

### Comments to separate sections of variables
[Not sure what this is about - the \*** Variables \*** section?]

- Sections of varaibles separated by line space.
- On top, images, then shortcuts, input variables or something else.
- Make the special characters for shortcuts a bit more descriptive by givng them names.


General Naming Conventions
----
*Note there are separate rules for the image files used by Sikuli. See Sikuli Image Files further below for details of these*

- Name files with snake case, e.g. `login_caseworker.robot`
- Name folders with Pascal case, e.g. `PageObjects`
- Keywords and Tasks are named the standard Robot way, i.e. words with intial caps, separated by single spaces, and clearly describle the action to be performed, e.g. `Get Case Details`


Sikuli Image Files
----

### Filename and format

- Only use PNG image file format
- Upper-case file extension, `.PNG`
- Pascal case filenames `WordsLikeThis`
- The image name contains `<element type><description>` e.g. `ButtonCancel.PNG`
[Do we wan't this as most of our exsiting images don't conform to this?]

### Image Folder Structure

- General image files go directly in the main image folder, `robot_scripts/Images`
- Images specific to a particular Window, place in sub-folder `<Window Title>`, eg `robot_scripts/Images/UniversalSearch`
- If there's a clash with this format, create sub-folder based on action or process name


To Add???
----
- Use of common.robot
- Use of settings.robot
- hooks
- Image path everywhere.
- Python files in Support?
- Task files should not contain any keyword definitions, only consume keywords
- Say commands? In task files or everywhere?
- Console logs?
- Common issues log format? Problem/screenshot/solution?
- Task files being readable with Given When Then?
- Library and Resource in Settings - preferred order when both used in same file? Have Library first, Resource second.

