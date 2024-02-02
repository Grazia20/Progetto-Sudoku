/*  Main
    Il predicato main accoglie l'utente mostrando un messaggio di benvenuto e spiegando le 
    regole del gioco Sudoku. 
    Viene quindi richiesto all'utente di inserire una scelta tramite read(Answer).
*/
main:-
    write('Welcome to Sudoku!'),nl,
    write('The rules of the game are quite simple:'),nl,
    write('A 9x9 square must be filled in with numbers from 1-9 with no repeated numbers'),nl,
    write('in each line, column and square 3x3'),nl,
    write('You can choose between three different category: easy, difficult, unsolvable.'),nl,
     write('Otherwise you can enter exit to terminate the game.'),nl,
    nl,
    read(_Answer),
    nl,
    choiceOfSudoku(_Answer).


/*  La scelta dell'utente viene quindi passata al predicato choiceOfSudoku(Answer) per 
    determinare l'azione corrispondente alla scelta effettuata.
    Le regole del predicato choiceOfSudoku/1 sono definite come segue:
    Se l'utente sceglie 'easy', viene chiamato il predicato easy per avviare una partita di 
    Sudoku facile.
    Se l'utente sceglie 'unsolvable', viene chiamato il predicato unsolvable per avviare una 
    partita di Sudoku insolubile.
    Se l'utente sceglie 'difficult', viene chiamato il predicato difficult per avviare una 
    partita di Sudoku difficile.
    Se l'utente sceglie 'exit', viene visualizzato il messaggio di uscita "Grazie per aver 
    giocato. Arrivederci." tramite write, e il programma viene terminato con halt/0.
    Se l'utente inserisce un'opzione diversa, viene visualizzato il messaggio "Input non 
    valido. Riprova." tramite write, e il predicato enterChoice viene chiamato per richiedere 
    un'altra scelta.
*/

choiceOfSudoku('easy') :-
  nl,
  easy.
choiceOfSudoku('unsolvable') :-
  nl,
  unsolvable.
choiceOfSudoku('difficult') :-
  nl,
  difficult.
choiceOfSudoku('exit') :-
  halt.
choiceOfSudoku(_Answer) :-
  write('Input is not valid. Try again.'),nl,
  enterChoice(_Answer).

/* Il predicato enterChoice legge l'input dell'utente tramite read(X) e chiama nuovamente il 
   predicato choiceOfSudoku(X) per determinare l'azione corrispondente.
*/

enterChoice(_Answer):-
  read(X),
  choiceOfSudoku(X).




/*************** TIPI DI GRIGLIE***********/

/* Il predicato grid definisce due liste che rappresentano la griglia di Sudoku, una con 
   valori s specificati e l'altra con valori vuoti rappresentati dall'underscore "_".
   La prima lista rappresenta la griglia di Sudoku iniziale con alcuni numeri predefiniti e 
   alcuni spazi vuoti.
   Gli spazi vuoti sono rappresentati dall'underscore "_".
   La seconda lista è una rappresentazione equivalente della griglia di Sudoku iniziale, ma 
   con gli spazi vuoti rappresentati come variabili anonime. In questo caso, le variabili 
   anonime sono rappresentate come _. 
   Questo permette di utilizzare la lista come variabile e generare soluzioni sostituendo le 
   variabili anonime con numeri corretti.
*/

easy:-
  grid(
    [
      2, '_', 8, '_', '_', '_', '_', 9, '_',
      '_', 5, '_', 1, '_', '_', '_', '_', '_',
      4, 9, '_', '_', '_', 3, 1, '_', 7,
      3, '_', '_', 5, '_', '_', 9, 2, 8,
      '_', 8, '_', 4, 9, '_', '_', 6, 3,
      '_', 6, '_', '_', 8, '_', '_', 1, '_',
      5, '_', 1, '_', 4, 8, 6, '_', '_',
      6, 4, 9, '_', '_', 5, '_', '_', 1,
      8, '_', 7, '_', 3, '_', '_', 4, 9],
    [
      2, _, 8, _, _, _, _, 9, _,
      _, 5, _, 1, _, _, _, _, _,
      4, 9, _, _, _, 3, 1, _, 7,
      3, _, _, 5, _, _, 9, 2, 8,
      _, 8, _, 4, 9, _, _, 6, 3,
      _, 6, _, _, 8, _, _, 1, _,
      5, _, 1, _, 4, 8, 6, _, _,
      6, 4, 9, _, _, 5, _, _, 1,
      8, _, 7, _, 3, _, _, 4, 9]
    ).

