'a simple Uart Terminal with flaws :3

SetPin gp5,gp4,COM2

Option Base 0

Dim bps$(5)

bps$(0) = "115200"
bps$(1) = "74880 ESP8266 debug"
bps$(2) = "57600"
bps$(3) = "38400"
bps$(4) = "19200"
bps$(5) = "9600"

Dim slct% = 0
Dim key$



Do
  'mnu is dawn here
  CLS
  Print "This is a simple UART Terminal"
  Print "RX on GP5 and TX on GP4"
  Print ""
  Print "Please choose baud rate"
  Print "Use the up/down arrow keys to"
  Print "cycle through your options"
  Print ""

  For i = 0 To 5
    If i = slct% Then
      Print ">"; bps$(i)
    Else
      Print " "; bps$(i)
    EndIf
  Next i

  'keys input
  Do
    k$ = Inkey$
    Pause 10
  Loop While k$ = ""

  Select Case k$
    Case Chr$(128),"W","w"'up
      slct% = slct% - 1
      If slct% < 0 Then slct% = 5
    Case Chr$(129),"S","s"'down
      slct% = slct% + 1
      If slct% > 5 Then slct% = 0
    Case Chr$(10),Chr$(13)," " 'enter
      Exit Do
  End Select
Loop

CLS

Select Case slct%
  Case 0
    Open "COM2:115200" As #1
  Case 1
    Open "COM2:74880" As #1
  Case 2
    Open "COM2:57600" As #1
  Case 3
    Open "COM2:38400" As #1
  Case 4
    Open "COM2:19200" As #1
  Case 5
    Open "COM2:9600" As #1
End Select



Print "UART Terminal READY at "+bps$(slct%)+" baud"


rxBuffer$ = ""

Do
  ' Check for data
  If Loc(#1) > 0 Then
    char$ = Input$(1, #1)'rx charactrs

    ' Check for new line
    If char$ = Chr$(10) Or char$ = Chr$(13) Then
      If rxBuffer$ <> "" Then
        Print "RX>"; rxBuffer$
          rxBuffer$ = ""
        EndIf
      Else
    rxBuffer$ = rxBuffer$ + char$
    EndIf
  EndIf

    'user input handler
    If Inkey$ <> "" Then
        Line Input "TX>", userLine$
        Print #1, userLine$ + Chr$(13)  ' Send line with carriage return
    EndIf

    Pause 10
Loop
