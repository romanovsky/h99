module P21_30_lists
    (
    myRange,
    myRange',
    myRange'',
    test_myRange
    )
where

import Data.Eq
import Data.List (group)

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

test_myRange :: Int -> Int -> Bool
--test_myRange i j = (myRange i j) == (myRange' i j) && (myRange i j) == (myRange'' i j)
test_myRange i j = (myRange' i j) == (myRange'' i j)
