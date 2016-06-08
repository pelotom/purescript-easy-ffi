module Data.Foreign.EasyFFI
  ( unsafeForeignFunction
  , unsafeForeignProcedure
  ) where

import Prelude
  ( ($)
  , (<>) )

foreign import unsafeForeignProcedure :: forall a. Array String -> String -> a

unsafeForeignFunction::forall a. Array String -> String -> a 
unsafeForeignFunction args expr = unsafeForeignProcedure args $ "return " <> expr <> ";"
