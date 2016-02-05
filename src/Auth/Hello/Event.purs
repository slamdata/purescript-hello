module Auth.Hello.Event
  ( Event(..)
  , RawEvent()
  , renderEvent
  ) where

data Event
  = Auth
  | AuthInit
  | AuthLogin
  | AuthLogout
  | AuthUpdate

type RawEvent = String

renderEvent
  :: Event
  -> RawEvent
renderEvent e =
  case e of
    Auth -> "auth"
    AuthInit -> "auth.init"
    AuthLogin -> "auth.login"
    AuthLogout -> "auth.logout"
    AuthUpdate -> "auth.update"

