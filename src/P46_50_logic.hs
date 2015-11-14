module P46_50_logic
    (
    not',
    or',
    and',
    xor',
    nand',
    nor',
    impl',
    equ',
    table,
    )

where

import Data.List

-- 46

not' :: Bool -> Bool
not' True = False
not' False = True

and' :: Bool -> Bool -> Bool
and' True True = True
and' _ _ = False

or' :: Bool -> Bool -> Bool
or' True _ = True
or' _ True = True
or' _ _ = False

nand' :: Bool -> Bool -> Bool
nand' a b = not' $ and' a b

nor' :: Bool -> Bool -> Bool
nor' a b = not' $ or' a b

xor' :: Bool -> Bool -> Bool
xor' True True = False
xor' False False = False
xor' _ _ = True

impl' :: Bool -> Bool -> Bool
impl' True False = False
impl' _ _ = True

equ' :: Bool -> Bool -> Bool
equ' True True = True
equ' False False = True
equ' _ _ = False

table :: (Bool -> Bool -> Bool) -> IO ()
--table f = putStrLn $ map show $ map (\(x,y) -> [x, y, f x y] ) [(x,y) | x<-[False, True], y<-[False,True]]
table f = mapM_ putStrLn [ intercalate "\t" $ map show [x,y,f x y] | x<-[True, False], y<-[True, False]]

