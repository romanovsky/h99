module Main where

import Test.QuickCheck
import P01_10_lists (test_p01_myLast)

main :: IO()
main = do
    quickCheck test_p01_myLast