unsolvable:-
  grid(
    [
      '_', '_', 9, 6, '_', '_', 1, '_', '_',
      '_', 1, '_', 7, '_', '_', '_', 8, '_',
      3, 5, '_', '_', 1, '_', '_', '_', '_',
      5, '_', '_', '_', '_', '_', 6, '_', '_',
      '_', '_', '_', '_', 4, 2, '_', '_', 1,
      '_', '_', 3, '_', '_', '_', '_', 7, '_',
      '_', '_', 5, '_', '_', 6, '_', 1, '_',
      '_', '_', 6, 8, '_', '_', 3, '_', 4,
      '_', 8, 1, 4, 7, '_', 2, '_', '_'],
    [
      _, _, 9, 6, _, _, 1, _, _,
      _, 1, _, 7, _, _, _, 8, _,
      3, 5, _, _, 1, _, _, _, _,
      5, _, _, _, _, _, 6, _, _,
      _, _, _, _, 4, 2, _, _, 1,
      _, _, 3, _, _, _, _, 7, _,
      _, _, 5, _, _, 6, _, 1, _,
      _, _, 6, 8, _, _, 3, _, 4,
      _, 8, 1, 4, 7, _, 2, _, _]).


difficult:-
  grid(
    [
      '_', '_', '_', '_', '_', 1, 5, '_', 6,
      '_', '_', 5, 6, '_', '_', '_', '_', '_',
      8, '_', '_', '_', 4, '_', '_', '_', 9,
      '_', '_', 8, 1, '_', '_', 7, 4, '_',
      '_', '_', 2, '_', '_', '_', '_', '_', '_',
      '_', '_', 4, 5, 8, '_', '_', '_', 1,
      5, '_', '_', 8, '_', 9, '_', 3, '_',
      7, '_', '_', 3, '_', '_', '_', 6, '_',
      4, '_', 9, '_', 6, 2, '_', 1, 5],
    [
      _, _, _, _, _, 1, 5, _, 6,
      _, _, 5, 6, _, _, _, _, _,
      8, _, _, _, 4, _, _, _, 9,
      _, _, 8, 1, _, _, 7, 4, _,
      _, _, 2, _, _, _, _, _, _,
      _, _, 4, 5, 8, _, _, _, 1,
      5, _, _, 8, _, 9, _, 3, _,
      7, _, _, 3, _, _, _, 6, _,
      4, _, 9, _, 6, 2, _, 1, 5]).


/********* STAMPA LA GRIGLIA ***************/

/* Il predicato displayGrid viene utilizzato per visualizzare una griglia di Sudoku nel 
   formato 9x9. 
   La griglia viene rappresentata come una lista di 81 elementi, dove ogni elemento 
   rappresenta il valore di una cella nella griglia.
   Ecco come funziona il predicato:
   Il predicato displayGrid viene invocato con un'unica lista Grid che rappresenta la griglia 
   di Sudoku.
   Il predicato letterHeaders viene chiamato per stampare le intestazioni delle colonne della 
   griglia Sudoku (le lettere da A a I).
   Viene stampato il numero di riga "0" e vengono visualizzate le prime 9 celle della griglia 
   utilizzando il predicato printsudoku. 
   Questo viene ripetuto per le righe successive fino alla riga "8".
   Dopo ogni riga, viene chiamato displayBorderLine per stampare una linea orizzontale di 
   separazione tra le righe della griglia.
*/

