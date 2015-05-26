module Main where

--import P01_10_lists (test1)
import Test.QuickCheck
import Data.Eq
--import TT (ttfun)
import P01_10_lists
--import Data.Aeson.Encode.Pretty (encodePretty)
--import IO
import qualified Text.Show.Pretty as Pr

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

    -- print (myFlatten'' $ List' [Elem' 1, Elem' 2, List' [Elem' 3, Elem' 4, Elem' 5]])
    quickCheck $ test_myFlatten

--    print $ myCompress "oao"
--    let testData = "oaoaooooooaaaaa" --"\183a\183"
--    print $ myCompress testData
--    print $ myCompress' testData
    quickCheck ( test_myCompress :: [Char] -> Bool )

    let res = myEncode "aaaeeeebbcccaa"
    putStrLn $ Pr.ppShow res
    quickCheck $ (test_myEncode :: ([Int]->Bool))
-}

    let testData = "aaaaaoooorr"
    let res = myPack testData
    putStrLn $ Pr.ppShow res
--    quickCheck $ ( test_myPack :: ([Char]->[[Char]]) -> [Char] -> Bool ) myPack

