-- [6] Implement hide which converts the letters of a word to asterisks
-- use only a list comprehension
hide :: String -> String
hide w = [ "*" | x <- w ]


--Prelude> take (length "Jason") (repeat "*")
--["*","*","*","*","*"]
--Prelude> [ "*" | x <- "secret"]
--["*","*","*","*","*","*"]


-- expected behaviour
--hide "secret" == "******"
--hide "out"    == "***"
