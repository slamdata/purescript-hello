## Module Auth.Hello.Network

#### `Network`

``` purescript
data Network
  = WindowsNetwork
  | FacebookNetwork
  | GoogleNetwork
```

Three app networks are supported.

##### Instances
``` purescript
Generic Network
Eq Network
Ord Network
Show Network
```

#### `RawNetwork`

``` purescript
type RawNetwork = String
```

#### `renderNetwork`

``` purescript
renderNetwork :: Network -> RawNetwork
```