displayGrid([
  X1, X2, X3, X4, X5, X6, X7, X8, X9,
  X10, X11, X12, X13, X14, X15, X16, X17, X18,
  X19, X20, X21, X22, X23, X24, X25, X26, X27,
  X28, X29, X30, X31, X32, X33, X34, X35, X36,
  X37, X38, X39, X40, X41, X42, X43, X44, X45,
  X46, X47, X48, X49, X50, X51, X52, X53, X54,
  X55, X56, X57, X58, X59, X60, X61, X62, X63,
  X64, X65, X66, X67, X68, X69, X70, X71, X72,
  X73, X74, X75, X76, X77, X78, X79, X80, X81
  ]):- 
  letterHeaders,
  write(' 0 '),
  printsudoku(X1, X2, X3, X4, X5, X6, X7, X8, X9),
  write(' 1 '),
	printsudoku(X10, X11, X12, X13, X14, X15, X16, X17, X18),
  write(' 2 '),
	printsudoku(X19, X20, X21, X22, X23, X24, X25, X26, X27),
  write(' 3 '),
	printsudoku(X28, X29, X30, X31, X32, X33, X34, X35, X36),
  write(' 4 '),
	printsudoku(X37, X38, X39, X40, X41, X42, X43, X44, X45),
	write(' 5 '),
  printsudoku(X46, X47, X48, X49, X50, X51, X52, X53, X54),
	write(' 6 '),
  printsudoku(X55, X56, X57, X58, X59, X60, X61, X62, X63),
	write(' 7 '),
  printsudoku(X64, X65, X66, X67, X68, X69, X70, X71, X72),
	write(' 8 '),
  printsudoku(X73, X74, X75, X76, X77, X78, X79, X80, X81).

/* Il predicato printsudoku viene utilizzato per stampare una singola riga della griglia. 
   Prende in input i valori delle 9 celle della riga e li stampa tra le barre verticali "|". 
   Ogni cella viene separata da uno spazio per una migliore formattazione.
*/

printsudoku(A, B, C, D, E, F, G, H, I):-
  write(' |'), write(' '), write(A), 
  write(' |'), write(' '), write(B), 
  write(' |'), write(' '), write(C), 
  write(' |'), write(' '), write(D), 
  write(' |'), write(' '), write(E), 
  write(' |'), write(' '), write(F), 
  write(' |'), write(' '), write(G), 
  write(' |'), write(' '), write(H), 
  write(' |'), write(' '), write(I),
  write(' |'), displayBorderLine, nl.

/* Il predicato displayBorderLine viene utilizzato per stampare una linea di separazione 
   Orizzontale tra le righe della griglia di Sudoku. Questa linea è costituita da una serie di 
   linee verticali "|", intervallate da linee orizzontali "___".
*/

displayBorderLine:- 
  nl,
  write('    |___|___|___|___|___|___|___|___|___|'),
  nl,
  write('    |   |   |   |   |   |   |   |   |   |').

/* Il predicato letterHeaders viene utilizzato per stampare le intestazioni delle colonne 
   della griglia di Sudoku. Queste intestazioni rappresentano i numeri da 0 e 8, indicando le 
   colonne della griglia.
*/

letterHeaders:-
  nl,write('IND   0   1   2   3   4   5   6   7   8'), nl, nl.


/********* SCELTA DELLA CASELLA E DEL NUMERO ********/

/* Il predicato grid ha come argomenti la griglia da compleatare da parte dell'utente,
   e la griglia del Sudoku risolto. Gestisce il flusso principale del gioco Sudoku:
   Viene visualizzata la griglia corrente utilizzando il predicato displayGrid(Grid) per 
   mostrare lo stato attuale del Sudoku.
   Viene chiamato il predicato controlendGame(Grid) per controllare se il gioco è terminato. 
   Se ci sono ancora celle vuote nella griglia (indicate da '_'), il gioco continua. Altrimenti, 
   viene visualizzato il messaggio "Congratulazioni! Hai completato il Sudoku."
   utilizzando write e viene chiamato il predicato restart per chiedere all'utente se desidera 
   giocare di nuovo.
   Viene chiamato il predicato choiceBox(Grid, Row, Column) per permettere all'utente di 
   scegliere una casella (riga e colonna) in cui inserire un nuovo numero.
   Viene chiamato il predicato insertNewNumber(Grid, Row, Column, SolutionGrid) per inserire 
   il nuovo numero scelto dall'utente nella griglia e ottenere la nuova griglia aggiornata 
   SolutionGrid.
*/

