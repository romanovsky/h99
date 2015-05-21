module Main where

--import P01_10_lists (test1)
import Test.QuickCheck
import Data.Eq
--import TT (ttfun)
import P01_10_lists --( test_p01_myLast, p01_myLast, p01_myLast', p01_myLast'', p01_myLast''', p01_myLast'''', test_p02_myButLast, p02_myButLast, p02_myButLast', )

main :: IO()
main = do
    quickCheck $ (test_p01_myLast :: ([Int] -> Int) -> [Int] -> Bool) p01_myLast
    quickCheck $ (test_p01_myLast :: ([Int] -> Int) -> [Int] -> Bool) p01_myLast'
    quickCheck $ (test_p01_myLast :: ([Int] -> Int) -> [Int] -> Bool) p01_myLast''
    quickCheck $ (test_p01_myLast :: ([Int] -> Int) -> [Int] -> Bool) p01_myLast'''
    quickCheck $ (test_p01_myLast :: ([Char] -> Char) -> [Char] -> Bool) p01_myLast''''

    quickCheck $ (test_p02_myButLast :: ([Int]->Int) ->[Int] -> Bool) p02_myButLast
    quickCheck $ (test_p02_myButLast :: ([Int]->Int) ->[Int] -> Bool) p02_myButLast'

    quickCheck $ (test_p03_elementAt :: ([Char]->Int->Char) -> [Char] -> Int -> Bool) p03_elementAt

    quickCheck $ (test_p04_myLength :: ([Char]->Int) -> [Char] -> Bool) p04_myLength


--    print $ p02_myButLast'([3,1,2])
--    quickCheck $ test1
--    quickCheck $ TT.ttfun

