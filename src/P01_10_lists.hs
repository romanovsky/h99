module P01_10_lists
    (
    p01_myLast,
    test_p01_myLast
    )
where

import Test.QuickCheck


p01_myLast :: Eq a => [a] -> a
p01_myLast [] = error "empty list"
p01_myLast xs = xs!!(length xs - 1)

p01_myLast' :: [Int] -> Int
p01_myLast' [] = error "empty list"
p01_myLast' xs = foldr ( flip const)

test_p01_myLast :: ([Int]->Int) -> [Int] -> Bool
test_p01_myLast f [] = True
test_p01_myLast f xs = last xs == f xs


