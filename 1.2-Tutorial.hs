Type Haskell expressions in here.
λ next
λ preb
Not in scope: `preb'
Perhaps you meant `pred' (imported from Prelude)
λ prev
λ f x = x+1
:: ? -> ?
λ f 3
4
:: Num a => a
λ add3nums x y z = x + y + z
:: ? -> ?
λ 10 + 4* add3nums 1 2 3
34
:: Num a => a
λ (\x -> x+1) 4
5
:: Num a => a
λ fl = \x -> x+1
x + 1
:: Expr
λ fl 4
5
:: Num a => a
λ add3numsl = \x y z -> x + y + z
x + y + z
:: Expr
λ 10 + 4* add3numsl 1 2 3
34
:: Num a => a
λ [2.718, 50.0, -1.0]
[2.718,50.0,-1.0]
:: Fractional t => [t]
λ [1,2,4,8]
[1,2,4,8]
:: Num t => [t]
λ length ["A", "list", "of","strings"]
4
:: Int
λ sumprod = \x y -> [x+y,x*y]
[x + y,x * y]
:: [Expr]
λ sumprod 3 8
[11,24]
:: Num t => [t]
λ mylist = [2,4,6,8]
[2,4,6,8]
:: Num t => [t]
λ answer=42
42
:: Num a => a
λ yourlist = [7,answer+1, 7*8]
[7,43,56]
:: Num a => [a]
λ yourlist
[7,43,56]
:: Num a => [a]
λ 23 : [48,41,44]
[23,48,41,44]
:: Num a => [a]
λ 42 : []
[42]
:: Num a => [a]
λ [23,29] ++ [48,41,44]
[23,29,48,41,44]
:: Num a => [a]
λ length [23,29] + length [48,41,44] == length([23,29] ++ [48,41,44])
True
:: Bool
λ [0..5]
[0,1,2,3,4,5]
:: (Enum t, Num t) => [t]
λ [0x0A..0x1F]
[10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31]
:: (Enum t, Num t) => [t]
λ ['a','d'..'z']
"adgjmpsvy"
:: [Char]
λ [3*x | x <- [1..10]]
[3,6,9,12,15,18,21,24,27,30]
:: (Enum t, Num t) => [t]
λ [2*x+1 | x <- [0,2..10]]
[1,5,9,13,17,21]
:: (Enum t, Num t) => [t]
λ [[a,b] | a <- [10,11,12], b <- [20,21]]
[[10,20],[10,21],[11,20],[11,21],[12,20],[12,21]]
:: Num t => [[t]]
λ [5,3,8,7] !! 2
8
:: Num a => a
λ prev
λ next
λ ['a'..'z'] !! 33
*Exception: Prelude.!!: index too large
λ head [4,5,6]
4
:: Num a => a
λ tail [4,5,6]
[5,6]
:: Num a => [a]
λ head []
Sorry, I can't display this result.
λ head [] :: [Int]
*Exception: Prelude.head: empty list
λ prev
λ prev
λ next
λ tail [] :: [Int]
*Exception: Prelude.tail: empty list
λ next
λ  
