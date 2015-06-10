module Test.Main where

import Control.Monad.Eff
import Control.Monad.Eff.Console
import Data.Array

-- Import the library's module(s)
import Data.Foreign.EasyFFI

-- Import Test.QuickCheck, which supports property-based testing
import Test.QuickCheck

import Prelude
  ( ($)
  , (+)
  , (==)
  , (>>=)
  , const )

ffi = unsafeForeignFunction

easyConst :: Int -> Int -> Int
easyConst = ffi ["n", ""] "n"

easyAdd :: Int -> Int -> Int
easyAdd = ffi ["x", "y"] "x + y"

easySort :: Array Int -> Array Int
easySort = ffi ["xs"] "xs.slice().sort()"

main = do
  log "Constant"
  quickCheck $ \n m -> easyConst n m == const n m

  log "Addition"
  quickCheck $ \n m -> easyAdd n m == n + m

  log "Sorting"
  quickCheck $ \xs -> easySort xs == sort xs
