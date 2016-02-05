## Module Auth.Hello.Event

#### `Event`

``` purescript
data Event
  = Auth
  | AuthInit
  | AuthLogin
  | AuthLogout
  | AuthUpdate
```

#### `RawEvent`

``` purescript
type RawEvent = String
```

#### `renderEvent`

``` purescript
renderEvent :: Event -> RawEvent
```


