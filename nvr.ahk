#SingleInstance force

if WinExist("ahk_class IEFrame") {
  ; MsgBox, Hello
  WinActivate ahk_class IEFrame
  if(wb := GetActiveExplorer()) {
      ; MsgBox, % wb.LocationURL    ; http://msdn.microsoft.com/en-us/library/aa752084
      while wb.busy
        sleep 100
      sleep 1000
      ; ClickElementWithThisText("Start All Live View", wb.document, "button")
      ClickElementWithThisText("Playback", wb.document, "a")
      while wb.busy
        sleep 100
      ClickButtonWithThisId("btn_wnd_split", wb.document, "button")
      while wb.busy
        sleep 200
      ClickElementWithThisTitle("1x1", wb.document, "button")
      while wb.busy
        sleep 200
      ClickElementWithThisTitle("Play", wb.document, "button")
      ; return
  }
  return
}
; Return

;START IF NOT RUNNING: **************************************
wb	:= ComObjCreate( "InternetExplorer.Application" )
while wb.busy
 sleep 100
wb.Navigate("http://10.0.0.60")
; wb.Navigate("www.AutoHotkey.com")
while wb.busy
 sleep 100
wb.Visible 		:= True
WinMaximize,A
while wb.busy
 sleep 100
sleep 200

sleep 200
; wb.document.all.username.value := "username"
; wb.document.all.password.value := "password" ; this doesn't work page doesn't understand the value change!
; ClickElementWithThisText0("Login", wb.document, "label")
; return
sendInput,username{Tab}
sendInput, password{Enter}
while wb.busy
 sleep 100
sleep 1000
ClickElementWithThisTitle("Start All Live View", wb.document, "button")
; ClickElementWithThisTitle("Forums", wb.document, "a")
return

; NEW **********************

; http://msdn.microsoft.com/en-us/library/bb774094
GetActiveExplorer() { ; Gets the active IE or Explorer window
    WinHWND := WinActive("A")
    for win in ComObjCreate("Shell.Application").Windows
        if (win.HWND = WinHWND)
            return win
    return 0
}


ClickElementWithThisTitle(text, document, tagName) {
  elements := document.getElementsByTagName(tagName)
  Loop % elements.length {
    ; if (elements[A_Index - 1].id = text)
    ; msgbox, % elements[A_Index - 1].innerText
    if (elements[A_Index - 1].title = text)
    {
      elements[A_Index - 1].click()
      break
    }
  }
}

ClickButtonWithThisId(text, document, tagName)
{
  elements := document.getElementsByTagName(tagName)
  Loop % elements.length {
    if (elements[A_Index - 1].id = text)
    {
      elements[A_Index - 1].click()
      break
    }
  }
}

ClickElementWithThisText(text, document, tagName) {
  elements := document.getElementsByTagName(tagName)
  Loop % elements.length {
    if (elements[A_Index - 1].innerText = text)
    ; msgbox, % elements[A_Index - 1].innerText
    ; if (elements[A_Index - 1].title = text)
    {
      elements[A_Index - 1].click()
      break
    }
  }
}

ClickElementWithThisText0(text, document, tagName) {
  elements := document.getElementsByTagName(tagName)
  Loop % elements.length {
    if (elements[A_Index - 1].innerText = text)
    {
      elements[A_Index - 1].click()
      break
    }
  }
}