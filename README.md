# purescript-debruijn-ffi

Most foreign imports in PureScript follow a familiar pattern:

```haskell
foreign import foo
  "function foo(x) {\
  \  return function (y) {\
  \    return function (z) {\
  \      return (x + y) * z; // <- the actually interesting part!\
  \    };\
  \  };\
  \}"
  :: Number -> Number -> Number -> Number
```

Yuck! Using the power of [De Bruijn indices](http://en.wikipedia.org/wiki/De_Bruijn_index) you can scrap all that boilerplate and write the above as:

```haskell
foo :: Number -> Number -> Number -> Number
foo = unsafeForeignExpression "($2 + $1) * $0"
```

Note that higher indices correspond to *earlier* (outermore) arguments, which may be a bit counterintuitive. This is intentional, as it makes clear how many arguments the generated function should take (1 more than the maximum index used) and allows ignoring later arguments. Thus we can easily define foreign functions returning monadic actions, e.g.

```haskell
log :: forall r. String -> Eff (console :: Unit | r) Unit
log = unsafeForeignStatement "console.log($1);" -- note the $1 instead of $0
```

which is equivalent to this:

```haskell
foreign import log
  "function log($1) {\
  \  return function ($0) {\
  \    console.log($1);\
  \  };\
  \}"
 :: forall r. String -> Eff (console :: Unit | r) Unit
```