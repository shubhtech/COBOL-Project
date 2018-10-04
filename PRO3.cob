       IDENTIFICATION DIVISION.
       PROGRAM-ID. NIKITA.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 WS-CUST-ACC-REC.
            05 WS-ACCOUNT-NO    PIC X(10).
            05 WS-CUST1-NO    PIC X(10).
            05 WS-START-DATE    PIC X(10).
            05 WS-EXPIRY-DATE   PIC X(10).
            05 WS-REW-DATE  PIC X(10).
            05 WS-LOAN-AMT1   PIC 9(07).
            05 WS-INTEREST PIC 9(01) VALUE 07.
            05 WS-DUE-DATE      PIC X(10).
            05 WS-LOAN-PAID     PIC 9(07).
            05 WS-DUE-AMOUNT    PIC 9(08).
       01 WS-CUST-REC.
            05 WS-CUST-NO         PIC X(10).
            05 WS-CUST-NAME PIC X(15).
            05 WS-SAL-DRAWN       PIC 9(06).
            05 WS-CUST-ADD         PIC X(15).
            05 WS-CUST-PHONE        PIC 9(10).
            05 WS-CUST-AGE             PIC 9(02).
            05 WS-CUST-STATE           PIC X(10).
            05 WS-CUST-CITY            PIC X(10).
            05 WS-STU-NAME        PIC X(15).
            05 WS-STU-COLLEGE      PIC X(10).
            05 WS-PROG-LEVEL   PIC 9(02).
            05 WS-DOJ             PIC X(10).
            05 WS-DOE             PIC X(10).
            05 WS-LOAN-AMT     PIC 9(07).
            05 WS-STATUS          PIC X(01).
            COPY PMAP013.
            COPY DFHAID.
       77 WS-LEN               PIC S9(04) COMP.
       77 WS-COMM              PIC X(04).
       77 WS-DAT               PIC X(10).
       PROCEDURE DIVISION.
       MAIN-PARA.
           EXEC CICS HANDLE CONDITION
           MAPFAIL(0001-MF-PARA)
           DUPREC(0002-DP-PARA)
           ERROR(0003-GERR-PARA)
           END-EXEC.
           IF EIBCALEN = 0
              MOVE LOW-VALUES             TO SBI3I , SBI3O
              PERFORM 1000-SEND-PARA
           ELSE
              PERFORM 2000-RECEIVE-PARA
              PERFORM 3000-KEY-CHECK-PARA
           END-IF.
       1000-SEND-PARA.
           MOVE FUNCTION CURRENT-DATE(5:2) TO DAT3I(1:2).
           MOVE "/"                        TO DAT3I(3:2).
           MOVE FUNCTION CURRENT-DATE(7:2) TO DAT3I(4:2).
           MOVE "/"                        TO DAT3I(6:2).
           MOVE FUNCTION CURRENT-DATE(1:4) TO DAT3I(7:4).
           MOVE DAT3I TO WS-DAT.
           MOVE WS-DAT TO DAT3O.
           EXEC CICS SEND
            MAP('SBI3')
            MAPSET('PMAP013')
            ERASE
           END-EXEC.
            MOVE 3        TO WS-LEN.
           EXEC CICS RETURN
            TRANSID('P014')
            COMMAREA(WS-COMM)
            LENGTH(WS-LEN)
           END-EXEC.
       2000-RECEIVE-PARA.
           EXEC CICS RECEIVE
            MAP('SBI3')
            MAPSET('PMAP013')
           END-EXEC.
       3000-KEY-CHECK-PARA.
           MOVE ETCI          TO WS-CUST-NO.
           MOVE ETCI          TO WS-ACCOUNT-NO.
           MOVE 200                  TO WS-LEN.
           IF EIBAID = DFHPF1
              MOVE 'HELP...'             TO MSGO
           ELSE IF EIBAID = DFHPF2
              MOVE 'PLEASE WAIT..'          TO MSGO
              MOVE 200 TO WS-LEN
              PERFORM 3300-FETCH-PARA
              MOVE 200 TO WS-LEN
              PERFORM 3300-FETCH1-PARA
           ELSE IF EIBAID = DFHPF3
              MOVE 0 TO WS-LEN
              EXEC CICS XCTL
                PROGRAM('PPGM011')
                COMMAREA(WS-COMM)
                LENGTH(WS-LEN)
              END-EXEC
              MOVE 'EXIT...'                TO MSGO
              PERFORM 3200-EXIT-PARA
           ELSE IF EIBAID = DFHPF4
              MOVE 'CLEAR..'                TO MSGO
              EXEC CICS XCTL
                PROGRAM('PPGM014')
                COMMAREA(WS-COMM)
                LENGTH(WS-LEN)
              END-EXEC
           ELSE IF EIBAID = DFHPF12
              MOVE 'VALUES ARE ERASED .......' TO MSGO
              PERFORM 3400-ERASE-PARA
           ELSE
              MOVE 'INVALID KEY ....'       TO MSGO
              PERFORM 3200-EXIT-PARA
           END-IF
           END-IF
           END-IF
           END-IF.
       0001-MF-PARA.
           MOVE 'MAP FAIL ERROR'     TO MSGO.
           PERFORM 1000-SEND-PARA.
       0002-DP-PARA.
           MOVE 'DUPLICATE RECORD..' TO MSGO.
           PERFORM 1000-SEND-PARA.
       0003-GERR-PARA.
             MOVE 'SOME ERROR..'       TO MSGO.
             PERFORM 1000-SEND-PARA.
       3300-FETCH-PARA.
           EXEC CICS READ
            DATASET('PLF01')
            INTO(WS-CUST-REC)
            LENGTH(WS-LEN)
            RIDFLD(WS-CUST-NO)
           END-EXEC.
           MOVE WS-CUST-NAME TO CUSNO.
           MOVE WS-LOAN-AMT TO LAO.
           MOVE WS-STATUS TO STSO.
       3300-FETCH1-PARA.
           EXEC CICS READ
            DATASET('PLF3')
            INTO(WS-CUST-ACC-REC)
            LENGTH(WS-LEN)
            RIDFLD(WS-ACCOUNT-NO)
           END-EXEC.
           MOVE WS-START-DATE TO SDO.
           MOVE WS-EXPIRY-DATE TO EDO.
           MOVE WS-INTEREST TO IRO.
           MOVE WS-DUE-DATE TO DDO.
           MOVE WS-LOAN-PAID TO LPO.
           MOVE WS-DUE-AMOUNT TO DAO.
       3400-ERASE-PARA.
           EXEC CICS SEND
                MAP('SBI3')
                MAPSET('PMAP013')
                ERASE
           END-EXEC.
           EXEC CICS RETURN
           END-EXEC.
       3200-EXIT-PARA.
           EXEC CICS RETURN
           END-EXEC.