grid(Grid, SolutionGrid):-
  nl,
  displayGrid(Grid),
  controlendGame(Grid),
  choiceBox(Grid,Row,Column),
  controlColumnRow(Row, Column),
  insertNewNumber(Grid, Row, Column,SolutionGrid).
   
/* Il predicato choiceBox ha come argomenti la griglia, l'indice della riga e l'indice della 
   colonna.
   Viene richiesto all'utente di inserire il numero della colonna utilizzando  
   read_integer(Column). Il numero inserito viene assegnato alla variabile Column.
   Viene richiesto all'utente di inserire il numero della riga utilizzando read_integer(Row). 
   Il numero inserito viene assegnato alla variabile Row.
   Viene chiamato il predicato controlColumnRow(Row, Column) per verificare se le coordinate 
   inserite sono valide (compresi tra 0 e 8 inclusi).
   Se le coordinate inserite sono valide, il predicato termina con successo restituendo i 
   valori Row e Column. 
   Se le coordinate non sono valide, viene visualizzato un messaggio d'errore, e il predicato 
   viene richiamato ricorsivamente per consentire all'utente di inserire nuove coordinate 
   valide.
*/
choiceBox(_Grid,Row,Column):-
  (
    write('\nCoordinates for the box\n'),
    write('Enter the number for the column, without the final point :'), 
    nl, 
    read_integer(Column), 
    nl,
    write('Enter the number for the row, without the final point :'),
    nl, 
    read_integer(Row),
    nl, 
    controlColumnRow(Row,Column)
  ).
choiceBox(_Grid,Row,Column):-
  write('The coordinates are not valid. Try again. They must be a number between 0 and 8\n'),nl,
  choiceBox(_Grid,Row,Column).  

/* Il predicato controlColumnRow garantisce che i valori delle righe e delle colonne siano 
   compresi tra 0 e 8, utilizzando il predicato between per effettuare questa verifica.
*/
controlColumnRow(Row, Column) :-
  between(0, 8, Row),
  between(0, 8, Column).

/* Il predicato choiceNumber permette all'utente di inserire un numero per la scelta. Ha come 
   argomenti la griglia scelta e il numero dell'utente.
   Si fa un controllo per verificare che il numero inserito sia un intero utilizzando il 
   predicato integer.
   Si utilizza un range specifico per controllare che il numero sia compreso tra 1 e 9 con il 
   predicato between.
*/
choiceNumber(_Grid, Number) :-
  write('Enter the number: '),
  nl,
  read_integer(Number),
  nl,
  (
    integer(Number),
    between(1, 9, Number) ->
    true ;
    write('Error. Try again. They must be a number between 1 and 9\n'),
    choiceNumber(_Grid, _Number)
  ).


/********* INSERIRE E CONTROLLARE LA VALIDITA' DEL NUMERO E DELLA MOSSA********/


/* Il predicato insertNewNumber gestisce l'inserimento di un nuovo numero nella griglia, 
   controllando la validità dell'input e la disponibilità della casella. Se l'input non è 
   valido o la casella è già occupata, viene segnalato un errore e il gioco continua con la 
   griglia originale.
*/

insertNewNumber(Grid, Row, Column, SolutionGrid):-
  getBoxIndex(Column, Row, I1), 
  isEmpty(I1, Grid), 
  I is I1,
  choiceNumber(Grid,Number),
  write('I am checking if the entered number is correct..'),
  nl,
  controlValidityMove(I, Number, Grid, SolutionGrid).
insertNewNumber(Grid,_Row,_Column, SolutionGrid):- 
  nl,
  write('Input is not valid. There is already a number inside the box'),
  nl,
  grid(Grid, SolutionGrid).


