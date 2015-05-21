module Main where

--import P01_10_lists (test1)
import Test.QuickCheck
import Data.Eq
--import TT (ttfun)
import P01_10_lists

main :: IO()
main = do
{-
    quickCheck $ ( test_p01_myLast :: ([Char]->Char) -> [Char] -> Bool) p01_myLast
    quickCheck $ ( test_p01_myLast :: ([Char]->Char) -> [Char] -> Bool) p01_myLast'
    quickCheck $ ( test_p01_myLast :: ([Char]->Char) -> [Char] -> Bool) p01_myLast''
    quickCheck $ ( test_p01_myLast :: ([Char]->Char) -> [Char] -> Bool) p01_myLast'''
    quickCheck $ ( test_p01_myLast :: ([Char]->Char) -> [Char] -> Bool) p01_myLast''''

    quickCheck $ ( test_p02_myButLast :: ([Char]->Char) -> [Char] -> Bool) p02_myButLast
    quickCheck $ ( test_p02_myButLast :: ([Char]->Char) -> [Char] -> Bool) p02_myButLast'

    quickCheck $ ( test_p03_elementAt :: ([Char] -> Int -> Char) -> [Char] -> Int -> Bool) p03_elementAt

    quickCheck $ ( test_p04_myLength :: ([Char] -> Int) -> [Char] -> Bool) p04_myLength
    quickCheck $ ( test_myReverse :: ([Char] -> [Char]) -> [Char] -> Bool) myReverse
    quickCheck $ ( test_myReverse :: ([Char] -> [Char]) -> [Char] -> Bool) myReverse'
    quickCheck $ ( test_isPalindrome :: ([Char] -> Bool) -> [Char] -> Bool) isPalindrome
-}

    print $ isPalindrome "azea"
