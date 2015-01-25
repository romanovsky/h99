module Main where

import Test.QuickCheck
import P01_10_lists (p01_myLast, test_p01_myLast)
--import QC (prop_revapp)

main :: IO()
main = quickCheck ( test_p01_myLast p01_myLast )
--    quickCheck p02_myLast

