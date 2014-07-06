module Main where

import Debug.Trace
import Data.Array
import Control.Monad.Eff

-- Import the library's module(s)
import Data.Foreign.EasyFFI

-- Import Test.QuickCheck, which supports property-based testing
import Test.QuickCheck

ffi = unsafeForeignFunction

easyAdd :: Number -> Number -> Number
easyAdd = ffi ["x", "y"] "x + y"

easySort :: [Number] -> [Number]
easySort = ffi ["xs"] "xs.slice().sort()"

easyConst :: Number -> Number -> Number
easyConst = ffi ["n", ""] "n"

main = do
  trace "Constant"
  quickCheck $ \n m -> easyConst n m == const n m
  trace "Addition"
  quickCheck $ \n m -> easyAdd n m == n + m
  trace "Sorting"
  quickCheck $ \xs -> easySort xs == sort xs