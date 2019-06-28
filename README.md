# purescript-easy-ffi [![Build Status](https://travis-ci.org/pelotom/purescript-easy-ffi.svg?branch=master)](https://travis-ci.org/pelotom/purescript-easy-ffi)

Most foreign imports in PureScript follow a familiar pattern:

```purescript
-- In Module.purs
foreign import foo :: Number -> Number -> Number -> Number
```

```javascript
// In Module.js
exports.foo = function(x) {
  return function (y) {
    return function (z) {
      return (x + y) * z; // <- the actually interesting part!
    };
  };
};
```

Yuck! Using Easy FFI you can scrap all that boilerplate and write the above as:

```purescript
foo :: Number -> Number -> Number -> Number
foo = unsafeForeignFunction ["x", "y", "z"] "(x + y) * z"
```

Easy! We can also define foreign functions returning monadic actions, by including an empty argument, e.g.

```purescript
log :: String -> Effect Unit
log = unsafeForeignProcedure ["string", ""] "console.log(string);" -- note the extra ""
```

which is equivalent to this:

```purescript
foreign import log :: String -> Effect Unit
```

```javascript
exports.log = function(string) {
  return function () {
    console.log(string);
  };
};
```

The only difference between `unsafeForeignFunction` and `unsafeForeignProcedure` is that the former takes an expression as its second argument, and the latter a statement.
