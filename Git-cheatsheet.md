# Git CheatSheet

We use git to version control (save) our changes. This allows everyone to receive the latest changes that have been agreed by everyone. Here is a simple cheatsheet to follow to save your changes.

### Pushing your changes

```
git checkout -b <branch_name>
git status
git add <file>
git commit -m "<message>"
git push origin <branch_name>
```

Substitutions:

`<branch_name>` a name of your choosing

`<file>` The file you want to add and stage for commit

`<message>` The message describing the changes you've made

Now head over to github.com to raise a pull request https://github.com/ministryofjustice/robot-framework-test-ccms. You'll see a yellow message asking you if you'd like to.

Click on "Compare & Pull Request" against your branch. On the next screen, add details of what your changes were and then click on "Create pull request button". This is now ready to be revieved by someone who can comment and approve the pull request.

Action: Someone else needs to review your request. Fling it in chat or ask in stand ups if someone is there to review.

They would review, and either approve or ask for changes. This is done by going into the files tab, and clicking on review button. To leave comments and feedback, you can click on the line and leave comments.

### Once approved

Once approved, Go to the pull request on Github.com and click on Merge. This will merge your changes into main and everyone will now be using it as part of the main software distribution. At this stage, it is safe to delete your branch (Standard practice is to delete your branch once merged in, it can be recovered later if you need it).

### To pull changes

```
git checkout main
git pull origin main
```

An Example
===

I have made changes to a file `robot_scripts/Tasks/login.robot` and `robot_scripts/Support/ebs_helper.robot` file. I'd like to only save changes of the `robot_scripts/Support/ebs_helper.robot` file and NOT `robot_scripts/Tasks/login.robot`.

### On my machine (Save and push changes)
```
# On my machine
git checkout -b update-ebs_helper
git status
git add robot_scripts/Support/ebs_helper.robot
git commit -m "Fixed EBS helper method that identifies window titles"
git push origin update-ebs_helper
```

### On Github.com
1. Raise a pull request
2. Ask someone within the team to review please (Slack/Stand ups).
3. Once approved, merge it in on Github.com and delete the "update-ebs_helper" branch.

### On my machine (Pull changes merged in)
```
git checkout main
git pull origin main
```

### On my machine (Merge changes onto the branch I was working on)
```
git checkout <existing_branch_name>
git merge main
```

Further details
===

Almost all commands come with their own readme. To read about them (how to use, description) execute

```
git <command> --help
```

For example to read about the `git checkout` command execute

```
git checkout --help
```

| Command | Quick Description |
|---------|-----------|
| git checkout | The `git checkout` command above will create a new branch or switch to an existing branch (depends on -b flag) with a branch_name of your choosing to save your work on. This is a little like creating a duplicate file from an existing file to preserve the original file. You usually only need a new branch for the scope of a particular ticket. We don't recommend reusing the same branch as it promotes scoping your changes for the ticket at hand and keeping your changes manageable for reviewing later on. |
| git status | The `git status` command shows you the status of git tracking your work. It will show you the files you've changed, added or deleted. It will also show you the branch you are on, the last commit message reference and bunch of other stuff. Its useful to run this command from time to time to see what you've changed. If you need to see exactly what you've changed within the files, explore the `git diff` command. You can use this command to identify files that you'd like to save, and use the `git add` command accordingly. |
| git add | The `git add` command stages files to be committed i.e you can choose to save particular files and not others. You can add all files in one go by executing `git add .` instead which means add files in the current folder and subfolders.|
| git commit | The `git commit` command is what saves your added files with a reference message and provides you a unique reference to that saving point. You can use this reference to go back to this point at any time. Remember, at this stage, the commit is done your local machine, so others will not be able to see it just yet. |
| git push | The `git push` command is what takes your commits from your local machine to the remote  repository (in our case, Github), publishing your changes for others to see.|
| git pull | The `git pull` command will import changes on your local machine which were previously held on the remote repository. This action is usually performed when new changes are pushed or a pull request has been merged in.|
| pull request |A pull request is a request to merge your changes into the main branch (the main software branch) so everyone can receive your changes as part of main software distribution (standard development practice). This is also a learning opportunity for others as to what changes to expect, and what technical details are involved in your changes. [Github Documentation](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/creating-a-pull-request)|