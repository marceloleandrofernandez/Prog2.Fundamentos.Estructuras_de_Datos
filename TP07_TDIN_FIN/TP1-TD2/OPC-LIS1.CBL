      ***** MENU A-B-M DESPLEGABLE - PARA ELEGIR LISTADOS*****
       IDENTIFICATION DIVISION.
       PROGRAM-ID. OPC-LIS5.
       DATA DIVISION.
       FILE SECTION.
       WORKING-STORAGE SECTION.
      *--------PARA EL MOUSE - COBOL------------**
       77 X                 PIC 99  BINARY VALUE 10.
       77 Y                 PIC 99  BINARY VALUE 10.
       77 RES               PIC 99  BINARY VALUE 10.
       77 BOTON             PIC 9   BINARY.
       77 TECLA             PIC X.
       77 LLAMA             PIC X VALUE "S".
       77 BAN               PIC 9 VALUE 0.
       77 SUBRA             PIC X(80) VALUE ALL " ".
       01 FI                PIC 99.
       01 LI                PIC 99.
      *-------       ----------------------------***
       01 TABLA-OPCIONES.
         02 FILLER PIC X(15) VALUE  "ALUMNOS       ".
         02 FILLER PIC X(15) VALUE  "ALUM.ORDENADOS".

       01 RTABLA REDEFINES TABLA-OPCIONES.
         02 ELEMEN PIC X(15) OCCURS 2 TIMES.

      *--- variable que lleva valores al pgm MODMEN2 ---***
       LINKAGE SECTION.
       77 MOV PIC 9.

       SCREEN SECTION.
       PROCEDURE DIVISION USING MOV.

       INICIO.
      *-- LLAMA AL PGM "FONDO" CON "CALL" --*
      *--LAS POSICIONES SON-- IZ-AR-DE-AB-COLOR --*
           CALL "FONDO" USING 32 06 48 09   4.
           CANCEL "FONDO"
      **************** MOUSE **************
            MOVE 2 TO FI.
            MOVE 1 TO LI.
       FILA.
           IF LI = 1 OR LI > 2 MOVE 7 TO FI.
           IF LI = 2 OR LI < 1 MOVE 8 TO FI.
       UNO.
           DISPLAY ELEMEN(LI) LINE FI POSITION 33 LOW
           CONTROL "WINDOWS-CREATE, FCOLOR = WHITE, BCOLOR = BLACK".
           ADD 1 TO LI ADD 1 TO FI IF LI > 2 NEXT SENTENCE ELSE GO UNO.
       DOS.
           IF LI < 1 MOVE 2 TO LI.
           IF LI > 2 MOVE 1 TO LI.
           PERFORM FILA.
           DISPLAY ELEMEN(LI) LINE FI POSITION 33 LOW REVERSE
           CONTROL "WINDOWS-CREATE, FCOLOR = WHITE, BCOLOR = BLACK".
       TRES.
           CALL "PIKORATC" USING X, Y, RES, BOTON.
           DISPLAY ELEMEN(LI) LINE FI POSITION 33 LOW
           CONTROL "WINDOWS-CREATE, FCOLOR = WHITE, BCOLOR = BLACK".
           IF X = 07 AND Y >= 33 AND Y <= 47 MOVE 1 TO LI GO CUATRO.
           IF X = 08 AND Y >= 33 AND Y <= 47 MOVE 2 TO LI GO CUATRO.
      ** MOVIMIENTO DEL MENU HACIA LA DERECHA **
           IF RES = 77
              MOVE 3 TO MOV
              EXIT PROGRAM
           END-IF.
      ** MOVIMIENTO DEL MENU HACIA LA IZQUIERDA **
           IF RES = 75
              MOVE 1 TO MOV
              EXIT PROGRAM
           END-IF.
           IF RES = 72 SUBTRACT 1 FROM LI GO DOS.
           IF RES = 80 ADD 1 TO LI GO DOS.
           IF RES = 01 MOVE 5 TO LI GO CUATRO.
           IF RES = 28 NEXT SENTENCE ELSE GO DOS.

       CUATRO.
           IF LI = 1
              CALL   "LISTP01"
              CANCEL "LISTP01"
              DISPLAY " " CONTROL "FCOLOR=WHITE, BCOLOR=BLACK"
           END-IF.
           IF LI = 2
              CALL   "ORDMA-01"
              CANCEL "ORDMA-01"
              CALL   "MENLI-01"
              CANCEL "MENLI-01"
              DISPLAY " " CONTROL "FCOLOR=WHITE, BCOLOR=BLACK"
           END-IF.
              MOVE 5 TO MOV
              EXIT PROGRAM.
      *        STOP RUN.

