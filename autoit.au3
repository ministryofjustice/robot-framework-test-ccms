Run("C:\Program Files\Internet Explorer\iexplore.exe")
$handle = WinWaitActive ( "[Title:Internet Explorer]", "", 10)
Sleep(2000)
Send("^lhttps://ccmsebs.uat.legalservices.gov.uk/OA_HTML/OA.jsp?OAFunc=OAHOMEPAGE{#}{ENTER}")

WinClose($handle)