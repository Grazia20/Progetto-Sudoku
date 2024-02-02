-------------
--Librerie
-------------

import Data.List  -- Modulo per le operazioni sulle liste.
import Data.Char  -- Modulo per le operazioni sui Char.

-----------------------
--Dichiarazioni di base
-----------------------

-- Il tipo Grid viene rappresentato dalla Matrix, che contiene i Value
type Grid             = Matrix Value

-- Il tipo Matrix è una lista a 2 dimensioni: una lista di righe
type Matrix a         = [Row a]

-- Il tipo Row è una lista di elementi a
type Row a            = [a]

-- Il tipo di Value è char per facilitare la stampa dei valori della griglia
type Value            = Char

-- Il tipo Move è una tupla di cui il primo elemento è la colonna e il secondo è la riga
-- selezionata dall'utente
type Move             = (Int, Int)

------
--MAIN
------

{- Il blocco main è la funzione principale del programma.
   La funzione do viene utilizzata per combinare diverse azioni IO in sequenza.
   All'inizio, viene chiamata la funzione instruction per mostrare le regole del gioco 
   all'utente.
   Successivamente, viene acquisita l'input dell'utente utilizzando la funzione getLine. 
   L'input viene assegnato alla variabile input.
   Si utilizza la sintassi case-of per gestire il controllo condizionale in modo più 
   dichiarativo e leggibile.
   Vengono confrontati diversi valori di input per determinare quale azione eseguire.
   Se l'input è "easy", viene chiamata la funzione choiceOfTheBoxColumn con l'argomento easy.
   Se l'input è "difficult", viene chiamata la funzione choiceOfTheBoxColumn con l'argomento 
   difficult.
   Se l'input è "unsolvable", viene chiamata la funzione choiceOfTheBoxColumn con l'argomento 
   unsolvable.
   Se l'input è "exit", viene eseguito return () per terminare il programma.
   Se nessuna delle condizioni sopra è soddisfatta, viene eseguito il blocco else. Viene 
   stampato un messaggio di errore e viene chiamata ricorsivamente la funzione main per    
   permettere all'utente di inserire un nuovo input.
-}

main              :: IO ()
main               = 
  do
    instruction
    input <- getLine
    case input of
      "easy"       -> choiceOfTheBoxColumn easy
      "difficult"  -> choiceOfTheBoxColumn difficult
      "unsolvable" -> choiceOfTheBoxColumn unsolvable
      "exit"       -> return ()
      _            -> 
        do
          putStrLn "Input is not valid. Try again."
          main

{- La funzione instruction serve per illustrare le regole del gioco all'utente.
   La funzione do viene utilizzata per combinare diverse azioni IO in sequenza.
-}

instruction       :: IO()  
instruction        = 
  do
    putStrLn "\nWelcome to Sudoku!\n"
    putStrLn "The rules of the game are quite simple:"
    putStrLn "A 9x9 square must be filled in with numbers from 1-9 with no repeated numbers"
    putStrLn "in each line, column and square 3x3." 
    putStrLn "You can choose between three different category: easy, difficult, unsolvable."  
    putStrLn "Otherwise you can enter exit to terminate the game.\n"
  

{- La funzione restart chiede all'utente se desidera giocare nuovamente.
   Se l'utente inserisce 's', il gioco viene riavviato chiamando la funzione main.
   Se l'utente inserisce 'n', il programma termina.
   Per qualsiasi altro input, viene visualizzato un messaggio di errore e la 
   funzione restart viene chiamata nuovamente.
-}

restart          :: IO()
restart           = 
  do
    putStrLn "Do you want to play the game again? (s/n):"
    playAgain <- getLine
    case playAgain of
      "s" -> 
        do
          putStrLn $ replicate 5 '\n'
          main
      "n" -> return ()
      _   ->
         do
          putStrLn "Input is not valid. Try again."
          restart


------------------------------------------------------
--- FUNZIONI CHE RESTITUISCONO UN AZIONE IO ALL'UTENTE
------------------------------------------------------

{- La funzione choiceOfTheBoxColumn viene utilizzata per ottenere l'indice della colonna 
   dall'utente.
   Ha come argomento la griglia scelta dall'utente.
   La funzione do viene utilizzata per combinare diverse azioni IO in sequenza.
   All'inizio, viene mostrata la griglia all'utente.
   Successivamente, viene acquisita l'input dell'utente utilizzando la funzione getLine. 
   L'input viene assegnato alla variabile line.
   Vengono confrontati due valori di input per determinare quale azione eseguire.
   Se l'input è "exit", viene eseguito return () per terminare il programma.
   Per qualsiasi altro input, si controlla se l'input è valido (il secondo elemento della 
   tupla è True):
    - Si procede con la scelta della riga per la casella;
    - Input non valido, richiede nuovamente choiceOfTheBoxColumn grid
-}

choiceOfTheBoxColumn       :: Grid -> IO()
choiceOfTheBoxColumn grid   = 
  do
    putStrLn $ "\n" ++ gridStr grid ++ "\n"
    putStrLn "\nCoordinates for the box\n"
    putStrLn "Enter the number for the column: "
    line <- getLine
    case line of
      "exit" -> return ()
      _      -> do
        let numberRow      = valueControlRowColumn line
        if snd numberRow
          then choiceOfTheBoxRow grid (fst numberRow)
          else do
            putStrLn "\nThe coordinates are not valid. Try again."
            choiceOfTheBoxColumn grid


