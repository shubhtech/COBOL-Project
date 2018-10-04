PMAP011  DFHMSD TYPE=&SYSPARM,LANG=COBOL,MODE=INOUT,                   *
               STORAGE=AUTO,TIOAPFX=YES
SBI      DFHMDI SIZE=(24,80),LINE=1,COLUMN=1,CTRL=(FREEKB,FRSET)
         DFHMDF POS=(2,25),LENGTH=30,ATTRB=(PROT,BRT),                 *
               INITIAL='STATE BANK OF INDIA'
         DFHMDF POS=(01,60),LENGTH=05,ATTRB=PROT,                      *
               INITIAL='DATE:'
DAT1     DFHMDF POS=(01,66),LENGTH=10,ATTRB=PROT
         DFHMDF POS=(3,29),LENGTH=15,ATTRB=(PROT,BRT),                 *
               INITIAL='MAIN SCREEN'
         DFHMDF POS=(06,20),LENGTH=40,ATTRB=(PROT,BRT),                *
               INITIAL='1.NEW ACCOUNT SCREEN'
         DFHMDF POS=(8,20),LENGTH=40,ATTRB=(PROT,BRT),                 *
               INITIAL='2.ACCOUNT SUMMARY'
         DFHMDF POS=(11,15),LENGTH=30,ATTRB=(PROT,BRT),                *
               INITIAL='ENTER YOUR CHOICE_'
CHOICE   DFHMDF POS=(11,46),LENGTH=01,ATTRB=(UNPROT,IC),               *
               PICIN='X(01)',PICOUT='X(01)'
         DFHMDF POS=(11,48),LENGTH=1,ATTRB=PROT 
         DFHMDF POS=(18,20),LENGTH=05,ATTRB=PROT,                      *
               INITIAL='MSG:'
MSG      DFHMDF POS=(18,25),LENGTH=40,ATTRB=PROT
         DFHMDF POS=(21,20),LENGTH=60,ATTRB=PROT,                      *
               INITIAL='PF1=HELP PF2=CONFIRM PF3=EXIT PF12=CLEAR'
PMAP011  DFHMSD TYPE=FINAL
         END
