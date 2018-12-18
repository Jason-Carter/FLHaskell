main = do
    putStrLn "Hello. What is your name?"
    x <- getLine
    putStrLn ("Nice to meet you, " ++ x)

