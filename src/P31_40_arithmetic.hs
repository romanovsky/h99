module P31_40_arithmetic
    (
    isPrime,
    myGCD,
    coprime,
    totient,
    totient',
    primeFactors,
    primeFactorsMult,
    )

where

import Data.List.Ordered
import Data.List (group)

-- 31
isPrime :: Integral a => a -> Bool
isPrime 0 = False
isPrime 1 = False
isPrime 2 = True
isPrime a = not . or $ map (\x -> mod a x == 0) [2..a-1]

-- 32
myGCD :: Integral a => a -> a -> a
myGCD a b
    | b==0 = abs a
    | otherwise = myGCD (abs b) (a `mod` b)

-- 33
coprime :: Integral a => a -> a -> Bool
coprime a b = myGCD a b == 1

-- 34
totient :: Integral a => a -> Int
totient 1 = 1
totient a = sum $ map (fromEnum . coprime a) [1..(a-1)]

totient' :: Integral a => a -> Int
totient' 1 = 1
totient' a = length $ filter (coprime a) [1..(a-1)]

-- 35
primeFactors :: Integral a => a -> [a]
primeFactors n
    | n < 4 = [n]
    | otherwise = pf n 2

pf :: Integral a => a -> a -> [a]
pf n f
    | f*f > n = [n]
    | n `mod` f == 0 = f : pf (n `div` f) f
    | otherwise = pf n (f+1)

-- 36
primeFactorsMult :: Integral a => a -> [(a, Int)]
primeFactorsMult n = map (\xx -> (head xx, length xx)) $ group $ primeFactors n

