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
    | length xs < n = xs
    | otherwise = (take (n-1) part) ++ (dropEvery rest n)
        where (part, rest) = splitAt n xs

dropEvery' :: [a] -> Int -> [a]
dropEvery' [] = []
dropEvery' (x:xs) n =
        helper :: [a] -> Int -> [a]