/* Il predicato controlValidityMove controlla se un numero inserito è valido e gestisce le 
   Azioni successive in base al risultato dei controlli. Se il numero è valido, viene sostituito 
   nella griglia e il gioco continua. Se il numero non è valido, viene richiesto all'utente di 
   fare una scelta per continuare il gioco.
*/

controlValidityMove(I, Number, Grid, SolutionGrid):-
  checked_between(SolutionGrid, 1, 9, check(SolutionGrid)),
  controlEqualElement(I, SolutionGrid, Number),
  nl,
  write('The number is correct!'),
  replaceAtIndex(I, Number, Grid, NewGrid),
  grid(NewGrid, SolutionGrid).
controlValidityMove(I,Number, Grid, SolutionGrid):-
  nl,
  write('The number is not correct!'),
  nl,
  write('Do you want to try another number (enter 1) or change the box (enter 2)?'),   
  nl,
  read_integer(Choice),
  choiceNextMove(Choice,I,Number, Grid, SolutionGrid).


/* Il predicato choiceNextMove gestisce le azioni successive dopo che l'utente ha inserito un 
   numero non valido. 
   L'utente può scegliere di provare un altro numero o di cambiare la casella. 
   L'input dell'utente viene controllato per garantire una scelta valida. 
*/

choiceNextMove(1,I,_Number, Grid, SolutionGrid):-
  choiceNumber(_Grid, NewNumber),
  controlValidityMove(I, NewNumber, Grid, SolutionGrid).
choiceNextMove(2,_I,_Number, _Grid, SolutionGrid):-
  choiceBox(_Grid, NewRow,NewColumn),
  insertNewNumber(_Grid,NewRow,NewColumn, SolutionGrid).
choiceNextMove(_Choice,_I,_Number,_Grid,_SolutionGrid):-
  write('Invalid input. Please input a 1 or 2'),
  nl,
  enterChoiceNextMove(_Choice).  

/* Il predicato enterChoiceNextMove gestisce l'input dell'utente per una nuova scelta dopo un 
   input non valido in choiceNextMove. L'input viene letto e utilizzato per richiamare 
   choiceNextMove, consentendo di proseguire con le azioni successive in base alla scelta 
   dell'utente.
*/

  enterChoiceNextMove(_Choice):-
  read_integer(W),
  choiceNextMove(W,_I,_Number,_Grid,_SolutionGrid).

/* Il predicato controlEqualElement viene utilizzato per verificare se il numero inserito 
   dall'utente corrisponde all'elemento in una determinata posizione della lista SolutionGrid. 
   Se corrisponde, il predicato avrà successo, altrimenti non avrà successo.
*/
controlEqualElement(I,SolutionGrid, Number):-
   nth(I, SolutionGrid, Number).

/* Il predicato isEmpty viene utilizzato per verificare se l'elemento in una determinata 
   posizione della lista Grid è vuoto. Se l'elemento è vuoto, il predicato avrà successo, 
   altrimenti non avrà successo.
*/
isEmpty(I, Grid) :- 
  nth(I, Grid, E), 
  empty(E).

/* il predicato empty viene utilizzato per verificare se una variabile Grid rappresenta uno 
   spazio vuoto, utilizzando l'underscore come convenzione per rappresentare tale stato.
*/
empty(Grid) :- 
  Grid = '_'.

/* Il predicato replaceAtIndex sostituisce l'elemento in una lista con un nuovo elemento, 
   mantenendo gli altri elementi nella stessa posizione relativa. Utilizza la ricorsione per 
   scorrere la lista fino a raggiungere l'indice desiderato, quindi applica la sostituzione    
   utilizzando l'operatore di unificazione (=) per creare un nuovo elenco con l'elemento 
   sostituito.
*/
replaceAtIndex(1, Number, [_ | T], [Number | T]). 
replaceAtIndex(I, Number, [H | T], [H | R]) :-
    I > 1, 
    INew is I - 1, 
    replaceAtIndex(INew, Number, T, R).


/************* FINE GIOCO *******************/

