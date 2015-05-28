module P11_20_lists
    (
    myEncodeModified,
    myEncodeModified',
    test_myEncodeModified,
    )
where

import Data.Eq
import Data.List (group)
import P01_10_lists (myEncode)


data EncodedListItem a = Single a | Multiple Int a deriving (Show, Eq)

myEncodeModified :: Eq a => [a] -> [EncodedListItem a]
myEncodeModified xs = [item | x <- group xs, let item = if length x == 1 then Single (head x) else Multiple (length x) (head x)]

myEncodeModified' :: Eq a => [a] -> [EncodedListItem a]
myEncodeModified' xs = map (encodeItem)  (myEncode xs)
    where
        encodeItem (1,x) = Single x
        encodeItem (n,x) = Multiple n x

test_myEncodeModified :: Eq a => [a] -> Bool
test_myEncodeModified xs = (myEncodeModified xs) == (myEncodeModified' xs)
