module Test.Main where

import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Console (CONSOLE, log)
import Control.Monad.Eff.Random (RANDOM)
import Control.Monad.Eff.Exception (EXCEPTION)
import Data.Array (sort)

-- Import the library's module(s)
import Data.Foreign.EasyFFI (unsafeForeignFunction)

-- Import Test.QuickCheck, which supports property-based testing
import Test.QuickCheck (quickCheck)

import Prelude
  ( ($)
  , (+)
  , (==)
  , const 
  , bind
  , Unit )

ffi::forall a. Array String -> String -> a
ffi = unsafeForeignFunction

easyConst :: Int -> Int -> Int
easyConst = ffi ["n", ""] "n"

easyAdd :: Int -> Int -> Int
easyAdd = ffi ["x", "y"] "x + y"

easySort :: Array Int -> Array Int
easySort = ffi ["xs"] "xs.slice().sort(function(a,b){return a-b;})"

main::forall e. Eff ( console::CONSOLE, random::RANDOM, err::EXCEPTION|e ) Unit
main = do
  log "Constant"
  quickCheck $ \n m -> easyConst n m == const n m

  log "Addition"
  quickCheck $ \n m -> easyAdd n m == n + m

  log "Sorting"
  quickCheck $ \xs -> easySort xs == sort xs
