module P11_20_lists
    (
    EncodedListItem(..),
    encodeModified,
    test_encodeModified,
    decodeModified,
    test_decodeModified,
    )
where

import Data.Eq
import Data.List (group)
import P01_10_lists (myEncode)


------------------------------ 11 ------------------------------

data EncodedListItem a = Single a | Multiple Int a deriving (Show, Eq)

encodeModified :: Eq a => [a] -> [EncodedListItem a]
encodeModified xs = [item | x <- group xs, let item = if length x == 1 then Single (head x) else Multiple (length x) (head x)]

encodeModified' :: Eq a => [a] -> [EncodedListItem a]
encodeModified' xs = map (encodeItem)  (myEncode xs)
    where
        encodeItem (1,x) = Single x
        encodeItem (n,x) = Multiple n x

test_encodeModified :: Eq a => [a] -> Bool
test_encodeModified xs = (encodeModified xs) == (encodeModified' xs)


------------------------------ 12 ------------------------------
decodeModified :: Eq a => [EncodedListItem a] -> [a]
decodeModified xs = foldl (\acc x -> acc ++ decodeItem x) [] xs
    where
        decodeItem (Single x) = [x]
        decodeItem (Multiple n x) = replicate n x

test_decodeModified :: Eq a => [a] -> Bool
test_decodeModified xs = (xs) == decodeModified (encodeModified xs)

