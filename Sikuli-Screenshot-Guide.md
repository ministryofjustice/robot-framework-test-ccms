A quick guide to taking screenshots for Sikuli.
=====

Security Note
-----

Please ensure that no sensitive data (personally identifiable information, passwords) is captured in any screenshot you wish to push to the git repository. This can become a security risk for the LAA.


Q) How do I take a screenshot/snapshot of anything on Windows?
----

Windows comes with a handy tool called `Snipping Tool`. Launch and take a snip of what you'd like to match on with Sikuli. Save it in the project folder you're working in (recommended inside the Images folder).

Q) How do you decide on what screenshot to take and for what purpose?
----

- Interact with the element
- Take a screenshot of the element. Ensure that the borders of the element is contained within the screenshot.
- Sikuli will click on the first occurrence of the image if there are multiple. If you have multiple occurrences of something and want to click on a particular one, ensure that you’ve captured a unique surrounding detail around the element within the screenshot.
- Beware of colours that may change from user to user such as themes of a browser - these are likely to fail matching on other peoples machines.

Q) How can I check the presence or absence of content on the screen?
----

Check its presence or absence on the screen, and validate where you are in the journey. Things you can do:

```
Exists   MyImage.png
Screen Should Contain  MyImage.png
Screen Should Not Contain  MyImage.png
Wait Until Screen Contains  MyImage.png
```

Q) How can I read text from a screenshot?
----

Chances are that the text you're trying to read keeps changing and taking a direct screenshot does not serve you well. You can take a screenshot of the area next to the content if that stays the same and is unique enough. You can ask Sikuli to extend its view from that image location in any direction and read the contents of the whole region you've now captured.

```
${region}=  Get Extended Region From Image  ${IMG}  direction=left  10
${text}=  Read Text From Region  ${region}
Log To Console  ${text}
```

Read more about `Get Extended Region From Image` keywords [here](https://rainmanwy.github.io/robotframework-SikuliLibrary/doc/SikuliLibrary.html#Get%20Extended%20Region%20From%20Image).

Note: Check the text before using it in subsequent calls. You may get special characters which can cause issues. If using text in comparisons, using a partial match is recommended where possible.

Q) My test framework is slow and flaky. How do I fix this?
-----

Image recognition is slow and sometimes not very reliable. If you have an alternative way of doing what you need to do, that may be preferred over image recognition.

- Using the extended keywords in the support files that check the screen a few times before they report the failure.
- Interacting with elements on windows (shortcuts buttons - AutoIt)
- Navigating menu bars (shortcut keys - AutoIt)
- For browser interaction, use Selenium
- While using the snipping tool, make sure the image intended to be captured is not highlighted or in focus. This will add a change in color or orientation to the image and make the image not traceable.
-  Unless you're wanting to check for a particular expected outcome, make sure to not capture images with prefilled text.
- Try not to choose a large cross-section of images, this slows down the operation. Images need to be unique and small in size. Sikuli is clever to identify the image if it's unique.
- If an image is highlighted due to an error action on the screen, do not capture a highlighted image for interaction. Use AutoIT keyboard shortcuts to undo highlighting by clicking elsewhere.

Q) How can you check that the screenshot matches what you expect it to match?
----

You can use the Highlight keyword in robot to highlight exactly what Sikuli matches on.

```
Highlight  ${IMG_PATH}
```

Click on the highlighted image to make the higlhighting dissapear.