{- La funzione choiceOfTheBoxRow viene utilizzata per ottenere l'indice della colonna  
   dall'utente.
   Ha come argomenti la griglia scelta dall'utente e l'indice che indica la riga selezionata.
   La funzione do viene utilizzata per combinare diverse azioni IO in sequenza.
   Viene acquisita l'input dell'utente utilizzando la funzione getLine. 
   L'input viene assegnato alla variabile line.
   Vengono confrontati due valori di input per determinare quale azione eseguire.
   Se l'input è "exit", viene eseguito return () per terminare il programma.
   Per qualsiasi altro input, si controlla se l'input è valido (il secondo elemento della 
   tupla è True):
      - Si combina riga e colonna in un unico valore;
      - Si controlla il valore risultante;
      - In caso positivo, ovvero se il secondo elemento della tupla è True:
          - Controlla se la mossa è valida;
          - Se la mossa è valida (il secondo elemento della tupla è True): 
             - Si richiama la funzione per scegliere il numero da inserire nella casella;
             - In caso di errore, viene visualizzato un messaggio e la 
               funzione choiceOfTheBoxColumn grid viene chiamata nuovamente.
          - In caso di errore, viene visualizzato un messaggio e la 
            funzione choiceOfTheBoxColumn grid viene chiamata nuovamente.
      - In caso di errore, viene visualizzato un messaggio e la funzione choiceOfTheBoxRow grid 
        numberRow viene chiamata nuovamente.
-}

choiceOfTheBoxRow                :: Grid -> Int -> IO()
choiceOfTheBoxRow grid numberRow  = 
  do
    putStrLn "\nEnter the number for the row: " 
    line <- getLine 
    case line of
      "exit" -> return () 
      _      -> 
        do
          let numberColumn       = valueControlRowColumn line 
          if snd numberColumn 
            then do
              let valueRowColumn = concateTwoIntToStr numberRow (fst numberColumn) 
              let controlValue   = parseMove valueRowColumn
              if snd controlValue 
                then do
                  let controlM   = controlMove grid (fst controlValue) 
                  if snd controlM 
                    then insertOfTheNumber grid (fst controlValue) 
                    else do
                      putStrLn "\nError. Try Again. There is already a number inside the box"
                      choiceOfTheBoxColumn grid
                else do
                  putStrLn "\nThe coordinates are not valid."
                  choiceOfTheBoxColumn grid 
            else do
              putStrLn "\nInput is not valid.Try again."
              choiceOfTheBoxRow grid numberRow

{- La funzione insertOfTheNumber viene utilizzata per ottenere il numero da inserire nella 
   casella dall'utente. 
   Ha come argomenti la griglia scelta dall'utente e la mossa che include l'indice dalla riga 
   e della colonna e della casella selezionata.
   La funzione do viene utilizzata per combinare diverse azioni IO in sequenza.
   Viene acquisita l'input dell'utente utilizzando la funzione getLine. 
   L'input viene assegnato alla variabile line.
   Vengono confrontati due valori di input per determinare quale azione eseguire.
   Se l'input è "exit", viene eseguito return () per terminare il programma.
   Per qualsiasi altro input, si controlla se l'input è valido:
      - In caso positivo, ovvero se il secondo elemento della tupla è True:
          - Si converte in valore inserito dall'utente da Int a [Char];
          - Si prende il primo valore di [char];
          - Si richiama la funzione per inserire il numero nella casella scelta;
      - In caso di errore, viene visualizzato un messaggio e la funzione insertOfTheNumber grid 
        move viene chiamata nuovamente.
-}


insertOfTheNumber               :: Grid -> Move -> IO()
insertOfTheNumber grid move      = 
  do
    putStrLn $ "Enter the number:"
    line <- getLine
    case line of
      "exit" -> return ()
      _      -> do
        let number               = valueControl line  
        if snd number 
          then do
            let convertvalue     = intToChar (fst number) 
            let numberchosen     = head convertvalue
            fusionGrid grid move numberchosen
          else do
            putStrLn "\nInput is not valid. Try again. It must be a number between 1 and 9."
            insertOfTheNumber grid move


