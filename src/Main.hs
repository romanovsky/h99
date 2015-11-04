module Main where

import Test.QuickCheck
import Data.Eq
--import TT (ttfun)
import P01_10_lists
import P11_20_lists
import P21_30_lists
import P31_40_arithmetic
--import Data.Aeson.Encode.Pretty (encodePretty)
--import IO
import qualified Text.Show.Pretty as Pr

main :: IO()
main = do
    let testData = "qwersdafqdsfeee"
{-
------------------------------ 01..10 ------------------------------
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

    let testData = "aaaaaoooorr"
    let res = myPack testData
    putStrLn $ Pr.ppShow res
    quickCheck $ ( test_myPack :: ([Char]->[[Char]]) -> [Char] -> Bool ) myPack
    quickCheck $ ( test_myPack :: ([Char]->[[Char]]) -> [Char] -> Bool ) myPack'

    let res = myEncode "aaaeeeebbcccaa"
    putStrLn $ Pr.ppShow res
    quickCheck $ (test_myEncode :: ([Int]->Bool))
-}

{-
------------------------------ 11..20 ------------------------------
    quickCheck $ ( test_encodeModified :: [Char] -> Bool )

    putStrLn $ Pr.ppShow $ decodeModified(encodeModified testData)

    quickCheck $ ( test_decodeModified :: [Bool] -> Bool )
    quickCheck $ ( test_decodeModified :: [Bool] -> Bool )

    let result = encodeDirect testData
    let result' = encodeDirect' testData
    putStrLn $ Pr.ppShow result
    putStrLn $ Pr.ppShow result'

    quickCheck $ ( test_encodeDirect :: [Char] -> Bool )

    quickCheck $ ( test_myDuplicate :: [Char] -> Bool )
    quickCheck $ ( test_myReplicate :: [Char] -> Bool )

    let testData16="aaa"
    putStrLn $ Pr.ppShow $ dropEvery testData16 1
    putStrLn $ Pr.ppShow $ dropEvery' testData16 1
    quickCheck $ (test_dropEvery :: [Char] -> Int -> Bool)

    let testData17="a"
    putStrLn $ Pr.ppShow $ mySplitAt testData17 0
    quickCheck $ (test_mySplitAt :: [Char] -> Int -> Bool)

    putStrLn $ Pr.ppShow $ mySlice [ 'a','b','c','d','e','f','g','h','i','k'] 3 7
    putStrLn $ Pr.ppShow $ mySlice' [ 'a','b','c','d','e','f','g','h','i','k'] 3 7
    quickCheck $ (test_mySlice :: [Char] -> Int -> Int -> Bool)

    let testData19 = "abcdefgh"
    putStrLn $ Pr.ppShow $ myRotate testData19 30
-}


{-
------------------------------ 21..30 ------------------------------
-- 22
--    putStrLn $ Pr.ppShow $ myRange 1 100
--    putStrLn $ Pr.ppShow $ myRange'' 1 10
    let n = 10000
    let r1 = seq (myRange 1 n)
    let r2 = seq (myRange' 1 n)
    let r3 = seq (myRange'' 1 n)
--    putStrLn "done"
    let n' = 1000000
--    quickCheck $ test_myRange
    putStrLn $ Pr.ppShow $ test_myRange 0 n'


-- 23
    let testData23 = "012345"
    r <- rnd_select testData23 $ length testData23
    r' <- rnd_select' testData23 $ length testData23
    putStrLn $ Pr.ppShow r
    putStrLn $ Pr.ppShow r'

--24
    r <- diff_select 10000 100001
    putStrLn $ Pr.ppShow r


-- 25
    let testData25 = [1..10000]
    putStrLn $ "rnd_permu"
    r <- rnd_permu testData25
    putStrLn $ Pr.ppShow r

    putStrLn $ "rnd_permu_fast1"
    r <- rnd_permu_fast1 testData25
    putStrLn $ Pr.ppShow r
    
    putStrLn $ "rnd_permu_fast2"
    r <- rnd_permu_fast2 testData25
    putStrLn $ Pr.ppShow r

    let testData26 = "abcdefgh"
    let r = combinations 2 testData26
    putStrLn $ Pr.ppShow r
    
    let testData26 = "abc"
    let r = combinations 4 testData26
    putStrLn $ Pr.ppShow r

--28
--    let testData28 = ["b", "a", "asdf", "qw", "ab"]

    let testData28 = [[1..1000],[40..99],[1,2], [11..1000000]]
    let r = lsort testData28
    putStrLn $ Pr.ppShow $ length r
    let r = lsort' testData28
    putStrLn $ Pr.ppShow $ length r

    let testData28 = ["ab", "bc", "de", "a", "asdfasdfasdf", "b", "ze"]
    let r = lsortb testData28
    putStrLn $ Pr.ppShow $ r
    let r = lsort testData28
    putStrLn $ Pr.ppShow $ r
-}
    
------------------------------ 21..30 ------------------------------
-- 31
    let testData31 = [0..1000]
    let r = map (\i -> (i, isPrime i)) testData31
    print $ Pr.ppShow $ r

