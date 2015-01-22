module P01_10_lists
    (
    p01_myLast,
    test_p01_myLast
    )
where

import Test.QuickCheck


p01_myLast :: (Eq a) => [a] -> a
p01_myLast xs = xs!!(length xs - 1)

test_p01_myLast :: [Int] -> Bool
test_p01_myLast (x:[]) = p01_myLast([x]) == x
test_p01_myLast (xs:x:[]) = p01_myLast(xs:x:[]) == x

main :: IO()
main = do
    quickCheck test_p01_myLast

