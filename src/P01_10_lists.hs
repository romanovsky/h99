module P01_10_lists
    (
    p01_myLast,
    p01_myLast',
    p01_myLast'',
    p01_myLast''',
    p01_myLast'''',
    test_p01_myLast,

    p02_myButLast,
    p02_myButLast',
    test_p02_myButLast,

    p03_elementAt,
    test_p03_elementAt,

    p04_myLength,
    test_p04_myLength,

    myReverse,
    myReverse',
    test_myReverse,

    isPalindrome,
    test_isPalindrome,

    test_myFlatten,

    myCompress,
    myCompress',
    test_myCompress,

    myPack,
    test_myPack,

    myEncode,
    myEncode',
    test_myEncode,
    )
where

import Data.Eq
import qualified Data.Map.Strict as Map
import Data.List (group)
import Test.QuickCheck (Testable)


------------------------------ 01 ------------------------------
p01_myLast :: [a] -> a
p01_myLast xs = xs!!(length xs - 1)

p01_myLast' :: [a] -> a
p01_myLast' = foldr1 (flip const)

p01_myLast'' :: [a] -> a
p01_myLast'' = foldr1 (const id)

p01_myLast''' :: [a] -> a
p01_myLast''' [x] = x
p01_myLast''' (_:xs) = p01_myLast''' xs

p01_myLast'''' :: [a] -> a
p01_myLast'''' xs = head $ reverse xs

p01_myLast''''' :: [a] -> a
p01_myLast''''' xs = foldl1 (curry snd) xs

test_p01_myLast :: Eq a => ([a]->a) ->[a] -> Bool
test_p01_myLast f ([]) = True
test_p01_myLast f (xs) = f(xs) == last xs


------------------------------ 02 ------------------------------

p02_myButLast :: [a] -> a
p02_myButLast [] = error "too few elements"
p02_myButLast [x] = error "too few elements"
p02_myButLast [x,_] = x
p02_myButLast (_:xs) = p02_myButLast xs

p02_myButLast' :: [a] -> a
p02_myButLast' = last . init

test_p02_myButLast :: Eq a => ([a]->a) ->[a] -> Bool
test_p02_myButLast f ([]) = True
test_p02_myButLast f ([x]) = True
test_p02_myButLast f (xs) = f(xs) == xs!!(length xs - 2)


------------------------------ 03 ------------------------------

p03_elementAt :: Eq a => [a] -> Int -> a
p03_elementAt (x:_) 1 = x
p03_elementAt (_:xs) i = p03_elementAt xs (i-1)

test_p03_elementAt :: Eq a => ([a]->Int->a) ->[a] -> Int -> Bool
test_p03_elementAt f ([]) i = True
test_p03_elementAt f ([x]) i = True
test_p03_elementAt f xs i
    | length(xs) < i = True -- it's out of bounds
    | otherwise = f xs i == xs!!i


------------------------------ 04 ------------------------------

p04_myLength :: [a] -> Int
p04_myLength [] = 0
p04_myLength xs = foldr (\x acc -> acc+1) 0 xs

test_p04_myLength :: ([a] -> Int) -> [a] -> Bool
test_p04_myLength f xs = (f xs) == (length xs)


------------------------------ 05 ------------------------------

myReverse :: [a] -> [a]
myReverse [] = []
myReverse xs = foldl (\acc x -> x:acc) [] xs

myReverse' :: [a] -> [a]
myReverse' [] = []
myReverse' xs = foldl ( flip (:) ) [] xs

test_myReverse :: Eq a => ([a] -> [a]) -> [a] -> Bool
test_myReverse f xs = (f xs) == (reverse xs)


------------------------------ 06 ------------------------------

isPalindrome :: Eq a => [a] -> Bool
isPalindrome [] = True
isPalindrome [_] = True
isPalindrome xs = ( (head xs) == (last xs) ) && ( isPalindrome $ init $ tail xs)

test_isPalindrome :: Eq a => ([a] -> Bool) -> [a] -> Bool
test_isPalindrome f xs = (f xs) == (xs == reverse xs)


------------------------------ 07 ------------------------------

data NestedList a = Elem a | List [NestedList a]

myFlatten :: NestedList a -> [a]
myFlatten (Elem a) = [a]
myFlatten (List (x:xs)) = myFlatten x ++ myFlatten (List xs)
myFlatten (List []) = []

myFlatten' :: NestedList a -> [a]
myFlatten' (Elem a) = [a]
myFlatten' (List xs) = foldr ( \x acc -> (myFlatten' x) ++ acc) [] xs

myFlatten'' :: NestedList a -> [a]
myFlatten'' (Elem a) = [a]
myFlatten'' (List xs) = foldr (++) [] $ map myFlatten'' xs

test_myFlatten :: Bool
test_myFlatten = res == res' && res == res'' where
    testData = (List [Elem 1, Elem 2, Elem 3, List [Elem 4], Elem 5])
    res     = myFlatten     testData
    res'    = myFlatten'    testData
    res''   = myFlatten''   testData


------------------------------ 08 ------------------------------
--myCompress :: Ord a => [a] -> [a]
--myCompress xs = Set.toList(Set.fromList xs)

myCompress :: Eq a => [a] -> [a]
myCompress [] = []
myCompress xs = foldl (\acc x -> if ((not $ null acc) && x == last acc) then acc else acc ++ [x]) [] xs

myCompress' :: Eq a => [a] -> [a]
myCompress' [] = []
myCompress' xs = map head . group $ xs

test_myCompress :: Ord a => [a] -> Bool
test_myCompress xs = res == res' where
    res = myCompress xs
    res' = myCompress' xs


------------------------------ 09 ------------------------------

myPack :: Eq a => [a] -> [[a]]
myPack [] = []
myPack xs = foldl (\acc x -> if ((not $ null acc) && (not $ null $ last acc) && x == head (last acc)) then acc else acc ++ [[x]]) [[]] xs


test_myPack :: Eq a => ([a] -> [[a]]) -> [a] -> Bool
test_myPack f xs = (f xs) == (group xs)

------------------------------ 10 ------------------------------

myEncode :: Eq a => [a] -> [(Int, a)]
myEncode xs = foldr (\x acc -> (length(x), head x):acc ) [] (group xs)

myEncode' :: Eq a => [a] -> [(Int, a)]
myEncode' = map ( \x -> (length x, head x)) . group

test_myEncode :: Eq a => [a] -> Bool
test_myEncode xs = (myEncode xs) == (myEncode' xs)