/* Il predicato controlendGame(Grid) verifica se nella griglia Grid è presente ancora almeno +  
   una casella vuota rappresentata dal carattere '_'. 
   Se sì, significa che il gioco non è ancora completato, quindi il predicato memberCheck('_', 
   Grid) viene soddisfatto e il controllo del gioco continua.
   In caso di successo del predicato controlendGame(Grid), viene visualizzato il messaggio   
   "Congratulazioni! Hai completato il Sudoku." tramite il predicato write. Successivamente, 
   viene chiamato il predicato restart per chiedere all'utente se desidera giocare nuovamente.
*/

controlendGame(Grid):-
  memberCheck('_', Grid).
controlendGame(_Grid):-
  write('Congratulation! You completed the Sudoku.'),
  restart.  

/* Il predicato memberCheck(X, [X | _]) controlla se l'elemento X è presente come primo elemento 
   della lista. Se sì, il predicato viene soddisfatto.
   Il predicato memberCheck(X, [_ | T]) controlla se l'elemento X è presente nel resto della  
   lista, ignorando il primo elemento. 
   Viene utilizzata la ricorsione per continuare la ricerca nella lista T. Se l'elemento X è 
   presente in T, il predicato viene soddisfatto.
*/

memberCheck(X, [X | _]).
memberCheck(X, [_ | T]):-
  memberCheck(X, T).


/* Il predicato restart viene utilizzato per chiedere all'utente se desidera riavviare il gioco.
   Questo richiede all'utente un input e quindi chiama il predicato user_input per gestire 
   l'input. 
*/
restart :-
  nl, write('Do you want to play the game again? (s/n): '),
  read(C),
  user_input(C).

/* Il predicato process_input utilizza il pattern matching per determinare l'azione appropriata 
   in base all'input.
   Se C corrisponde a 's', significa che l'utente desidera giocare di nuovo. 
   Viene chiamato il predicato main per avviare il gioco.
   Se C corrisponde a 'n', significa che l'utente non desidera giocare di nuovo. Il programma 
   si termina semplicemente chiamando halt.
   Se l'input non corrisponde a 's' o 'n', significa che l'input non è valido. Viene visualizzato 
   un messaggio appropriato, viene chiamato restart per richiedere un nuovo input.
*/

user_input('s') :-
  main.
user_input('n') :-
  nl, halt.
user_input(_) :-
  nl, write('Input is not valid. Try again.'), restart.

/* Il predicato getBoxIndex determina l'indice di una cella all'interno della griglia Sudoku 
   9x9 in base alle sue coordinate di colonna e riga.
   Passaggi:
   1. (Row)//3*27:
      Questa espressione calcola l'indice di base della riga per la casella.
      (Row)//3 divide Row per 3 e effettua la divisione intera, scartando il resto.
      Moltiplicando il risultato per 27 si ottiene l'indice di base della riga poiché ogni 
      casella consiste di 3 righe e ogni riga contiene 9 celle.
   2. (Column)//3*3:
      Questa espressione calcola l'indice di base della colonna per la casella.
      (Column)//3 divide Column per 3 e effettua la divisione intera, scartando il resto.
      Moltiplicando il risultato per 3 si ottiene l'indice di base della colonna poiché ogni 
      casella consiste di 3 colonne.
   3. ((Row) mod 3)*9:
      Questa espressione calcola lo spostamento all'interno della riga.
      (Row) mod 3 calcola il resto della divisione di Row per 3, rappresentando lo spostamento 
      all'interno della riga.
      Moltiplicando il risultato per 9 si ottiene lo spostamento effettivo poiché ogni riga 
      all'interno della casella contiene 9 celle.
   4. (Column) mod 3:
      Questa espressione calcola lo spostamento all'interno della colonna.
      (Column) mod 3 calcola il resto della divisione di Column per 3, rappresentando lo 
      spostamento all'interno della colonna.
   5. Somma di tutti i valori calcolati e aggiunta di 1:
      I valori calcolati per l'indice di base della riga, indice di base della colonna, 
      spostamento nella riga e spostamento nella colonna vengono sommati insieme.
      L'aggiunta di 1 alla fine corregge l'indice per rispettare la convenzione 
      dell'indicizzazione a base 1 utilizzata in Prolog.
*/

