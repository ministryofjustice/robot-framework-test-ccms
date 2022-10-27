Q) How do I take a screenshot/snapshot of anything on Windows?
----

Windows comes with a handy tool called `Snipping Tool`. Launch and take a snip of what you'd like to match on with Sikuli. Save it in the project folder you're working in (recommended inside the Images folder).

Q) How do you decide on what screenshot to take and for what purpose?
----

- Interact with the element
- Take a screenshot of the element. Ensure that the borders of the element is contained within the screenshot.
- Sikuli will click on the first occurrence of the image if there are multiple. If you have multiple occurrences of something and want to click on a particular one, ensure that you’ve captured a unique surrounding detail around the element within the screenshot.

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
Read Text From Region  ${region}
```

Q) My test framework is slow and flaky. How do I fix this?
-----

Image recognition is slow and sometimes not very reliable. If you have an alternative way of doing what you need to do, that may be preferred over image recognition.

- Using the extended keywords in the support files that check the screen a few times before they report the failure.
- Interacting with elements on windows (shortcuts buttons - AutoIt)
- Navigating menu bars (shortcut keys - AutoIt)
- For browser interaction, use Selenium

Beware of colours that may change from user to user such as themes of a browser - these are likely to fail matching on other peoples machines.

Q) How can you check that the screenshot matches what you expect it to match?
----

You can use the Highlight keyword in robot to highlight exactly what Sikuli matches on.

```
Highlight  ${IMG_PATH}
```

Click on the highlighted image to make the higlhighting dissapear.