{- La funzione fusionGrid ha come argomenti una griglia (grid), una mossa (move) e un 
   carattere(valuenumber), e restituisce un'azione IO.
   All'interno della funzione, viene effettuata una computazione usando do e let per 
   definire variabili intermedie. 
   Queste variabili includono:
    - newGridTuple, che rappresenta la tupla risultante dell'applicazione della funzione 
      doMove alla griglia, alla mossa e al numero di valore; 
    - solutionGrid, che rappresenta la griglia risolta calcolata tramite la funzione solve; 
    - concatNewGrid e concatSolutionGrid, che rappresentano le griglie concatenate in una 
      singola
      lista di caratteri; 
    - strNewGrid e strSolNewGrid, che rappresentano le liste di stringhe ottenute trasformando 
      le griglie concatenate;
    - fusionList, che rappresenta la lista di coppie formate da elementi corrispondenti delle 
      due liste di stringhe; 
    - mapFusionList, che rappresenta la lista ottenuta applicando la funzione compare alle 
      coppie della lista fusionList; 
    - lengthEquals, che rappresenta il numero di elementi in mapFusionList che sono uguali a 
      EQ; 
    - sameElements, che rappresenta la lista degli elementi uguali a EQ in mapFusionList; 
    - indicesSameElements, che rappresenta gli indici degli elementi uguali a EQ in 
      mapFusionList; 
    - coordsGrd, che rappresenta le coordinate di tutte le celle nella griglia; 
    - convMove, che rappresenta la mossa convertita in coordinate usando matching; 
    - findIndices, che rappresenta l'indice della mossa convertita all'interno di  
      indicesSameElements.
   Successivamente, viene effettuato un controllo utilizzando case sulla tupla newGridTuple. 
   Se il secondo elemento della tupla è True, viene effettuato un ulteriore controllo 
   utilizzando case su findIndices. 
   Se findIndices è Just _, viene stampato un messaggio che indica che il numero è corretto, e 
   viene chiamata la funzione choiceOfTheBoxColumn passando la nuova griglia newGrid. 
   Se findIndices è Nothing, viene stampato un messaggio che indica che il numero non è 
   corretto, e viene chiamata la funzione choiceNextMove passando la griglia grid e la mossa  
   move. 
   Se il secondo elemento della tupla è False, viene stampato un messaggio che indica che 
   l'input non è valido, e viene chiamata la funzione choiceOfTheBoxColumn passando la griglia   
   grid.
-}

fusionGrid                        :: Grid -> Move -> Char -> IO()
fusionGrid grid move valuenumber  = 
  do 
    let newGridTuple              = doMove grid move valuenumber
    case newGridTuple of
      (newGrid, True) -> do
        let solutionGrid          = head (solve grid)
        let concatNewGrid         = concat newGrid
        let concatSolutionGrid    = concat solutionGrid
        let strNewGrid            = strArr concatNewGrid
        let strSolNewGrid         = strArr concatSolutionGrid
        let fusionList            = zip strNewGrid strSolNewGrid
        let mapFusionList         = map (uncurry compare) fusionList
        let lengthEquals          = length $ filter (== EQ) mapFusionList
        let sameElements          = filter (== EQ) mapFusionList
        let indicesSameElements   = findIndices (== EQ) mapFusionList
        let coordsGrd             = allCoords 9 9
        let convMove              = matching move coordsGrd
        let findIndices           = find (== convMove) indicesSameElements
        if lengthEquals == 81 
          then do -- tutti i numeri sono uguali, si è completato il gioco
            putStrLn $ "\n" ++ gridStr newGrid ++ "\n"
            putStrLn "Congratulation! You completed the Sudoku."
            restart 
          else case findIndices of
            Just _     -> do
              putStrLn "The number is correct!"
              choiceOfTheBoxColumn newGrid
            Nothing    -> do
              putStrLn "The number is not correct!"
              choiceNextMove grid move
      (_, False) -> do
            putStrLn "Input is not valid."
            choiceOfTheBoxColumn grid


{- La funzione choiceNextMove ha come argomenti una griglia (grid) e una mossa (move). 
   Mostra un messaggio all'utente chiedendo se desidera provare un altro numero (inserendo 
   '1') o cambiare la casella (inserendo '2').
   L'utente può anche inserire 'exit' per terminare il gioco. La funzione legge l'input 
   dell'utente e gestisce i diversi casi tramite un'espressione case.
   Se l'input è '1', viene chiamata la funzione insertOfTheNumber passando la griglia e la 
   mossa. 
   Se l'input è '2', viene chiamata la funzione choiceOfTheBoxColumn passando la griglia. 
   Se l'input è 'exit', la funzione termina. 
   In caso contrario, viene mostrato un messaggio di errore e la funzione richiama se stessa 
   per ottenere un nuovo input dall'utente.
-}

choiceNextMove                   :: Grid -> Move -> IO()
choiceNextMove grid move          = 
  do
    putStrLn "Do you want to try another number (enter 1) or change the box (enter 2)?"
    putStrLn "You can also enter 'exit' to end the game."
    line <- getLine
    case line of
      "1"    -> insertOfTheNumber grid move
      "2"    -> choiceOfTheBoxColumn grid
      "exit" -> return ()
      _      -> 
        do
          putStrLn "Invalid input. Please input '1' or '2'."
          choiceNextMove grid move


------------------------------------------------------
--- FUNZIONI AUSILIARI PER IL COMPLETAMENTO DEL SUDOKU
------------------------------------------------------

{- La funzione parseMove ha come argomento una stringa (str) e restituisce una tupla 
   contenente una mossa (Move) e un valore booleano (Bool). 
   La lunghezza della stringa viene controllata per determinare se è diversa da 2. 
   Successivamente, viene verificato se gli indici l e n sono validi, ovvero se l è un carattere 
   tra '0' e '8' e n è un carattere tra '0' e '8'. Se entrambe le condizioni sono soddisfatte, 
   viene creata una mossa valida utilizzando i valori numerici dei caratteri e restituita la 
   tupla con la mossa e il valore booleano True. In caso contrario, viene restituita una mossa 
   non valida con i valori predefiniti (0, 0) e False.
   La funzione utilizza la clausola where per definire la variabile n come il primo carattere 
   della stringa. 
   La variabile badMove rappresenta un valore non valido con valori predefiniti (0,0) e False.
-}

