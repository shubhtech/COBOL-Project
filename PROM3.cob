PMAP013  DFHMSD TYPE=&SYSPARM,LANG=COBOL,MODE=INOUT,                   *
               STORAGE=AUTO,TIOAPFX=YES
SBI3     DFHMDI SIZE=(24,80),LINE=1,COLUMN=1,CTRL=(FREEKB,FRSET)
         DFHMDF POS=(2,30),INITIAL='STATE BANK OF INDIA',LENGTH=19,    *
               ATTRB=(PROT,BRT)
         DFHMDF POS=(1,60),INITIAL='DATE:',LENGTH=05,                  *
               ATTRB=(PROT,BRT)
DAT3     DFHMDF POS=(1,66),LENGTH=10,ATTRB=PROT
         DFHMDF POS=(3,32),INITIAL='ACCOUNT SUMMARY',LENGTH=15,        *
               ATTRB=(PROT,BRT)
         DFHMDF POS=(5,12),INITIAL='LOAN AC/ NO. :',LENGTH=14,         *
               ATTRB=(UNPROT,BRT)
ETC      DFHMDF POS=(5,27),LENGTH=10,ATTRB=(UNPROT,NUM,IC),            *
               PICIN='9(10)',PICOUT='9(10)'
         DFHMDF POS=(5,38),LENGTH=1,ATTRB=ASKIP
         DFHMDF POS=(5,48),INITIAL='NAME:',LENGTH=05,                  **
               ATTRB=(PROT,BRT)
CUSN     DFHMDF POS=(5,54),LENGTH=15,ATTRB=(PROT),                     *
               PICOUT='X(15)'
         DFHMDF POS=(5,70),LENGTH=1,ATTRB=ASKIP
         DFHMDF POS=(6,12),INITIAL='START DATE:',LENGTH=11,            *
               ATTRB=(PROT,BRT)
SD       DFHMDF POS=(6,24),LENGTH=10,ATTRB=PROT,                       *
               PICOUT='X(10)'
         DFHMDF POS=(6,35),LENGTH=1,ATTRB=ASKIP
         DFHMDF POS=(6,48),INITIAL='EXPIRY DATE:',LENGTH=12,           **
               ATTRB=(PROT,BRT)
ED       DFHMDF POS=(6,61),LENGTH=10,ATTRB=PROT,                       *
               PICOUT='X(10)'
         DFHMDF POS=(6,72),LENGTH=1,ATTRB=ASKIP
         DFHMDF POS=(7,12),INITIAL='LOAN AMOUNT:',LENGTH=14,           *
               ATTRB=(PROT,BRT)
LA       DFHMDF POS=(7,27),LENGTH=7,ATTRB=(PROT,NUM),                  *
               PICOUT='9(07)'
         DFHMDF POS=(7,35),LENGTH=1,ATTRB=ASKIP
         DFHMDF POS=(7,48),INITIAL='INTEREST RATE:',LENGTH=14,         * *
               ATTRB=(PROT,BRT)
IR       DFHMDF POS=(7,63),LENGTH=1,ATTRB=(PROT,NUM),                  * *
               PICOUT='9(1)'
         DFHMDF POS=(7,65),LENGTH=1,ATTRB=ASKIP
         DFHMDF POS=(8,12),INITIAL='DUE DATE :',LENGTH=10,             *
               ATTRB=(PROT,BRT)
DD       DFHMDF POS=(8,23),LENGTH=10,ATTRB=PROT,                       **
               PICOUT='X(10)'
         DFHMDF POS=(8,34),LENGTH=1,ATTRB=ASKIP
         DFHMDF POS=(8,48),INITIAL='STATUS(A/I)  :',LENGTH=14,         **
               ATTRB=(PROT,BRT)
STS      DFHMDF POS=(8,63),LENGTH=1,ATTRB=(PROT),                      **
               PICOUT='X(1)'
         DFHMDF POS=(8,65),LENGTH=1,ATTRB=ASKIP
         DFHMDF POS=(9,12),INITIAL='LOAN PAID :',LENGTH=12,            *
               ATTRB=(PROT,BRT)
LP       DFHMDF POS=(9,25),LENGTH=7,ATTRB=(PROT,NUM),                  **
               PICOUT='9(7)'
         DFHMDF POS=(9,33),ATTRB=ASKIP,LENGTH=1
         DFHMDF POS=(9,48),INITIAL='DUE AMOUNT   :',LENGTH=14,         **
               ATTRB=(PROT,BRT)
DA       DFHMDF POS=(9,63),LENGTH=8,ATTRB=(PROT),                      **
               PICOUT='9(8)'
         DFHMDF POS=(9,72),LENGTH=1,ATTRB=ASKIP
         DFHMDF POS=(18,20),ATTRB=PROT,LENGTH=04,                      *
               INITIAL='MSG:'
MSG      DFHMDF POS=(18,25),ATTRB=PROT,LENGTH=40
         DFHMDF POS=(21,20),LENGTH=60,ATTRB=PROT,                      *
               INITIAL='PF1=HELP PF2=CONFIRM PF3=EXIT PF12=CLEAR'
PMAP013  DFHMSD TYPE=FINAL
               END
