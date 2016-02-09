## Module Auth.Hello.Credentials

#### `Credentials`

``` purescript
type Credentials = Map Network String
```

#### `RawCredentials`

``` purescript
type RawCredentials = Array { network :: String, id :: String }
```

#### `renderCredentials`

``` purescript
renderCredentials :: Credentials -> RawCredentials
```


