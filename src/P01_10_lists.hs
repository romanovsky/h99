module P01_10_lists
    (
    p01_myLast,
    p01_myLast',
    p01_myLast'',
    p01_myLast''',
    p01_myLast'''',
    test_p01_myLast,

    p02_myButLast,
    p02_myButLast',
    test_p02_myButLast,
    )
where

import Data.Eq

---------- 01 ---------------

--p01_myLast :: (Eq a) => [a] -> a
p01_myLast :: [a] -> a
p01_myLast xs = xs!!(length xs - 1)

p01_myLast' :: [a] -> a
p01_myLast' = foldr1 (flip const)

p01_myLast'' :: [a] -> a
p01_myLast'' = foldr1 (const id)

p01_myLast''' :: [a] -> a
p01_myLast''' [x] = x
p01_myLast''' (_:xs) = p01_myLast''' xs

p01_myLast'''' :: [a] -> a
p01_myLast'''' xs = head $ reverse xs

p01_myLast''''' :: [a] -> a
p01_myLast''''' xs = foldl1 (curry snd) xs

test_p01_myLast :: Eq a => ([a]->a) ->[a] -> Bool
test_p01_myLast f ([]) = True
test_p01_myLast f (xs) = f(xs) == last xs


---------- 02 ---------------

p02_myButLast :: [Int] -> Int
p02_myButLast [] = error "too few elements"
p02_myButLast [x] = error "too few elements"
p02_myButLast [x,_] = x
p02_myButLast (_:xs) = p02_myButLast xs

p02_myButLast' :: [Int] -> Int
p02_myButLast' = last . init

test_p02_myButLast :: ([Int]->Int) ->[Int] -> Bool
test_p02_myButLast f ([]) = True
test_p02_myButLast f ([x]) = True
test_p02_myButLast f (xs) = f(xs) == xs!!(length xs - 2)


---------- 03 ---------------

p03_elementAt :: Eq a => [a] -> Int -> a
p03_elementAt (x:_) 1 = x
p03_elementAt (_:xs) i = p03_elementAt xs (i-1)

test_p03_elementAt :: Eq a => ([a]->Int->a) ->[a] -> Int -> Bool
test_p03_elementAt f ([]) i = True
test_p03_elementAt f ([x]) i = True
test_p03_elementAt f xs i
    | length(xs) < i = True -- it's out of bounds
    | otherwise = f xs i == xs!!i


---------- 04 ---------------

p04_myLength :: [a] -> Int
p04_myLength [] = 0
p04_myLength xs = foldr (\x acc -> acc+1) 0 xs

test_p04_myLength :: ([a] -> Int) -> [a] -> Bool
test_p04_myLength f xs = (f xs) == (length xs)
