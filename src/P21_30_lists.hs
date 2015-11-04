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
    rnd_permu_fast1,
    rnd_permu_fast2,

    combinations,

    lsort,
    lsort',
    lsortb,
    )
where

import Data.Eq
import Data.List (group, nub, sortBy, groupBy)

import Control.Monad (replicateM)
import Control.Applicative
import System.Random (getStdRandom, randomR, randomRs, randomRIO, getStdGen)
import Data.Map (toAscList, fromList)
import Data.List.Ordered (sortOn)
import Data.Function (on)

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

diff_select_fast :: Int -> Int -> IO [Int]
diff_select_fast n limit
    | n<1 = return []
    | n>(limit-1) = return []
    | otherwise = dsf [1..n] limit

dsf :: [Int] -> Int -> IO [Int]
dsf [] _ = return []
dsf xs 0 = return xs
--dsf xs l = do i<-getStdRandom (randomR(0,length xs -1)) return [xs!!i]
dsf xs l = do
    i<-getStdRandom (randomR(0,length xs -1)) 
    let x = xs!!i
    rest <- (dsf (take i xs ++ drop i xs) (l-1))
    let result = x:rest
    return result

-- 25
rnd_permu :: [a] -> IO [a]
rnd_permu [] = return []
rnd_permu xs = map (xs!!) <$> take (length xs) . nub . randomRs(0, length xs -1) <$> getStdGen

--rnd_permu_fast xs = return $ map (snd) toAscList (fromList zip (randomRs(1,length xs) <$> getStdGen) xs)
rnd_permu_fast1 :: [a] -> IO [a]
rnd_permu_fast1 [] = return []
rnd_permu_fast1 xs = do
    i <- getStdRandom (randomR (0,length xs - 1))
    let x = xs!!i
    rest <- rnd_permu_fast1 ( (take i xs) ++ (drop (i+1) xs) )
    let result = x:rest
    return result


--rnd_permu_fast xs = return $ map (snd) toAscList (fromList zip (randomRs(1,length xs) <$> getStdGen) xs)
--WRONG: declining randomness of the result
rnd_permu_fast2 :: [a] -> IO [a]
rnd_permu_fast2 [] = return []
rnd_permu_fast2 xs = do
    i <- getStdRandom (randomR (0,length xs - 1))
    let x = xs!!i
    rest1 <- rnd_permu_fast2(take i xs)
    rest2 <- rnd_permu_fast2(drop (i+1) xs)
    let result = x:(rest1++rest2)
    return result


combinations :: Int -> [a] -> [[a]]
combinations 0 _ = [[]]
combinations _ [] = []
combinations l (x:xs) = (map (x:) (combinations (l-1) xs)) ++ (combinations l xs)

lsort :: [[a]] -> [[a]]
lsort = sortBy (\a b -> compare (length a) (length b)) 

lsort' :: [[a]] -> [[a]]
lsort' = sortOn length

lsortb :: Eq a => [[a]] -> [[a]]
lsortb = map fst . concat . sortOn length . groupBy ((==) `on` snd) . sortOn snd . map ( \x -> (x, length x) )


