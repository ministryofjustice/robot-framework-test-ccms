Git CheatSheet
---

We use git to version control (save) our changes. This allows everyone to receive the latest changes that have been agreed by everyone. Here is a simple cheatsheet to follow to save your changes.

```
git checkout -b <branch_name>
git add <file>
git commit -m "<message>"
git push origin <branch>
```

Now head over to github.com to raise a pull request https://github.com/ministryofjustice/robot-framework-test-ccms. You'll see a yellow message asking you if you'd like to.



Further details
---

Checkout command
---

The `git checkout` command above will create a new branch for you to save your work on. We do not recommend saving your changes to the main branch.


Pull request
---

A pull request is a request to merge your changes into the main branch (the main software branch) so everyone can receive your changes as part of main (standard development practice).

Read more here

https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/creating-a-pull-request