parseMove                         :: String -> (Move, Bool)
parseMove str
  | length str /= 2                = badMove
  | validIndices                   = ((ord l - 48, ord n - 48), True)
  | otherwise                      = badMove
  where
    l                              = str !! 0
    n                              = str !! 1
    validIndices                   = elem l ['0'..'8'] && elem n ['0'..'8']
    badMove                        = ((0, 0), False)

{- La funzione valueControl ha come argomento una stringa (str) e restituisce una tupla 
   contenente un valore intero (Int) e un valore booleano (Bool). 
   La funzione controlla diverse condizioni per determinare se la stringa di input
   rappresenta un valore valido. Se la lunghezza della stringa è diversa da 1, viene restituito 
   un valore non valido (badMove). 
   Se la stringa str è maggiore o uguale a "1" e minore o uguale a "9", viene creato un 
   valore valido utilizzando il valore numerico del carattere (ord n - 48) e viene restituita 
   la tupla con il valore e il valore booleano True. 
   In caso contrario, viene restituito un valore non valido (badMove). 
   La funzione utilizza la clausola where per definire la variabile n come il primo carattere 
   della stringa. 
   La variabile badMove rappresenta un valore non valido con valori predefiniti 0 e False.
-} 

valueControl                      :: String -> (Int, Bool)
valueControl str
  | length str /= 1                = badMove
  | validValue                     = (ord n - 48, True)
  | otherwise                      = badMove
  where
    n                              = str !! 0
    validValue                     = str >= "1" && str <= "9"
    badMove                        = (0, False)

{- La funzione valueCovalueControlRowColumnn ha come argomento una stringa (str) e restituisce 
   una tupla 
   contenente un valore intero (Int) e un valore booleano (Bool). 
   La funzione controlla diverse condizioni per determinare se la stringa di input rappresenta 
   un valore valido. Se la lunghezza della stringa è diversa da 1, viene restituito un valore 
   non valido (badMove). 
   Se la stringa str è maggiore o uguale a "0" e minore o uguale a "8", viene creato un valore 
   valido utilizzando il valore numerico del carattere (ord n - 48) e viene restituita la tupla 
   con il valore e il valore booleano True. 
   In caso contrario, viene restituito un valore non valido (badMove). 
   La funzione utilizza la clausola where per definire la variabile n come il primo carattere 
   della stringa. 
   La variabile badMove rappresenta un valore non valido con valori predefiniti 0 e False.
-} 

valueControlRowColumn             :: String -> (Int, Bool)
valueControlRowColumn str
  | length str /= 1                = badMove
  | validValue                     = (ord n - 48, True)
  | otherwise                      = badMove
  where
    n                              = str !! 0
    validValue                     = str >= "0" && str <= "8"
    badMove                        = (0, False)

{- La funzione controlMove ha come argomenti una griglia (grid) e una mossa (move) rappresentata 
   come una tupla di coordinate (x, y). Vengono definiti i predicati outOfBounds (fuori dai 
   limiti) e occupied (occupato) per rappresentare le condizioni che determinano se la mossa è
   fuori dai limiti della griglia o se la cella corrispondente è occupata. La condizione 
   outOfBounds || occupied viene utilizzata come guardia per restituire la griglia originale e 
   il valore booleano False se una delle due condizioni è vera. Altrimenti, se entrambe le 
   condizioni sono false, viene restituita la griglia originale e il valore booleano True. Le 
   variabili x, y, w e h rappresentano rispettivamente le coordinate x e y della mossa e le 
   dimensioni della griglia.
-}

controlMove                      :: Grid -> Move -> (Grid, Bool)
controlMove grid move
  | outOfBounds || occupied       = (grid, False)
  | otherwise                     = (grid, True)
  where
    x                             = fst move
    y                             = snd move
    w                             = length $ head grid
    h                             = length grid
    outOfBounds                   = x < 0 || y < 0 || x >= w || y >= h
    occupied                      = get2d x y grid /= ' '

{- La funzione doMove ha come argomenti una griglia (grid), una mossa (move) rappresentata 
   come una tupla di coordinate (x, y), e un valore carattere (value).
   Vengono definiti i predicati outOfBounds (fuori dai limiti) e occupied (occupato) per 
   rappresentare le condizioni che determinano se la mossa è fuori dai limiti della griglia o 
   se la cella corrispondente è occupata. La condizione outOfBounds || occupied viene 
   utilizzata come guardia per restituire la griglia originale e il valore booleano False se 
   una delle due condizioni è vera. Altrimenti, se entrambe le condizioni sono false, viene 
   creata una nuova griglia (updatedGrid) con il valore carattere inserito nella posizione   
   specificata dalla m
-}

doMove                          :: Grid -> Move -> Char -> (Grid, Bool)
doMove grid move value
  | outOfBounds || occupied      = (grid, False)
  | otherwise                    = (updatedGrid, True)
  where
    x                            = fst move
    y                            = snd move
    w                            = length $ head grid
    h                            = length grid
    outOfBounds                  = x < 0 || y < 0 || x >= w || y >= h
    occupied                     = get2d x y grid /= ' '
    updatedGrid                  = put2d x y value grid

