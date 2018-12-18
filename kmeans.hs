module Kmeans where

import System.Random

type Point = (Int, Int)
type Mean  = (Float, Float)
type Cluster = [Point]

i2f :: (Integral a, Num b) => a -> b
i2f = fromIntegral

p2f :: Point -> (Float, Float)
p2f (x, y) = (i2f x, i2f y)

-- distance squared between 2 points
dist :: (Float, Float) -> (Float, Float) -> Float
dist (x1,y1) (x2,y2) = (x1 - x2)^^2 + (y1 - y2)^^2

-- find index of closest point in list
closest :: Point -> [Mean] -> Int
closest p ms = (snd . minimum) $ zip (map ((dist . p2f) p) ms) [0..]

-- Updates a list of lists by adding an item to
-- one of the lists. The list to be augmented is
-- specified by its index within the list of lists.
add2List :: [[a]] -> a -> Int -> [[a]]
add2List xss x i = take i xss ++ [x : (xss !! i)] ++ drop (i + 1) xss

-- partition points into clusters by
-- assigning each point to the mean point
-- that it is closest to.
assign :: [Point] -> [Mean] -> [Cluster]
assign ps ms = foldr acc zero ps
  where
    --
    -- add p to cluster with closest mean
    acc :: Point -> [Cluster] -> [Cluster]
    acc p cs = add2List cs p $ closest p ms
    --
    -- init with an empty cluster for each mean in ms
    zero :: [Cluster]
    zero = replicate (length ms) []

-- add 2 points together pointwise
add :: Point -> Point -> Point
add (x1,y1) (x2,y2) = (x1+x2, y1+y2)

-- multiply point co-ords by some factor
mult :: Float -> Point -> (Float, Float)
mult k (x,y) = (k * i2f x, k * i2f y)

-- find mean point of cluster
-- i.e. (average x co-ord, average y co-ord)
mean :: Cluster -> Mean
mean [] = (0,0)
mean c  = mult (1 / i2f (length c)) $ foldr add (0,0) c

-- calculate new means by finding mean of
-- each cluster in list of clusters
means :: [Cluster] -> [Mean]
means = map mean

-- updates a value using a function until the value stabilizes
stabilize :: Eq a => a -> (a -> a) -> a
stabilize x f = let x' = f x
                in if x == x' then x else stabilize x' f

-- initialize k means by taking the first k points
kInit :: Int -> [Point] -> [Mean]
kInit k ps = map (\(x,y) -> (i2f x, i2f y)) $ take k ps

-- initialize k clusters in round-robin fashion
cInit :: Int -> [Point] -> [Cluster]
cInit k ps = snd $ foldr acc zero ps
  where
    zero = (0, replicate k [])
    acc pt (i, css) = ((i + 1) `mod` k, add2List css pt i)

kmeans :: Int -> [Point] -> [Cluster]
kmeans k ps = stabilize initClusters updateClusters
  where
    --
    -- assign points to clusters
    initClusters :: [Cluster]
    initClusters = cInit k ps
    --
    -- calc new means from clusters then re-assign clusters
    updateClusters :: [Cluster] -> [Cluster]
    updateClusters = assign ps . means

-------------------------------------------------------------
--------------------- Screen utilities ----------------------
-------------------------------------------------------------
-- animate algorithm using generated random data
-- size: number of lines in grid
-- k: number of clusters to find
-- delay: to slow animation down ~30
animate :: Int -> Int -> Int -> IO ()
animate size k delay = do
    ps <- randomPoints size k
    go ps $ cInit k ps
  where go ps cs = do
          printClusters size cs
          wait delay
          let cs' = (assign ps . means) cs
          if cs == cs'
            then putMsg "Complete!!!" (0,0)
            else go ps cs'

plot :: Int -> (Int, Int) -> IO ()
plot i (x,y) = do
    putStrLn $ "\ESC[4" ++ [['1'..] !! (i `mod` 6)] ++ "m"
    putStr ("\ESC[" ++ show (y+2) ++ ";" ++ show (2*x+2) ++ "H")
    putChar ' '
    putStr ("\ESC[1;1H")
    resetColor

putMsg :: String -> (Int, Int) -> IO ()
putMsg s (x,y) = do
    resetColor
    putStr ("\ESC[" ++ show (y+1) ++ ";" ++ show (x+1) ++ "H")
    putStr s

cls :: Int -> IO ()
cls size = sequence_
    [ putStrLn $ "\ESC[" ++ show r ++ ";1H\ESC[2K" | r <- [1..size+1] ]

resetColor :: IO ()
resetColor = putStr "\ESC[37m\ESC[40m"

wait :: Int -> IO ()
wait t = sequence_ $ replicate t (go 15)
    where go n = if n > 0
                   then do go (n-1); go (n-1)
                   else return ()

printClusters :: Int -> [Cluster] -> IO ()
printClusters size cs = do
    cls size
    sequence_ $ concat $ zipWith (map . plot) [1..] cs
-------------------------------------------------------------
--------------------- random data ---------------------------
-------------------------------------------------------------
normalVar :: Mean -> Int -> Int -> IO Point
normalVar (x,y) steps size =
    if steps == 0 then return (bound x size, bound y size)
      else do
        x' <- randomRIO (-1.0, 1.0)
        y' <- randomRIO (-1.0, 1.0)
        normalVar (x+x', y+y') (steps - 1) size

bound :: Float -> Int -> Int
bound x size = let x' = round x in min (size - 1) $ max 0 x'

randomMean :: Int -> IO Mean
randomMean size = do
    x <- randomRIO (i2f size / 5, i2f size * 4 / 5)
    y <- randomRIO (i2f size / 5, i2f size * 4 / 5)
    return (x,y)

randomMeans :: Int -> Int -> IO [Mean]
randomMeans size k = do
    mss <- sequence $ replicate 10 genMs
    return $ snd $ maximum [ (spread ms, ms) | ms <- mss ]
  where
    genMs = sequence $ replicate k (randomMean size)
    spread ms = sum [ sqrt $ dist m1 m2 | m1 <- ms, m2 <- ms]

randomPoints :: Int -> Int -> IO [Point]
randomPoints s k = do
    ms <- randomMeans s k
    randPts ms ((s * s) `div` 5)
  where
    randPts ms n = if n == 0
      then return []
      else do
          pts <- randPts ms (n - 1)
          pt  <- randPt ms pts
          return $ pt : pts
    randPt  ms pts = do
      i   <- randomRIO (0, k-1)
      pt  <- normalVar (ms !! i) s s
      if pt `elem` pts then randPt ms pts else return pt

