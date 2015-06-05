module P11_20_lists
    (
    EncodedListItem(..),
    encodeModified,
    test_encodeModified,

    decodeModified,
    test_decodeModified,

    encodeDirect,
    encodeDirect',
    test_encodeDirect,

    test_myDuplicate,

    test_myReplicate,

    dropEvery,
    dropEvery',
    test_dropEvery,

    mySplitAt,
    test_mySplitAt,

    mySlice,
    mySlice',
    test_mySlice,

    myRotate,
    )
where

import Data.Eq
import Data.List (group)
import P01_10_lists (myEncode)


------------------------------ 11 ------------------------------

data EncodedListItem a = Single a | Multiple Int a deriving (Show, Eq)

encodeModified :: Eq a => [a] -> [EncodedListItem a]
encodeModified xs = [item | x <- group xs, let item = if length x == 1 then Single (head x) else Multiple (length x) (head x)]

encodeItem :: Eq a => (Int, a) -> EncodedListItem a
encodeItem (1,x) = Single x
encodeItem (n,x) = Multiple n x


encodeModified' :: Eq a => [a] -> [EncodedListItem a]
encodeModified' xs = map (encodeItem)  (myEncode xs)

test_encodeModified :: Eq a => [a] -> Bool
test_encodeModified xs = (encodeModified xs) == (encodeModified' xs)


------------------------------ 12 ------------------------------

decodeModified :: [EncodedListItem a] -> [a]
--decodeModified xs = foldl (\acc x -> acc ++ decodeItem x) [] xs
decodeModified xs = concatMap decodeItem xs
    where
        decodeItem (Single x) = [x]
        decodeItem (Multiple n x) = replicate n x

test_decodeModified :: Eq a => [a] -> Bool
test_decodeModified xs = (xs) == decodeModified (encodeModified xs)


------------------------------ 13 ------------------------------

encodeDirect :: Eq a => [a] -> [EncodedListItem a]
encodeDirect [] = []
encodeDirect (x:xs) = encodeDirect1 1 x xs

encodeDirect1 :: Eq a => Int -> a -> [a] -> [EncodedListItem a]
encodeDirect1 n y [] = [encodeItem (n, y)]
encodeDirect1 n y (x:xs) | x==y = encodeDirect1 (n+1) y xs
                         | otherwise = (encodeItem (n, y)):(encodeDirect1 1 x xs)

encodeDirect' :: Eq a => [a] -> [EncodedListItem a]
encodeDirect' [] = []
encodeDirect' (x:xs) = (encodeItem (n,x)):(encodeDirect' rest)
    where
        (matched, rest) = span (==x) xs
        n = 1 + length matched

test_encodeDirect :: Eq a => [a] -> Bool
test_encodeDirect xs = (encodeDirect xs)==(encodeDirect' xs)

------------------------------ 14 ------------------------------

-- TODO: check applicative and list monad solutions
myDuplicate :: [a] -> [a]
myDuplicate = concatMap (\x -> [x,x])

myDuplicate' :: [a] -> [a]
myDuplicate' [] = []
myDuplicate' (x:xs) = x:x:(myDuplicate' xs)

test_myDuplicate :: Eq a => [a] -> Bool
test_myDuplicate xs = (myDuplicate xs) == (myDuplicate' xs)


------------------------------ 15 ------------------------------

myReplicate :: [a] ->  Int -> [a]
myReplicate xs n = concatMap (replicate n) xs

test_myReplicate :: Eq a => [a] -> Bool
test_myReplicate xs = ((myDuplicate . myDuplicate) xs) == (myReplicate xs 4)


------------------------------ 16 ------------------------------

dropEvery :: [a] -> Int -> [a]
dropEvery xs n
    | n < 1 = []
    | length xs < n = xs
    | otherwise = (take (n-1) part) ++ (dropEvery rest n)
        where (part, rest) = splitAt n xs

dropEvery' :: [a] -> Int -> [a]
dropEvery' [] _ = []
dropEvery' xs n
    | n < 1 = []
    | otherwise = helper xs n n
        where
            helper :: [a] -> Int -> Int -> [a]
            helper [] _ _ = []
            helper (x:xs) n 1 = helper xs n n
            helper (x:xs) n c = x:(helper xs n (c-1))

test_dropEvery :: Eq a => [a] -> Int -> Bool
test_dropEvery xs n = (dropEvery xs n) == (dropEvery' xs n)


------------------------------ 17 ------------------------------

mySplitAt :: [a] -> Int -> ([a],[a])
mySplitAt [] _ = ([],[])
mySplitAt xs n
    | n < 1 = ([],xs)
    | otherwise = mySplitAt' xs n
        where
            mySplitAt' :: [a] -> Int -> ([a],[a])
            mySplitAt' [] _ = ([],[])
            mySplitAt' (x:xs) 1 = ([x],xs)
            mySplitAt' (x:xs) n = (x:first, rest)
                where
                    (first,rest) = mySplitAt' xs (n-1)

test_mySplitAt :: Eq a => [a] -> Int -> Bool
test_mySplitAt xs n = (mySplitAt xs n) == (splitAt n xs)


------------------------------ 18 ------------------------------

mySlice :: [a] -> Int -> Int -> [a]
mySlice [] _ _ = []
mySlice xs from to
    | from > to = []
    | from < 1 = mySlice xs 1 to
    | otherwise =  take (to-from+1) (drop (from-1) xs)

mySlice' :: [a] -> Int -> Int -> [a]
mySlice' [] _ _ = []
mySlice' xs from to
    | from > to = []
    | from < 1 = mySlice xs 1 to
    | otherwise = map snd $ filter (\(i,_) -> i>=from && i<=to ) $ zip [1..] xs

test_mySlice :: Eq a => [a] -> Int -> Int -> Bool
test_mySlice xs from to = (mySlice xs from to) == (mySlice' xs from to)


------------------------------ 19 ------------------------------

myRotate :: [a] -> Int -> [a]
myRotate [] _ = []
myRotate xs at
    | at < 0 = myRotate xs (at + len)
    | at > len = myRotate xs (at `mod` len)
    | otherwise = drop at xs ++ take at xs
        where len = length xs