{- La funzione concateTwoIntToStr ha come argomenti due numeri interi n1 e n2 e restituisce una 
   stringa ottenuta concatenando le rappresentazioni in formato stringa dei due numeri.
-}

concateTwoIntToStr              :: Int -> Int -> String
concateTwoIntToStr n1 n2         = ((show n1) ++ (show n2))

{- La funzione allCoords ha come argomenti due interi height e width come input e genera una 
   lista di coordinate abbinate a un valore di indice. Ogni coordinata rappresenta una posizione 
   in una griglia o matrice di dimensioni height x width, e il valore dell'indice rappresenta 
   l'indice corrispondente nella lista.
-}

allCoords                       :: Int -> Int -> [((Int, Int), Int)]
allCoords height width           = zip [(x, y) |y <- [0 .. height-1] , x <- [0 .. width-1]] [0..]

{- La funzione matching ha come argomenti un Move e una lista di tuple in cui il primo elemento 
   è un Move e il secondo elemento è di un qualsiasi tipo a. Restituisce il valore corrispondente 
   al Move dato nella lista. utilizza la composizione e una funzione lambda per filtrare la 
   lista di tuple in base all'uguaglianza del primo elemento con il Move dato. Successivamente 
   estrae il secondo elemento (utilizzando snd) della prima tupla nella lista filtrata.
-}

matching                        :: Move -> [((Move), a)] -> a
matching y xs                    = snd (head (filter (\(x, _) -> x == y) xs))
    
{- La funzione put ha come argomenti un indice (pos), un nuovo valore (newVal) e una lista 
   (list), e restituisce una nuova lista in cui il valore all'indice specificato è stato 
   sostituito con il nuovo valore.
   Utilizza le funzioni di manipolazione delle liste take e drop per dividere la lista in due 
   parti: una parte che va dall'inizio fino all'indice precedente (take pos list), seguita dal 
   nuovo valore (newVal), e infine la parte che va dall'indice successivo fino alla fine (drop 
   (pos+1) list).
   Queste due parti vengono concatenate insieme per formare la nuova lista risultante.
-}

put                            :: Int -> a -> [a] -> [a]
put pos newVal list             = take pos list ++ newVal : drop (pos+1) list

{- La funzione put2d ha come argomenti due indici (x e y), un nuovo valore (newVal) e una 
   matrice rappresentata come una lista di liste (mat), e restituisce una nuova matrice in cui 
   il valore alla posizione specificata dagli indici x e y è stato sostituito con il nuovo 
   valore.
   Utilizza la funzione put per sostituire il valore nella lista interna (riga) specificata 
   dall'indice y con il nuovo valore, e quindi sostituire l'intera lista interna nella lista 
   principale (matrice) specificata dall'indice y con la nuova lista interna risultante.
-}

put2d                         :: Int -> Int -> a -> [[a]] -> [[a]]
put2d x y newVal mat           = put y (put x newVal (mat!!y)) mat

{- La funzione get2d ha come argomenti due indici (x e y) e una matrice rappresentata come una 
   lista di liste (mat), e restituisce il valore presente nella posizione specificata dagli 
   indici. 

   Utilizza l'operatore di accesso alla lista (!!) per accedere all'elemento della lista interna   
   (riga) specificata dall'indice y, e quindi accedere all'elemento desiderato nella lista 
   interna utilizzando l'indice x.
-}

get2d                         :: Int -> Int -> [[a]]  -> a
get2d x y mat                  = (mat!!y)!!x

{- La funzione strArr ha come argomenti una stringa (str) e restituisce una lista di singoli 
   caratteri, ognuno rappresentato come una stringa separata. Utilizza la funzione map per  
   applicare una funzione lambda a ciascun carattere della stringa. La funzione lambda prende 
   un carattere x e lo incapsula in una lista [x], creando così una lista di stringhe in cui 
   ogni carattere è rappresentato come una stringa separata.
-}

strArr                        :: String -> [String]
strArr                         = map (\x -> [x])

{- La funzione intToChar ha come argomento un intero x e restituisce la rappresentazione come 
   stringa del numero corrispondente. utilizza una guardia per controllare se l'intero x è 
   compreso tra 0 e 9. In tal caso, viene convertito in carattere utilizzando la funzione chr 
   e viene aggiunto 48 (codice ASCII del carattere '0') per ottenere il corrispondente carattere 
   numerico. 
   Il risultato viene restituito come una lista di carattere singolo. Se l'intero x non è 
   compreso nell'intervallo specificato, viene restituita una lista vuota.
-}

intToChar                     :: Int -> String
intToChar x 
    | x >= 0 && x <= 9         = [chr (x + 48)]
    | otherwise                = []

---------------------------------------
--Griglia easy, difficult e unsolvable
---------------------------------------

easy                  :: Grid
easy                  =  ["2 8    9 ",
                          " 5 1     ",
                          "49   31 7",
                          "3  5  928",
                          " 8 49  63",
                          " 6  8  1 ",
                          "5 1 486  ",
                          "649  5  1",
                          "8 7 3  49"]   

difficult            :: Grid
difficult             =   ["     15 6",
                          "  56     ",
                          "8   4   9",
                          "  81  74 ",
                          "  2      ",
                          "  458   1",
                          "5  8 9 3 ",
                          "7  3   6 ",
                          "4 9 62 15"]


