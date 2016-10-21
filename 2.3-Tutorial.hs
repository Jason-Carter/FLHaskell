Type Haskell expressions in here.
λ putStrLn "hello world"
hello world
:: IO ()
λ putStrLn ("good " ++ "morning" ++ " everyone")
good morning everyone
:: IO ()
λ getLine
> Jason
"Jason"
:: IO String
λ do {putStrLn "what is your name?"; x <- getLine; putStrLn ("hello " ++ x) }
what is your name?
> Jason
hello Jason
:: IO ()
λ do { putStrLn "what is your name?"; n<-getLine; let nUpper = map toUpper n in putStrLn ("HELLO " ++ nUpper) }
what is your name?
> Jason
HELLO JASON
:: IO ()
λ read "42" :: Int
42
:: Int
λ read "42" :: Float
42.0
:: Float
λ show 42
"42"
:: String
λ putStrLn(show (6*7))
42
:: IO ()
λ print 42
42
:: IO ()
λ  
