module P11_20_lists
    (
    EncodedListItem(..),
    encodeModified,
    test_encodeModified,
    decodeModified,
    test_decodeModified,
    test_encodeDirect,
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

test_encodeDirect :: Eq a => [a] -> Bool
test_encodeDirect xs = (encodeDirect xs)==(encodeModified xs)