unsolvable           :: Grid
unsolvable            =   ["  96  1  ",
                          " 1 7   8 ",
                          "35  1    ",
                          "5     6  ",
                          "    42  1",
                          "  3    7 ",
                          "  5  6 1 ",
                          "  68  3 4",
                          " 8147 2  "]

----------------------------------------------------
-- PARTE DEL CODICE PER LA RISOLUZIONE DEL SUDOKU
----------------------------------------------------

----------------------------------------------------
-- DEFINIZIONI DI BASE PER LA RISOLUZIONE DEL SUDOKU
----------------------------------------------------

-- Funzione che indica la dimensione di un riquadro

boxsize               :: Int
boxsize               =  3

-- Funzione che indica il range del Values, da 1 a 9

values                :: [Value]
values                =  ['1'..'9']

{- Funzione che serve per indicare quando una casella è vuota, ovvero quando il suo valore è ' '. 
   -}

empty :: Value -> Bool
empty  ' '            = True
empty  _              = False
 
-- Funzione che indica se la lista è composta da un singolo elemento o meno

single                :: [a] -> Bool
single [_]            =  True
single _              =  False

---------------------------
--- FUNZIONI PER IL SOLVER
---------------------------

{- Funzione che estrae le righe dalla Griglia del Sudoku, restituendo una lista delle righe   
   dalla Matrix:
   Caso base: abbiamo una lista vuota, ritorna una lista vuota
   Caso base: lista interna vuota, ritorna una lista vuota
   Caso generale: estrae la prima riga dalla Matrix. 
 -} 

rows                  :: Matrix a -> [Row a]
rows []               = [] 
rows ([]:_)           = [] 
rows m                = m

{- Funzione che estrae le righe dalla Griglia del Sudoku, restituendo una lista delle colonne 
   dalla Matrix come una lista di righe
   Esempio: cols [[1,2],[3,4]] = [[1,3],[2,4]].
   Caso base: abbiamo una lista vuota, ritorna una lista vuota
   Caso base: lista interna vuota, ritorna una lista vuota
   Caso ricorsivo: estrae il primo elemento di ogni lista interna e crea una nuova riga, per i   
   numeri rimasti utilizza la ricorsione richiamando cols (mapping tail matrix) 
-}

cols :: Matrix a -> [Row a]
cols []               = [] 
cols ([]:_)           = [] 
cols matrix           = (map head matrix) : cols (map tail matrix) 


{- Funzione che estrae i riquadri 3x3 dalla Griglia del Sudoku, restituisce i riquadri come   
  delle righe della Matrix.
  pack applica la funzione split due volte alla matrice di input utilizzando la funzione map. 
  Suddivide la matrice in sottomatrici più piccole. 
  split suddivide la matrice di input in sottomatrici più piccole di dimensione boxsize.
  unpack concatena le sottomatrici per formare matrici più grandi utilizzando concat, quindi,    
  concatena le righe di tali matrici in una singola lista utilizzando mapping concat.
  concat è una funzione standard in Haskell che concatena una lista di liste in una singola 
  lista.
-}

boxs                  :: Matrix a -> [Row a]
boxs                   = unpack . (map cols) . pack
  where
    pack               = split . (map split)
    split              = chop boxsize
    unpack             = (map concat) . concat

{- Funzione che prende un intero n e una lista [a] in input e restituisce una lista di liste 
   [[a]], suddividendo la lista di input in sotto-liste di lunghezza n.
   Caso base: lista di input è vuota, restituisce una lista vuota.
   Caso ricorsivo: si usa la funzione take per prendere i primi n elementi della lista xs e la      
   funzione drop per rimuovere i primi n elementi dalla lista xs. Si concatena quindi una sotto-   
   lista contenente i primi n elementi con la chiamata ricorsiva chop n (drop n xs), che si   
   occupa di suddividere il resto della lista in sotto-liste di lunghezza n. Questo processo 
   continua fino a quando la lista xs non è più sufficientemente lunga per formare una sotto-
   lista di lunghezza n. 
   -}

chop                  :: Int -> [a] -> [[a]]
chop n []              =  []
chop n xs              =  take n xs : chop n (drop n xs)


{- La funzione valid prende una griglia Grid in input e restituisce un valore 
   booleano Bool che indica se la griglia è valida o no.
   Ovvero controlla se non ci sono duplicati in tutte le righe, colonne e sottomatrici
   della griglia utilizzando la funzione nodups. 
   Restituisce True solo se tutti i controlli sono soddisfatti, 
   altrimenti restituisce False.
-}

valid                 :: Grid -> Bool
valid g                =  all nodups (rows g) &&
                         all nodups (cols g) &&
                         all nodups (boxs g)

{- una funzione ausiliaria che prende una lista [a] in input e restituisce True se non 
   ci sono duplicati nella lista, altrimenti restituisce False.
   Caso base: restituisce True poichè una lista vuota non contiene duplicati;
   Caso ricorsivo: si verifica  se l'elemento x è presente nella lista xs utilizzando la funzione 
   elem. Se x è presente in xs, restituisce False, altrimenti si chiama ricorsivamente la 
   funzione nodups xs per controllare il resto della lista.
-}
nodups                :: Eq a => [a] -> Bool
nodups []              =  True
nodups (x:xs)          =  not (elem x xs) && nodups xs


