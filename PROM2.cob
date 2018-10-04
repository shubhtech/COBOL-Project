PMAP012  DFHMSD TYPE=&SYSPARM,LANG=COBOL,MODE=INOUT,                   *
               STORAGE=AUTO,TIOAPFX=YES
SBI1     DFHMDI SIZE=(24,80),LINE=1,COLUMN=1,CTRL=(FREEKB,FRSET)
         DFHMDF POS=(2,25),INITIAL='STATE BANK OF INDIA',LENGTH=20,    *
               ATTRB=(PROT,BRT)
         DFHMDF POS=(1,60),INITIAL='DATE:',LENGTH=05,                  *
               ATTRB=(PROT,BRT)
DAT2     DFHMDF POS=(1,66),LENGTH=10,ATTRB=PROT
         DFHMDF POS=(3,30),INITIAL='NEW ACCOUNT SCREEN',LENGTH=20,     *
               ATTRB=(PROT,BRT)
         DFHMDF POS=(6,05),INITIAL='CUSTOMER NO:',LENGTH=12,           *
               ATTRB=PROT
CUST     DFHMDF POS=(6,20),LENGTH=10,ATTRB=(UNPROT,IC),                *
               PICIN='X(10)',PICOUT='X(10)'
         DFHMDF POS=(6,31),LENGTH=1,ATTRB=ASKIP
         DFHMDF POS=(6,40),INITIAL='NAME:',LENGTH=5,                   *
               ATTRB=PROT
NAME     DFHMDF POS=(6,54),LENGTH=20,ATTRB=UNPROT,                     *
               PICIN='X(20)',PICOUT='X(20)'
         DFHMDF POS=(6,75),LENGTH=1,ATTRB=ASKIP
         DFHMDF POS=(7,05),INITIAL='SALARY DRAWN:',LENGTH=12,          *
               ATTRB=PROT
SALARY   DFHMDF POS=(7,20),LENGTH=6,ATTRB=(UNPROT,NUM),                *
               PICIN='9(6)',PICOUT='9(6)'
         DFHMDF POS=(7,27),LENGTH=1,ATTRB=ASKIP
         DFHMDF POS=(7,40),INITIAL='ADDRESS:',LENGTH=08,               *
               ATTRB=PROT
ADD      DFHMDF POS=(7,54),LENGTH=25,ATTRB=UNPROT,                     *
               PICIN='X(25)',PICOUT='X(25)'
         DFHMDF POS=(7,80),LENGTH=1,ATTRB=ASKIP
         DFHMDF POS=(8,05),INITIAL='PHONE:',LENGTH=06,                 *
               ATTRB=PROT
PHONE    DFHMDF POS=(8,20),LENGTH=10,ATTRB=(UNPROT,NUM),               *
               PICIN='9(10)',PICOUT='9(10)'
         DFHMDF POS=(8,31),LENGTH=1,ATTRB=ASKIP
         DFHMDF POS=(9,05),INITIAL='AGE:',LENGTH=05,                   *
               ATTRB=PROT
AGE      DFHMDF POS=(9,20),LENGTH=02,ATTRB=UNPROT,                     *
               PICIN='9(02)',PICOUT='9(02)'
         DFHMDF POS=(9,23),LENGTH=1,ATTRB=ASKIP
         DFHMDF POS=(9,40),INITIAL='CITY:',LENGTH=05,                  *
               ATTRB=PROT
CITY     DFHMDF POS=(9,54),LENGTH=10,ATTRB=UNPROT,                     *
               PICIN='X(10)',PICOUT='X(10)'
         DFHMDF POS=(9,65),LENGTH=1,ATTRB=ASKIP
         DFHMDF POS=(10,05),INITIAL='STATE:',LENGTH=06,                *
               ATTRB=PROT
STATE    DFHMDF POS=(10,20),LENGTH=10,ATTRB=UNPROT,                    *
               PICIN='X(10)',PICOUT='X(10)'
         DFHMDF POS=(10,31),LENGTH=1,ATTRB=ASKIP
         DFHMDF POS=(12,5),INITIAL='STUDENT NAME',LENGTH=13,           *
               ATTRB=PROT
STU      DFHMDF POS=(12,20),LENGTH=19,ATTRB=UNPROT,                    *
               PICIN='X(19)',PICOUT='X(19)'
         DFHMDF POS=(12,40),INITIAL='COLLEGE NAME:',                   *
               ATTRB=PROT,LENGTH=13
COL      DFHMDF POS=(12,54),LENGTH=20,ATTRB=UNPROT,                    *
               PICIN='X(20)',PICOUT='X(20)'
         DFHMDF POS=(12,75),LENGTH=1,ATTRB=ASKIP
         DFHMDF POS=(13,5),INITIAL='PROGRAM LEVEL:',                   *
               ATTRB=PROT,LENGTH=14
PROG     DFHMDF POS=(13,20),LENGTH=02,ATTRB=UNPROT,                    *
               PICIN='X(02)',PICOUT='X(02)'
         DFHMDF POS=(13,23),LENGTH=1,ATTRB=ASKIP
         DFHMDF POS=(13,40),INITIAL='DATE OF JOIN',                    *
               ATTRB=PROT,LENGTH=12
DOJ      DFHMDF POS=(13,54),LENGTH=10,ATTRB=UNPROT,                    *
               PICIN='X(10)',PICOUT='X(10)'
         DFHMDF POS=(13,65),LENGTH=1,ATTRB=ASKIP
         DFHMDF POS=(14,5),INITIAL='DATE OF END',                      *
               ATTRB=PROT,LENGTH=14
DOE      DFHMDF POS=(14,20),LENGTH=10,ATTRB=UNPROT,                    *
               PICIN='X(10)',PICOUT='X(10)'
         DFHMDF POS=(14,31),LENGTH=1,ATTRB=ASKIP
         DFHMDF POS=(14,40),INITIAL='LOAN AMOUNT:',                    *
               ATTRB=PROT,LENGTH=13
LOAN     DFHMDF POS=(14,54),LENGTH=07,ATTRB=UNPROT,                    *
               PICIN='9(07)',PICOUT='9(07)'
         DFHMDF POS=(14,62),LENGTH=1,ATTRB=PROT
         DFHMDF POS=(18,20),INITIAL='MSG:',                            *
               ATTRB=PROT,LENGTH=05
MSG      DFHMDF POS=(18,25),ATTRB=PROT,LENGTH=40
         DFHMDF POS=(21,20),LENGTH=60,ATTRB=PROT,                      *
               INITIAL='PF1=HELP PF2=CONFIRM PF3=EXIT PF12=CLEAR'
PMAP012  DFHMSD TYPE=FINAL
         END
