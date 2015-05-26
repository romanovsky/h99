module P11_20_lists
    (
    myEncodeModified,
    test_myEncodeModified,
    )
where

import Data.Eq

myEncodeModified :: [a] => [(Integer, a)]
myEncodeModified [] = []

test_myEncodeModified :: ([a] => [(Integer, a)]) -> [Char] -> Bool
test_myEncodeModified f xs = True
