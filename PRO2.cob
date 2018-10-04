       IDENTIFICATION DIVISION.
       PROGRAM-ID. CUST.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 WS-CUST-REC.
           05 WS-CUST-NO PIC X(10).
           05 WS-CUST-NAME PIC X(15).
           05 WS-SAL-DRAWN  PIC 9(06).
           05 WS-CUST-ADD  PIC X(15).
           05 WS-CUST-PHONE  PIC 9(10).
           05 WS-CUST-AGE  PIC 9(02).
           05 WS-CUST-STATE  PIC X(10).
           05 WS-CUST-CITY   PIC X(10).
           05 WS-STU-NAME   PIC X(15).
           05 WS-STU-COLLEGE   PIC X(10).
           05 WS-PROG-LEVEL   PIC 9(02).
           05 WS-DOJ      PIC X(10).
           05 WS-DOE      PIC X(10).
           05 WS-LOAN-AMT   PIC 9(07).
           05 WS-STATUS      PIC X(01).
              COPY PMAP012.
              COPY DFHAID.
       77 WS-COMM         PIC X(04).
       77 WS-LEN          PIC S9(04) COMP.
       77 WS-DAT          PIC X(10).
       01 WS-CUST-ACC-REC.
           05 WS-ACCOUNT-NO PIC X(10).
           05 WS-CUST1-NO PIC X(10).
           05 WS-START-DATE  PIC X(10).
           05 WS-EXPIRY-DATE  PIC X(10).
           05 WS-REW-DATE  PIC X(10).
           05 WS-LOAN-AMT1  PIC 9(07).
           05 WS-INTEREST  PIC 9(01).
           05 WS-DUE-DATE   PIC X(10).
           05 WS-LOAN-PAID   PIC 9(07).
           05 WS-DUE-AMOUNT   PIC 9(08).
       PROCEDURE DIVISION.
       MAIN-PARA.
           EXEC CICS HANDLE CONDITION
                MAPFAIL(0001-MF-PARA)
                DUPREC(0002-DP-PARA)
                ERROR(0003-GERR-PARA)
           END-EXEC.
           IF EIBCALEN = 0
             MOVE LOW-VALUES TO SBI1I, SBI1O
             PERFORM 1000-SEND-PARA
           ELSE
             PERFORM 2000-RECEIVE-PARA
             PERFORM 3000-KEY-CHECK-PARA
           END-IF.
       1000-SEND-PARA.
           MOVE FUNCTION CURRENT-DATE(5:2) TO DAT2I(1:2).
           MOVE "/"                        TO DAT2I(3:2).
           MOVE FUNCTION CURRENT-DATE(7:2) TO DAT2I(4:2).
           MOVE "/"                        TO DAT2I(6:2).
           MOVE FUNCTION CURRENT-DATE(1:4) TO DAT2I(7:4).
           MOVE DAT2I TO WS-DAT.
           MOVE WS-DAT TO DAT2O.
           EXEC CICS SEND
                MAP('SBI1')
                MAPSET('PMAP012')
                ERASE
           END-EXEC.
           MOVE 3 TO WS-LEN.
           EXEC CICS RETURN
                TRANSID('P013')
                COMMAREA(WS-COMM)
                LENGTH(WS-LEN)
           END-EXEC.
       2000-RECEIVE-PARA.
           EXEC CICS RECEIVE
                MAP('SBI1')
                MAPSET('PMAP012')
                END-EXEC.
       3000-KEY-CHECK-PARA.
           IF EIBAID = DFHPF2
                   PERFORM 3100-WRT-PARA
                   PERFORM 3100-WRT1-PARA
           ELSE IF EIBAID = DFHPF3
                   MOVE 0 TO WS-LEN
                   EXEC CICS XCTL
                      PROGRAM('PPGM011')
                      COMMAREA(WS-COMM)
                      LENGTH(WS-LEN)
                   END-EXEC
                   MOVE 'PGM OVER...PRESS PAUSE KEY...' TO MSGO
                   PERFORM 3200-EXIT-PARA
           ELSE IF EIBAID = DFHPF1
                   MOVE 'HELP OPTIONS..' TO MSGO
           ELSE IF EIBAID = DFHPF12
                   MOVE 'VALUES ARE ERASED .......' TO MSGO
                   PERFORM 3400-ERASE-PARA
                ELSE
                   MOVE 'INVALID KEY...........' TO MSGO
                   PERFORM 3200-EXIT-PARA
                END-IF
           END-IF.
       3100-WRT-PARA.
           MOVE CUSTI TO WS-CUST-NO.
           MOVE NAMEI TO WS-CUST-NAME.
           MOVE SALARYI TO WS-SAL-DRAWN.
           MOVE ADDI TO WS-CUST-ADD.
           MOVE PHONEI TO WS-CUST-PHONE.
           MOVE AGEI TO WS-CUST-AGE.
           MOVE STATEI TO WS-CUST-STATE.
           MOVE CITYI TO WS-CUST-CITY.
           MOVE STUI TO WS-STU-NAME.
           MOVE COLI TO WS-STU-COLLEGE.
           MOVE PROGI TO WS-PROG-LEVEL.
           MOVE DOJI TO WS-DOJ.
           MOVE DOEI  TO WS-DOE.
           MOVE LOANI TO WS-LOAN-AMT.
           MOVE 200 TO WS-LEN.
           EXEC CICS WRITE
              DATASET('PLF01')
              FROM(WS-CUST-REC)
              LENGTH(WS-LEN)
              RIDFLD(WS-CUST-NO)
           END-EXEC.
       3100-WRT1-PARA.
           MOVE CUSTI TO WS-ACCOUNT-NO.
           MOVE CUSTI TO WS-CUST1-NO.
           MOVE DOJI TO WS-START-DATE.
           MOVE DOEI  TO WS-EXPIRY-DATE.
           MOVE LOANI TO WS-LOAN-AMT1.
           MOVE 200 TO WS-LEN.
           EXEC CICS WRITE
              DATASET('PLF3')
              FROM(WS-CUST-ACC-REC)
              LENGTH(WS-LEN)
              RIDFLD(WS-ACCOUNT-NO)
           END-EXEC.
           MOVE 'WRITE OVER..............' TO MSGO.
           PERFORM 1000-SEND-PARA.
       0001-MF-PARA.
           MOVE 'MAP FAIL ERROR' TO MSGO.
           PERFORM 1000-SEND-PARA.
       0002-DP-PARA.
           MOVE 'DUPLICATE RECORD.......' TO MSGO.
           PERFORM 1000-SEND-PARA.
       0003-GERR-PARA.
           MOVE 'SOME ERROR.........' TO MSGO.
           PERFORM 1000-SEND-PARA.
       3400-ERASE-PARA.
           EXEC CICS SEND
                MAP('SBI1')
                MAPSET('PMAP012')
                ERASE
           END-EXEC.
           EXEC CICS RETURN
           END-EXEC.
       3200-EXIT-PARA.
           EXEC CICS SEND
                MAP('SBI1')
                MAPSET('PMAP012')
           END-EXEC.
           EXEC CICS RETURN
           END-EXEC.
