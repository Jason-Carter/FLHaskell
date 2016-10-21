-- Exploration of infinite lists

-- Prime Numbers
properfactors :: Int -> [Int]
properfactors x = filter (\y->(x `mod` y == 0)) [2..(x-1)]

numproperfactors :: Int -> Int
numproperfactors x = length (properfactors x)

primes :: [Int]
primes = filter (\x-> (numproperfactors x == 0)) [2..]

-- Pascal's Triangle
-- Taken from:
--   https://www.futurelearn.com/courses/functional-programming-haskell/1/steps/121453/comments?page=1#comment_16767889
pt xs = xs : pt (zipWith (+) (0:xs) (xs++[0]))
take 6 $ pt [1]

-- Not sure how the Pascal's Triangle works yet. It pads the ends of each line with 0s (to match the next line) then sums the columns. Also, what does the $ do?