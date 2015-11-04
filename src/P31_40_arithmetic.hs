module P31_40_arithmetic
    (
    isPrime,
    )

where

import Data.List.Ordered

isPrime :: Int -> Bool
isPrime 0 = False
isPrime 1 = False
isPrime 2 = True
isPrime a = not . or $ map (\x -> mod a x == 0) [2..a-1]

