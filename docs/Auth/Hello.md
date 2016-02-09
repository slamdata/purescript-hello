## Module Auth.Hello

#### `HELLO`

``` purescript
data HELLO :: !
```

The effect that tracks the global state of the `hello` object.

#### `HelloEffects`

``` purescript
type HelloEffects e = (hello :: HELLO, err :: EXCEPTION | e)
```

#### `APIPath`

``` purescript
type APIPath = String
```

#### `init`

``` purescript
init :: forall options e. Credentials -> {  | options } -> Eff (HelloEffects e) Unit
```

#### `login`

``` purescript
login :: forall options e. Network -> {  | options } -> Aff (HelloEffects e) Unit
```

#### `logout`

``` purescript
logout :: forall options e. Network -> {  | options } -> Aff (HelloEffects e) Unit
```

#### `getAuthResponse`

``` purescript
getAuthResponse :: forall e resp. Network -> Eff (HelloEffects e) (Maybe {  | resp })
```

#### `api`

``` purescript
api :: forall e request options response. Network -> APIPath -> Method -> {  | request } -> {  | options } -> Aff (HelloEffects e) {  | response }
```

#### `Subscription`

``` purescript
data Subscription :: *
```

An opaque token to represent an individual event subscription. Internally, `hello.js`
makes the unfortunate choice of using symbolic reference equality of callback operations
to avoid generating tokens for subscriptions as would be expected in a production codebase.
This wrapper hides that design behind the abstract `Subscription` type.

#### `subscribe`

``` purescript
subscribe :: forall e. Event -> Eff (HelloEffects e) Unit -> Eff (HelloEffects e) Subscription
```

#### `unsubscribe`

``` purescript
unsubscribe :: forall e. Subscription -> Eff (HelloEffects e) Unit
```