-- Il tipo Choices viene definito come una lista di valori ([Value]).

type Choices           =  [Value]

{- La funzione utilizza la funzione ausiliaria choice per mappare ogni valore della griglia in   
   una lista di scelte. La funzione choice prende un valore v in input. Utilizza le guardie per 
  controllare se il valore èvuoto (empty v). Se il valore è vuoto, restituisce values, che   
  rappresenta tutte le possibili scelte. Altrimenti, restituisce una listacontenente solo il 
  valore v come scelta. La funzione map (map choice) g applica la funzione choice a ciascun 
  valore della griglia g, producendo una matrice di scelte corrispondente alla griglia di input.
-}

choices               :: Grid -> Matrix Choices
choices g              =  map (map choice) g
  where
    choice v 
      | empty v        = values 
      | otherwise      =  [v]

{- La funzione collapse prende una matrice di liste Matrix [a] in input e restituisce una lista 
   di matrici Matrix a ottenuta combinando tutte le possibili combinazioni degli elementi delle 
   liste all'interno della matrice di input.
   La funzione cp prende una lista di liste [[a]] in input e restituisce una lista di liste 
   [[a]] ottenuta combinando tutte le possibili combinazioni degli elementi delle liste di 
   input.
   Caso base: lista vuota, si restituisce una lista contenente una lista vuota [[[]]], 
   rappresentando il caso in cui non ci sono elementi da combinare.
   Caso ricorsivo: per ogni elemento y nella lista xs e per ogni combinazione ys ottenuta 
   chiamando ricorsivamente cp xss, si genera una lista [y:ys] rappresentante una possibile 
   combinazione degli elementi.
-}

collapse              :: Matrix [a] -> [Matrix a]
collapse               =  cp . map cp
  where
    cp                :: [[a]] -> [[a]]
    cp []              =  [[]]
    cp (xs:xss)        =  [y:ys | y <- xs, ys <- cp xss]

{- La funzione prune prende in input una matrice di scelte Matrix Choices e restituisce 
   una matrice di scelte in cui sono state eliminate alcune opzioni in base alle regole 
   specificate dalle funzioni boxs, cols e rows.
   La funzione pruneBy prende una funzione f come argomento. All'interno di pruneBy, 
   applicando f alla matrice di scelte tramite f . map reduce . f. 
   In particolare, map reduce viene applicata alla matrice di scelte prima e dopo l'applicazione 
   di f, consentendo di ridurre le opzioni in base alle regole specifiche.
-}

prune                 :: Matrix Choices -> Matrix Choices
prune                  = pruneBy boxs . pruneBy cols . pruneBy rows
  where 
    pruneBy f          = f . map reduce . f

{- La funzione reduce prende in input una riga di scelte Row Choices e restituisce una riga di 
   scelte in cui sono state ridotte alcune opzioni in base alle regole specificate.
   Nella funzione reduce, si utilizza una list comprehension per applicare la funzione minus a   
   ciascuna lista di scelte xs all'interno della riga di scelte xss. La lista singles viene 
   definita come la concatenazione delle liste di scelte che soddisfano il predicato single. 
   Successivamente, per ogni lista di scelte xs, si applica minus alla lista singles per 
   rimuovere le scelte presenti in singles dalla lista xs.
-}

reduce                :: Row Choices -> Row Choices
reduce xss             =  [xs `minus` singles | xs <- xss]
  where 
    singles            = concat (filter single xss)

{- La funzione minus prende in input due liste di scelte Choices e restituisce una lista di 
   scelte ottenuta rimuovendo dalla prima lista le scelte presenti nella seconda lista.
   La funzione minus prende due liste di scelte xs e ys. Se xs contiene una sola scelta 
  (determinato dal predicato single xs), viene restituita la lista xs stessa. In caso contrario, 
   viene utilizzato l'operatore \\ per rimuovere dalla lista xs le scelte presenti nella lista 
   ys.
-}

minus                 :: Choices -> Choices -> Choices
xs `minus` ys
    | single xs        = xs 
    | otherwise        = xs \\ ys


{- La funzione complete prende in input una matrice di scelte Matrix Choices e controlla se 
   ogni elemento della matrice è una scelta singola. Restituisce True se tutti gli elementi 
   sono scelte singole, indicando che la matrice è completa, e False altrimenti.
   Caso base: Una matrice vuota è considerata completa;
   Caso ricorsivo: Verifica se la riga corrente è completa e continua con il resto delle 
                   righe;
   Otherwise: Se una qualsiasi riga non è completa, la matrice non è completa;
-}

complete              :: Matrix Choices -> Bool
complete []            = True  
complete (row:rows)
  | all single row     = complete rows 
  | otherwise          = False          

{- La funzione void prende in input una matrice di scelte Matrix Choices e controlla se almeno 
   uno degli elementi della matrice è vuoto (cioè una lista vuota). Restituisce True se almeno 
   un elemento è vuoto, indicando che la matrice è incompleta o "vuota", e False altrimenti.
   Caso base: Una matrice vuota non è considerata vuota;
   Caso ricorsivo: 
      - Se la riga corrente contiene un elemento vuoto, la matrice è vuota;
      - Se la riga corrente non contiene elementi vuoti, continua con il resto delle righe;
-}

