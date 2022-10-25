# Coding Standards For Working In Robot Framework

By default we follow whatever Robot Framework recommends.


Unresolved Questions
----
- How to use image path variables. May depend on what features sikuli/robot framework provides.

General Naming Conventions
----
*Note there are separate rules for the image files used by Sikuli. See Sikuli Image Files further below for details of these*

- Name files with snake case, e.g. `login_caseworker.robot`
- Name folders with Pascal case, e.g. `PageObjects`
- Keywords and Tasks are named the standard Robot way, i.e. words with intial caps, separated by single spaces, and clearly describle the action to be performed, e.g. `Get Case Details`


Variables
----
- Give variables descriptive, meaningful names.
- Use snake case for variables. Use all caps for global variables.

#### Example
Variable for user name.   
Bad :x: `${Un}`  
Good :white_check_mark: `${user_name}`


Task Files
----
- Place task files in the `robot_scripts/tasks` directory
- Only have one task per file
- Use snake case filenames with words matching those in the task's name, e.g. a file containing task "**Search For Case**" will have filename  `search_for_case.robot`
- Task files should not contain any keyword definitions, only consume keywords
- Given, When, Then's are not consistent with our RPA way of working and therefore not expected to be present.

User Defined Libraries
----

- It is possible to create libraries in either Robot Framework or Python. Either can be 
used for low level library creation but only use Robot Keywords for a higher level visibility, e.g. we don't expect to see Python in task files.
- Library files should **not** be placed directly in the `robot_scripts/tasks` directory 
- Library files should not be more than 250 lines in length.
- When importing libraries and resources, have libraries first, resources second.


Comments
----
- Minimise the need for comments by writing self-explanatory code. Aim to use comments sparsly and where there is a genuine need. 
- Single line comments are preferred over paraghraphs for readability. Paragraphs are acceptable for documenting a keyword, although `[Documentation]` tags may be prefereable here to plain comments.
- Comments should be aligned with the code they relate too, i.e. the same indentation level.
- 1 space between the comment hash symbol and the comment itself.

#### Example

Bad :x:

```
# Locator for OK button
		ok_button_locator =  ${"id:ok"}
```

Good  :white_check_mark: 

```
        # Optional voice setting - male or female 0 or 1
        voices = narrator.getProperty('voices')
        narrator.setProperty('voice', voices[0].id)
```


Robot File \*** Variables \*** section format
----

- Sections of varaibles separated by line space.
- On top, images, then shortcuts, input variables or something else.
- Make the special characters for shortcuts a bit more descriptive by givng them names.

#### Example
```
*** Variables ***
${subject_assess_merits}                 meritsAssessment/MeritCaseDetails.PNG
${toolbar_tools_button}                  meritsAssessment/ToolbarToolsButton.PNG
${toolbar_tools_details_link}            meritsAssessment/ToolbarToolsDetailsLink.PNG
${decision_field_custom_application}     meritsAssessment/DecisionFieldCustomApplication.PNG
${decision_field_proceedings}            meritsAssessment/DecisionFieldProceedings.PNG
${decision_field_costlimit_proceedings}  meansAssessment/costLimitsMeansProceeding.PNG
${cost_limits_button}                    meritsAssessment/CostLimitsButton.PNG
${close_form_button}                     meritsAssessment/CloseFormButton.PNG

${ok_button_shortcut}   !k
${case_reference}
${save_button}   ^s
${ENTER}  {ENTER}
${backspace}  {BACKSPACE}
```

Sikuli Image Files
----

### Filename and format

- Only use PNG image file format
- Upper-case file extension, `.PNG`
- Pascal case filenames `WordsLikeThis`
- The image name contains `<element type><description>` e.g. `ButtonCancel.PNG`

### Image Folder Structure

- General image files go directly in the main image folder, `robot_scripts/Images`
- Images specific to a particular Window, place in sub-folder `<Window Title>`, eg `robot_scripts/Images/UniversalSearch`
- If there's a clash with this format, create sub-folder based on action or process name

Hooks
----
- if creating a new hook, place into `hooks.robot` file
- The name of the keyword should clearly state the event on which the hook will be fired

#### Example

Bad: :x: `Automatic Screenshot`.   
Good: :white_check_mark: `Test Startup Hook`




Say Commands
----
Only include commands that speak in task files or hooks but not in lower level libraries e.g. page objects and support files.

Console Logs
----
OK to use but make sure the output is meaningful.




