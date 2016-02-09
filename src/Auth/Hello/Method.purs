module Auth.Hello.Method
  ( Method(..)
  , RawMethod()
  , renderMethod
  ) where

data Method
  = Get
  | Post
  | Delete
  | Put

type RawMethod = String

renderMethod
  :: Method
  -> RawMethod
renderMethod m =
  case m of
    Get -> "get"
    Post -> "post"
    Delete -> "delete"
    Put -> "put"