void                  :: Matrix Choices -> Bool
void []                = False   
void (row:rows)
  | any null row       = True     
  | otherwise          = void rows   

{- La funzione safe prende in input una matrice di scelte Matrix Choices e controlla se la 
   matrice è "sicura".
   Una matrice è considerata sicura se non contiene duplicati all'interno delle righe, delle 
   colonne e delle caselle.
   La funzione safe utilizza la funzione all per verificare se la condizione consistentRow è 
   verificata per tutte le righe, colonne e caselle della matrice.
-}

safe                  :: Matrix Choices -> Bool
safe cm
  | allRowsConsistent && allColsConsistent && allBoxsConsistent = True
  | otherwise                                                   = False
  where
    allRowsConsistent  = all consistentRow (rows cm)
    allColsConsistent  = all consistentRow (cols cm)
    allBoxsConsistent  = all consistentRow (boxs cm)

{- La funzione consistentRow controlla se la riga soddisfa due condizioni:
   Non ci sono duplicati nella riga, utilizzando la funzione nodups che controlla se ogni 
   elemento non è presente nel resto della lista.
   Ogni scelta nella riga è singola, utilizzando la funzione single che verifica se la lunghezza 
   delle scelte è uguale a 1.
-}

consistentRow        :: Row Choices -> Bool
consistentRow row
  | noduplicates      = True
  | otherwise         = False
  where 
    noduplicates      = nodups (concat (filter single row))

{- La funzione search esplora le diverse possibili configurazioni della griglia, espandendo la 
   matrice di scelte, potando le opzioni non valide e continuando la ricerca in modo ricorsivo.
   Caso base: Se la matrice è bloccata, restituisce una lista vuota;
   Altrimenti, cerca i seguenti casi:
    - Se la matrice è completa, restituisce la matrice stessa dopo averla convertita in una 
      lista di griglie;
    - Altrimenti, espande la matrice, la sottopone a potatura e richiama ricorsivamente la 
      funzione di ricerca per ogni matrice ottenuta;
-}

search                :: Matrix Choices -> [Grid]
search m
  | blocked m          =  []  
  | complete m         =  collapse m  
  | otherwise          =  [g | m' <- expand m  
                             , g  <- search (prune m')] 

{- La funzione blocked verifica se la matrice è bloccata, ossia se è vuota o non è sicura. 
   Due casi: 
   1. Se la matrice è vuota, è bloccata;
   2. Altrimenti, verifica se la matrice non è sicura.
-}

blocked               :: Matrix Choices -> Bool
blocked m
  | void m             = True
  | otherwise          = not (safe m)

{- La funzione expand genera tutte le possibili estensioni della matrice aggiungendo un elemento 
   singolo in ogni cella possibile.
   Divide la matrice in due parti: le righe precedenti al primo elemento non singolo nella riga 
   corrente e le righe successive;
   Divide la riga corrente in due parti: gli elementi precedenti al primo elemento non singolo 
   e gli elementi successivi.
-}

expand                :: Matrix Choices -> [Matrix Choices]
expand m               =
    [rows1 ++ [row1 ++ [c] : row2] ++ rows2 | c <- cs]
    where
       (rows1,row:rows2) = break (any (not . single)) m
       (row1,cs:row2)    = break (not . single) row

{- La funzione solve utilizza la funzione choices per generare una matrice di scelte Matrix 
   Choices a partire dalla griglia iniziale. Successivamente, questa matrice viene passata alla 
   funzione prune per potare le scelte non valide. Infine, la matrice risultante viene utilizzata 
   come input per la funzione search, che esegue l'algoritmo di ricerca delle soluzioni   
   possibili.
-}

solve                :: Grid -> [Grid]
solve g               =  search ( prune( choices g))  


-------------------------------------------------------------------------
---- Converte la griglia in una stringa con indici per le righe e colonne
-------------------------------------------------------------------------

{- La funzione gridStr prende una griglia Grid come argomento e restituisce una rappresentazione 
   testuale della griglia in forma di stringa.
   La funzione gridStr sfrutta diverse funzioni di supporto per creare la rappresentazione della 
   griglia. rowStr inserisce una barra verticale tra i caratteri di ogni riga. lRowStr aggiunge 
   un prefisso numerico a ogni riga. 
   letterH aggiunge un prefisso numerico a ogni colonna. Infine, rowSep genera i separatori di 
   riga con linee tratteggiate.
   La funzione gridStr combina tutte le parti insieme utilizzando intercalate per separarle 
   correttamente. La stringa finale rappresenta la griglia con i numeri di riga e colonna, le 
   barre verticali e i separatori di riga.
-}

gridStr              :: Grid -> String
gridStr grid          =
  letterH ++ "\n\n" ++ (intercalate rowSep $ lRowStr $ map rowStr grid)
  where
    width             = length $ head grid
    rowStr            = intercalate " | " . map (\x -> [x])
    lRowStr s         = [(show n) ++ "  " ++ x | n <- [0..(length s)-1], x <- [s!!n]]
    letterH           = "   " ++ (intercalate "   " $ strArr $ take width ['0'..])
    rowSep            = "\n   " ++ (tail $ init $ intercalate "+" $ take width $ repeat "---") ++ "\n"





