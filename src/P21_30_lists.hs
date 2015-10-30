module P21_30_lists
    (
    myRange,
    myRange',
    myRange'',
    test_myRange,

    rnd_select,
    rnd_select',

    diff_select,

    rnd_permu,
    rnd_permu_fast
    )
where

import Data.Eq
import Data.List (group, nub)

import Control.Monad (replicateM)
import Control.Applicative
import System.Random (getStdRandom, randomR, randomRs, randomRIO, getStdGen)
import Data.Map (toAscList, fromList)

-- 22
myRange :: Int -> Int -> [Int]
myRange i j
    | i == j = [i]
    | i > j = []
    | otherwise = [i..j]

myRange' :: Int -> Int -> [Int]
myRange' i j
    | i == j = [i]
    | i > j = []
    | otherwise = myRangeHelper i j []
        where
            myRangeHelper i j xs
                | i' == j = xs ++ [i,j]
                | otherwise = myRangeHelper i' j (xs++[i])
                where i' = i + 1

myRange'' :: Int -> Int -> [Int]
myRange'' i j
    | i == j = [i]
    | i > j = []
    | otherwise = myRangeHelper i j []
        where
            myRangeHelper i j xs
                | j' == i = i:j:xs
                | otherwise = myRangeHelper i j' (j:xs)
                where j' = j - 1

myRange''' :: Int -> Int -> [Int]
myRange''' i j
    | i == j = [i]
    | i > j = []
    | otherwise = scanl (+) i (replicate (j-i) 1)


test_myRange :: Int -> Int -> Bool
--test_myRange i j = (myRange i j) == (myRange' i j) && (myRange i j) == (myRange'' i j)
--test_myRange i j = (myRange' i j) == (myRange'' i j) && (myRange i j) == (myRange''' i j)
test_myRange i j = (myRange'' i j) == (myRange''' i j)

-- 23
rnd_select :: [a] -> Int -> IO [a]
rnd_select [] _ = return []
rnd_select _ 0 = return []
rnd_select xs n = rnd_select' [] xs n
    where
        rnd_select' :: [a] -> [a] -> Int -> IO [a]
        rnd_select' ys xs i
            | i==0 = return ys
            | otherwise = do
                             rndi <- getStdRandom (randomR (0,length xs - 1))
                             let (xshead,xstail) = splitAt rndi xs
                             rnd_select' (head xstail:ys) (xshead++(tail xstail)) (i-1)


rnd_select' :: [a] -> Int -> IO [a]
rnd_select' [] _ = return []
rnd_select' _ 0 = return []
rnd_select' xs n = map (xs!!) <$> randomIndices
    where
        randomIndices = take n . nub . randomRs (0, length xs - 1) <$> getStdGen


-- 24
diff_select :: Int -> Int -> IO [Int]
diff_select n limit
    | n<1 = return []
    | n>(limit-1) = return []
    | otherwise = take n . nub . randomRs (1, limit) <$> getStdGen

-- 25
rnd_permu :: [a] -> IO [a]
rnd_permu [] = return []
rnd_permu xs = map (xs!!) <$> take (length xs) . nub . randomRs(0, length xs -1) <$> getStdGen

--rnd_permu_fast xs = return $ map (snd) toAscList (fromList zip (randomRs(1,length xs) <$> getStdGen) xs)
rnd_permu_fast :: [a] -> IO [a]
rnd_permu_fast [] = return []
rnd_permu_fast xs = do
    i <- getStdRandom (randomR (0,length xs - 1))
    let x = xs!!i
    rest <- rnd_permu_fast ( (take i xs) ++ (drop (i+1) xs) )
    let result = x:rest
    return result


