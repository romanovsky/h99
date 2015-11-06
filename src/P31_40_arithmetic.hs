module P31_40_arithmetic
    (
    isPrime,
    myGCD,
    coprime,
    )

where

import Data.List.Ordered

isPrime :: Integral a => a -> Bool
isPrime 0 = False
isPrime 1 = False
isPrime 2 = True
isPrime a = not . or $ map (\x -> mod a x == 0) [2..a-1]

myGCD :: Integral a => a -> a -> a
myGCD a b
    | b==0 = abs a
    | otherwise = myGCD (abs b) (a `mod` b)

coprime :: Integral a => a -> a -> Bool
coprime a b = myGCD a b == 1
