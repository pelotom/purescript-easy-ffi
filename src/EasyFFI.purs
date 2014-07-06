module Data.Foreign.EasyFFI
  ( unsafeForeignFunction
  , unsafeForeignProcedure
  ) where

foreign import unsafeForeignProcedure
  "\
   \function unsafeForeignProcedure(args) {\
   \  return function (stmt) {\
   \    return Function(wrap(args))();\
   \    function wrap() {\
   \      return !args.length ? stmt : 'return function (' + args.shift() + ') { ' + wrap() + ' };';\
   \    }\
   \  };\
   \}\
  \"
  :: forall a. [String] -> String -> a

unsafeForeignFunction args expr = unsafeForeignProcedure args $ "return " ++ expr ++ ";"