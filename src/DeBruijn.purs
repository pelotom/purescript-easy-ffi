module Data.Foreign.DeBruijn
  ( unsafeForeignStatement
  , unsafeForeignExpression
  ) where

foreign import unsafeForeignStatement
  "\
   \function unsafeForeignStatement(stmt) {\
   \  var re = new RegExp('\\\\$\\\\d+', 'g'), result, max = 0;\
   \  while (result = re.exec(stmt))\
   \    max = Math.max(Number(result[0].substr(1)) + 1, max);\
   \  return Function(wrap(max))();\
   \  function wrap(n) {\
   \    return !n ? stmt : 'return function ($' + (n-1) + ') { ' + wrap(n-1) + ' };';\
   \  }\
   \}\
  \"
  :: forall a. String -> a

unsafeForeignExpression expr = unsafeForeignStatement $ "return " ++ expr ++ ";"