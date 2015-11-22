module P31_41_arithmetic
    (
    isPrime,
    myGCD,
    coprime,
    totient,
    totient',
    primeFactors,
    primeFactorsMult,
    totientFast,
    totientFast',
    totientFast'',
    profileTotient,
    primesR,
    goldbach,
    goldbach',
    goldbach'',
    goldbachList,
    goldbachList',
    )

where

import Data.List.Ordered
import Data.List (group)

-- 31
isPrime :: Integral a => a -> Bool
isPrime 0 = False
isPrime 1 = False
isPrime 2 = True
isPrime a = not . or $ map (\x -> mod a x == 0) [2..ceiling $ sqrt $ fromIntegral a]

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

-- 37
totientFast :: Int -> Int
totientFast n = (product $ map (\pt -> (n - (n `div` (fst pt)))) (primes)) `div` (n^(length primes - 1))
    where primes =primeFactorsMult n

totientFast' :: Int -> Int
totientFast' n = product $ map (\(p,m) -> (p - 1) * p^(m-1)) (primeFactorsMult n)

totientFast'' :: Int -> Int
totientFast'' n = product [(p - 1) * p^(m-1) | (p, m) <- primeFactorsMult n]

-- 38
profileTotient :: Int -> Bool
profileTotient n = totientFast n == totient n

-- 39
primesR :: Integral a => a -> a -> [a]
primesR f t = filter isPrime [f..t]

-- 40
-- goldbach is the fastest
goldbach :: Integral a => a -> (a,a)
goldbach n 
    | n > 2 && even n = head [ (x,y) | x <- primesR 2 (n-2), let y = (n-x), isPrime y ]
    | otherwise = (0,0)

goldbach' :: Integral a => a -> (a,a)
goldbach' n = head [ (x,y) | x <- primesR 2 (n-2), y <- primesR 2 (n-2), x+y==n ]

goldbach'' :: Integral a => a -> (a,a)
goldbach'' n = head [ (x,y) | (x,y) <- odd_pairs, (isPrime x && isPrime y)]
    where odd_pairs = map (\x -> (x, (n-x))) [1,3..(n `div` 2)] 


-- 41

goldbachList :: Integral a => a -> a -> [(a,a)]
goldbachList a b = map goldbach $ filter even [a .. b]

goldbachList' :: Integral a => a -> a -> a -> [(a,a)]
goldbachList' a b c = filter (\(a,b) -> a>c && b>c) $ map goldbach $ filter even [a .. b]

