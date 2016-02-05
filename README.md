### purescript-hello: bindings for hello.js

This library provides minimal PureScript bindings for
[hello.js](https://adodson.com/hello.js/).

A few notes:

1. Asynchronous methods (such as `hello.login` and `hello.logout`) have been
   exposed through `Aff`; however, because `hello.js` uses the irreparably broken
   *Promises/A+* semantics for asynchronous operations, there may be abstraction
   leakage.

2. We expose an improved API for subscriptions that uses an abstract type to
   represent subscription tokens (where `hello.js` uses the symbolic/reference
   identity of JavaScript functions).

3. Rather than provide a fully-typed treatment of the syntax of requests and
   options (which would be quite difficult), we expose these in our interface
   as unconstrained records. Therefore, the correctness of the passed arguments
   is an extrinsic verification condition. Separately, a more advanced library
   might be made to wrap this one which ensured correctness using purely
   syntactic means.
