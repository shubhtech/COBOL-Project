       IDENTIFICATION DIVISION.
       PROGRAM-ID. XYZ.
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT INFILE1 ASSIGN TO DD1
           ORGANIZATION IS INDEXED
           RECORD KEY IS ICUST-NO
           ACCESS MODE IS SEQUENTIAL
           FILE STATUS IS FS1.
           SELECT INFILE2 ASSIGN TO DD2
           ORGANIZATION IS INDEXED
           RECORD KEY IS IACCOUNT-NO
           ACCESS MODE IS SEQUENTIAL
           FILE STATUS IS FS2.
           SELECT OUTFILE ASSIGN TO DD3
           ORGANIZATION IS SEQUENTIAL
           ACCESS MODE IS SEQUENTIAL
           FILE STATUS IS FS3.
       DATA DIVISION.
       FILE SECTION.

       FD INFILE1.
       01 INREC1.
           05 ICUST-NO                 PIC X(10).
           05 ICUST-NAME               PIC X(10).
           05 ISAL-DRAWN               PIC 9(06).
           05 ICUST-ADD                PIC X(25).
           05 ICUST-PHONE              PIC 9(10).
           05 ICUST-AGE                PIC 9(02).
           05 ICUST-STATE              PIC X(10).
           05 ICUST-CITY               PIC X(10).
           05 ICUST-STU-NAME           PIC X(20).
           05 ICUST-STU-COLLEGE        PIC X(20).
           05 ICUST-PROG-LEVEL         PIC 9(02).
           05 ICUST-DOJ                PIC X(10).
           05 ICUST-DOE                PIC X(10).
           05 ICUST-LOAN-AMT           PIC X(02).
           05 ISTATUS                  PIC X(01).
           05 FILLER                   PIC X(52).
       FD INFILE2.
       01 INREC2.
           05 IACCOUNT-NO              PIC X(10).
           05 ICUST1-NO                PIC X(10).
           05 ISTART-DATE              PIC X(10).
           05 IEXPIRY-DATE             PIC X(10).
           05 IREW-DATE                PIC X(10).
           05 ILOAN-AMT1               PIC 9(07).
           05 IINTEREST                PIC 9(01).
           05 IDUE-DATE                PIC X(10).
           05 ILOAN-PAID               PIC X(10).
           05 IDUE-AMOUNT              PIC X(08).
           05 FILLER                   PIC X(114).
       FD OUTFILE.
       01 OUTREC.
           05 FILLER              PIC X(08).
           05 OCUST-NAME      PIC X(20).
           05 FILLER              PIC X(05).
           05 OACCOUNT-NO     PIC X(10).
           05 FILLER              PIC X(15).
           05 OACCOUNT-CLOSE-DATE PIC X(10).
           05 FILLER              PIC X(15).
       WORKING-STORAGE SECTION.
       01 FS1            PIC 9(02) VALUE 0.
       01 FS2            PIC 9(02) VALUE 0.
       01 FS3            PIC 9(02) VALUE 0.
       01 WS-EOF         PIC X(01) VALUE 'N'.
       01 WS-D           PIC X(10) VALUE SPACES.
       01 WS-T           PIC X(10) VALUE SPACES.

       01 HEADER1.
           05 FILLER PIC X(80) VALUE ALL "*".

       01 HEADER2.
           05 FILLER PIC X(05).
           05 FILLER PIC X(05) VALUE "DATE:".
           05 DAT1   PIC X(25).
           05 FILLER PIC X(05) VALUE "TIME:".
           05 TIM1   PIC X(10).
           05 FILLER PIC X(25).
       01 HEADER4.
           05 FILLER PIC X(20).
           05 FILLER PIC X(40) VALUE "STATE BANK OF INDIA".
           05 FILLER PIC X(20).
       01 HEADER5.
           05 FILLER PIC X(20).
           05 FILLER PIC X(40) VALUE "INACTIVE CUSTOMERS".
           05 FILLER PIC X(20).

       01 HEADER3.
           05 FILLER PIC X(05).
           05 FILLER PIC X(12) VALUE "ACCOUNT NO.".
           05 FILLER PIC X(14).
           05 FILLER PIC X(14) VALUE "CUSTOMER NAME".
           05 FILLER PIC X(10).
           05 FILLER PIC X(19) VALUE "ACCOUNT CLOSE DATE".
           05 FILLER PIC X(06).
       PROCEDURE DIVISION.
       000-MAIN-PARA.
           PERFORM 100-OPEN-PARA.
           PERFORM 200-HEADER-PARA.
           PERFORM 300-READ-PARA UNTIL WS-EOF = 'Y'.
           PERFORM 400-CLOSE-PARA.
           STOP RUN.

       100-OPEN-PARA.
           OPEN INPUT INFILE1.
           IF FS1 = 00
               DISPLAY "INFILE1 OPEN SUCCESS"
           ELSE
               DISPLAY "INFILE1 OPEN FAILURE" FS1
           END-IF.
           OPEN INPUT INFILE2.
           IF FS2 = 00
               DISPLAY "INFILE2 OPEN SUCCESS"
           ELSE
               DISPLAY "INFILE2 OPEN FAILURE" FS2
           END-IF.
           OPEN OUTPUT OUTFILE.
           IF FS3 = 00
               DISPLAY "OUTFILE OPEN SUCESS"
           ELSE
               DISPLAY "OUTFILE OPEN FAILURE" FS3
           END-IF.

       200-HEADER-PARA.
           ACCEPT WS-D    FROM DATE.
           ACCEPT WS-T    FROM TIME.
           MOVE WS-D(5:2) TO DAT1(1:2).
           MOVE "/"       TO DAT1(3:1).
           MOVE WS-D(3:2) TO DAT1(4:2).
           MOVE "/"       TO DAT1(6:1).
           MOVE WS-D(1:2) TO DAT1(7:2).
           MOVE WS-T(1:2) TO TIM1(1:2).
           MOVE "/"       TO TIM1(3:1).
           MOVE WS-T(3:2) TO TIM1(4:2).
           MOVE "/"       TO TIM1(6:1).
           MOVE WS-T(5:2) TO TIM1(7:2).
           WRITE OUTREC FROM HEADER1.
           WRITE OUTREC FROM HEADER4.
           WRITE OUTREC FROM HEADER5.
           WRITE OUTREC FROM HEADER2.
           WRITE OUTREC FROM HEADER1.
           WRITE OUTREC FROM HEADER3.
           WRITE OUTREC FROM HEADER1.

       300-READ-PARA.
           READ INFILE2 AT END MOVE 'Y' TO WS-EOF
           NOT AT END
           READ INFILE1
               IF FS1 = 00
                   MOVE LOW-VALUES TO OUTREC
                   IF ISTATUS = 'I'
                       MOVE ICUST-NO TO OACCOUNT-NO
                       MOVE IEXPIRY-DATE  TO OACCOUNT-CLOSE-DATE
                       MOVE ICUST-NAME TO OCUST-NAME
                       WRITE OUTREC
                   ELSE
                       DISPLAY "ACTIVE STATUS" FS1
                       DISPLAY "ACTIVE STATUS" FS2
                   END-IF
               END-IF
           END-READ.
       400-CLOSE-PARA.
           CLOSE INFILE1.
           IF FS1 = 00
               DISPLAY "INFILE1 CLOSE SUCCESS"
           ELSE
               DISPLAY "INFILE1 CLOSE FAILURE" FS1
           END-IF.
           CLOSE INFILE2.
           IF FS2 = 00
               DISPLAY "INFILE2 CLOSE SUCCESS"
           ELSE
               DISPLAY "INFILE2 CLOSE FAILURE" FS2
           END-IF.
           CLOSE OUTFILE.
           IF FS3 = 00
               DISPLAY "OUTFILE CLOSE SUCCESS"
           ELSE
               DISPLAY "OUTFILE CLOSE FAILURE" FS3
           END-IF.
