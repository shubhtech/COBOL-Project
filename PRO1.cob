       IDENTIFICATION DIVISION.
       PROGRAM-ID. SBI.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       77 A PIC 9.
               COPY PMAP011.
       77 WS-COMM  PIC X(4).
       77 WS-LEN   PIC S9(4) COMP.
       77 WS-DAT   PIC X(10).
       PROCEDURE DIVISION.
       MAIN-PARA.
           IF EIBCALEN = 0
              MOVE LOW-VALUES TO SBII , SBIO
              PERFORM 1000-DIS-PARA
           ELSE
              PERFORM 2000-ACC-PARA
              PERFORM 3000-EXIT-PARA
           END-IF.
       1000-DIS-PARA.
           MOVE FUNCTION CURRENT-DATE(5:2) TO DAT1I(1:2).
           MOVE "/"                        TO DAT1I(3:2).
           MOVE FUNCTION CURRENT-DATE(7:2) TO DAT1I(4:2).
           MOVE "/"                        TO DAT1I(6:2).
           MOVE FUNCTION CURRENT-DATE(1:4) TO DAT1I(7:4).
           MOVE DAT1I TO WS-DAT.
           MOVE WS-DAT TO DAT1O.
           MOVE 'ENTER YOUR CHOICE' TO MSGO.
           EXEC CICS SEND
                MAP('SBI')
                MAPSET('PMAP011')
                ERASE
           END-EXEC.
           MOVE 4 TO WS-LEN.
           EXEC CICS RETURN
                TRANSID('P011')
                COMMAREA(WS-COMM)
                LENGTH(WS-LEN)
           END-EXEC.
       2000-ACC-PARA.
           EXEC CICS RECEIVE
                MAP('SBI')
                MAPSET('PMAP011')
           END-EXEC.
           MOVE CHOICEI TO A.
           IF A = 1
               MOVE 0 TO WS-LEN
               EXEC CICS XCTL
                PROGRAM('PPGM013')
                COMMAREA(WS-COMM)
                LENGTH(WS-LEN)
               END-EXEC
               ELSE IF A = 2
               MOVE 0 TO WS-LEN
               EXEC CICS XCTL
                PROGRAM('PPGM014')
                COMMAREA(WS-COMM)
                LENGTH(WS-LEN)
               END-EXEC
               ELSE
                 MOVE 'INVALID CHOICE' TO MSGO
                 EXEC CICS SEND
                          MAP('SBI')
                          MAPSET('PMAP011')
                 END-EXEC
               END-IF
               END-IF.
       3000-EXIT-PARA.
             EXEC CICS RETURN
             END-EXEC.
