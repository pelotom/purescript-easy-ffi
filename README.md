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

Yuck! Using Easy FFI you can scrap all that boilerplate and write the above as:

```haskell
foo :: Number -> Number -> Number -> Number
foo = unsafeForeignFunction ["x", "y", "z"] "(x + y) * z"
```

Easy! We can also define foreign functions returning monadic actions, by including an empty argument, e.g.

```haskell
log :: forall r. String -> Eff (console :: Unit | r) Unit
log = unsafeForeignProcedure ["string", ""] "console.log(string);" -- note the extra ""
```

which is equivalent to this:

```haskell
foreign import log
 "function log(string) {\
 \  return function () {\
 \    console.log(string);\
 \  };\
 \}"
 :: forall r. String -> Eff (console :: Unit | r) Unit
```

The only difference between `unsafeForeignFunction` and `unsafeForeignProcedure` is that the former takes an expression as its second argument, and the latter a statement.
