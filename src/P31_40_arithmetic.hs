module P31_40_arithmetic
    (
    isPrime,
    )

where

isPrime :: Int -> Bool
isPrime 0 = False
isPrime 1 = False
isPrime a = foldr (mod/