getBoxIndex(Column, Row, Index) :-
    Index is (Row // 3) * 27 + (Column // 3) * 3 + ((Row mod 3) * 9) + (Column mod 3) + 1.

/************** SOLVER SUDOKU ***********/

/* Il predicato check prende in input una lista di 81 elementi rappresentanti una matrice 9x9 
   (i valori sono denotati da X11, X12, ..., X99). 
   Il compito di questo predicato è verificare che la matrice soddisfi le regole del Sudoku.
   Le prime nove righe di check/1 verificano che ogni riga della matrice contenga numeri  
   distinti. 
   Ad esempio, nodups([X11,X12,X13,X14,X15,X16,X17,X18,X19]) verifica che i numeri nella prima 
   riga [X11,X12,X13,X14,X15,X16,X17,X18,X19] siano distinti tra loro.
   Le nove righe successive verificano che ogni colonna della matrice contenga numeri distinti. 
   Ad esempio, nodups([X11,X21,X31,X41,X51,X61,X71,X81,X91]) verifica che i numeri nella prima 
   colonna [X11,X21,X31,X41,X51,X61,X71,X81,X91] siano distinti tra loro.
   Le nove righe finali verificano che ogni blocco 3x3 della matrice contenga numeri distinti. 
   Ad esempio, nodups([X11,X12,X13,X21,X22,X23,X31,X32,X33]) verifica che i numeri nel blocco 
   3x3 in alto a sinistra [X11,X12,X13,X21,X22,X23,X31,X32,X33] siano distinti tra loro.
*/

check([ X11,X12,X13,X14,X15,X16,X17,X18,X19,
        X21,X22,X23,X24,X25,X26,X27,X28,X29,
        X31,X32,X33,X34,X35,X36,X37,X38,X39,
        X41,X42,X43,X44,X45,X46,X47,X48,X49,
        X51,X52,X53,X54,X55,X56,X57,X58,X59,
        X61,X62,X63,X64,X65,X66,X67,X68,X69,
        X71,X72,X73,X74,X75,X76,X77,X78,X79,
        X81,X82,X83,X84,X85,X86,X87,X88,X89,
        X91,X92,X93,X94,X95,X96,X97,X98,X99]) :-

    nodups([X11,X12,X13,X14,X15,X16,X17,X18,X19]),
    nodups([X21,X22,X23,X24,X25,X26,X27,X28,X29]),
    nodups([X31,X32,X33,X34,X35,X36,X37,X38,X39]),
    nodups([X41,X42,X43,X44,X45,X46,X47,X48,X49]),
    nodups([X51,X52,X53,X54,X55,X56,X57,X58,X59]),
    nodups([X61,X62,X63,X64,X65,X66,X67,X68,X69]),
    nodups([X71,X72,X73,X74,X75,X76,X77,X78,X79]),
    nodups([X81,X82,X83,X84,X85,X86,X87,X88,X89]),
    nodups([X91,X92,X93,X94,X95,X96,X97,X98,X99]),

    nodups([X11,X21,X31,X41,X51,X61,X71,X81,X91]),
    nodups([X12,X22,X32,X42,X52,X62,X72,X82,X92]),
    nodups([X13,X23,X33,X43,X53,X63,X73,X83,X93]),
    nodups([X14,X24,X34,X44,X54,X64,X74,X84,X94]),
    nodups([X15,X25,X35,X45,X55,X65,X75,X85,X95]),
    nodups([X16,X26,X36,X46,X56,X66,X76,X86,X96]),
    nodups([X17,X27,X37,X47,X57,X67,X77,X87,X97]),
    nodups([X18,X28,X38,X48,X58,X68,X78,X88,X98]),
    nodups([X19,X29,X39,X49,X59,X69,X79,X89,X99]),

    nodups([X11,X12,X13,X21,X22,X23,X31,X32,X33]),
    nodups([X41,X42,X43,X51,X52,X53,X61,X62,X63]),
    nodups([X71,X72,X73,X81,X82,X83,X91,X92,X93]),
    nodups([X14,X15,X16,X24,X25,X26,X34,X35,X36]),
    nodups([X44,X45,X46,X54,X55,X56,X64,X65,X66]),
    nodups([X74,X75,X76,X84,X85,X86,X94,X95,X96]),
    nodups([X17,X18,X19,X27,X28,X29,X37,X38,X39]),
    nodups([X47,X48,X49,X57,X58,X59,X67,X68,X69]),
    nodups([X77,X78,X79,X87,X88,X89,X97,X98,X99]).

/* Il predicato nodups viene utilizzato per verificare che una lista contenga solo elementi 
   distinti. Ha due regole:
   La prima regola nodups([]). afferma che una lista vuota soddisfa la condizione di avere 
   elementi distinti.
   La seconda regola nodups([X|Xs]) :- not_contains(Xs, X), nodups(Xs). verifica che la testa 
   della lista X non sia presente nella coda Xs (ovvero la lista senza il primo elemento) e che 
   la coda soddisfi la condizione di avere elementi distinti. 
   Quindi controlla se l'elemento X è distinto da tutti gli altri elementi nella lista.
*/

nodups([]).
nodups([X|Xs]) :-
    not_contains(Xs, X),
    nodups(Xs).

/* Il predicato not_contains viene utilizzato per verificare se un elemento X non è presente in 
   una lista. Ha due regole:
   La prima regola not_contains([], _). afferma che una lista vuota non contiene l'elemento X, 
   quindi la condizione è soddisfatta.
   La seconda regola 'not_contains([Y|Ys], X) :- X \== Y, not_contains(Ys, X).’ verifica se 
   l'elemento X è diverso dalla testa della lista Y e se l'elemento X non è presente nella coda 
   Ys. In tal caso, la condizione è soddisfatta.
*/

not_contains([], _).
not_contains([Y|Ys], X) :-
    X \== Y,
    not_contains(Ys, X).

/* Il predicato checked_between viene utilizzato per iterare su una lista e verificare se ogni 
   elemento soddisfa determinate condizioni. 
   La prima riga checked_between([], _, _, _). è il caso base della ricorsione. Quando la lista 
   è vuota, il predicato ha successo senza alcuna condizione.
   La seconda riga checked_between([X|Xs], L, H, Check) :- è la regola ricorsiva. Prende in 
   input una lista [X|Xs], insieme al limite inferiore L, al limite superiore H e a una 
   condizione Check.
   La terza riga betweenElements(L, H, X), chiama il predicato betweenElements per generare 
   valori compresi tra L e H e unificarli con X. Ciò assicura che X prenda valori all'interno 
   dell'intervallo specificato.
   La quarta riga call(Check), chiama la condizione Check utilizzando il predicato call. Ciò 
   consente l'esecuzione di una condizione specificata dinamicamente. 
   La quinta riga checked_between(Xs, L, H, Check). chiama in modo ricorsivo checked_between 
   sugli elementi rimanenti della lista Xs con lo stesso limite inferiore L,limite superiore H 
   e condizione Check.
*/

checked_between([], _, _, _).
checked_between([X|Xs], L, H, Check) :-
    betweenElements(L, H, X),
    call(Check),
    checked_between(Xs, L, H, Check).

/* Il predicato betweenElements è un predicato di supporto utilizzato per generare valori tra 
   L e H. Ha due regole:
   La prima regola betweenElements(L, H, L) :- L =< H. afferma che se L è minore o uguale a H, 
   allora L stesso soddisfa la condizione ed è unificato con X.
   La seconda regola betweenElements(L, H, X) :- L < H, L1 is L+1, betweenElements(L1, H, X). 
   afferma che se L è minore di H, allora L viene incrementato di 1 per ottenere L1, e il 
   predicato viene richiamato ricorsivamente con L1 come nuovo limite inferiore. Ciò genera 
   valori tra L e H incrementando L finché non raggiunge H-1, e ogni valore è unificato con X.
*/

betweenElements(L, H, L) :- L =< H.
betweenElements(L, H, X) :-
    L < H,
    L1 is L+1,
    betweenElements(L1, H, X).


