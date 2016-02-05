## Module Auth.Hello.Method

#### `Method`

``` purescript
data Method
  = Get
  | Post
  | Delete
  | Put
```

#### `RawMethod`

``` purescript
type RawMethod = String
```

#### `renderMethod`

``` purescript
renderMethod :: Method -> RawMethod
```


