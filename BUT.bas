'a simple Uart Terminal with flaws :3

SetPin gp5,gp4,COM2

Dim bps$
Dim comstrg$

Print "This is a simple UART Terminal"
Print "RX on GP5 and TX on GP4"

Print "Please choose baud rate"
Print "For now this software only supports"
Print "9600 and 115200 baud. Type 'a' for"
Print "9600 and 'b' for 115200 baud"
jump:
Input "Baud rate: ", bps$
a$ = "a"
b$ = "b"

If bps$ = a$ Then
  Open "COM2:9600" As #1
EndIf

If bps$ = b$ Then
  Open "COM2:115200" As #1
EndIf

If bps$ <> a$ And bps$ <> b$ Then
  Print "ERROR: INVALID INPUT!"
  GoTo jump
EndIf

Print "UART Terminal Ready"

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
    Print #1, userLine$ + Chr$(13)
  EndIf

  Pause 10
Loop
