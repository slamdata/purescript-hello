module Auth.Hello
  ( HELLO()
  , HelloEffects()
  , APIPath()
  , Subscription()
  , init
  , login
  , logout
  , getAuthResponse
  , api
  , subscribe
  , unsubscribe

  , module Auth.Hello.Credentials
  , module Auth.Hello.Event
  , module Auth.Hello.Method
  , module Auth.Hello.Network
  ) where

import Prelude
import Control.Monad.Eff
import Control.Monad.Eff.Exception
import Control.Monad.Aff
import Data.Maybe as M

import Auth.Hello.Credentials
import Auth.Hello.Event
import Auth.Hello.Method
import Auth.Hello.Network

-- | The effect that tracks the global state of the `hello` object.
foreign import
  data HELLO :: !

type HelloEffects e =
  ( hello :: HELLO
  , err :: EXCEPTION
  | e
  )

type APIPath = String

foreign import
  _init
    :: forall options e
     . RawCredentials
    -> {|options}
    -> Eff (HelloEffects e) Unit

init
  :: forall options e
   . Credentials
  -> {|options}
  -> Eff (HelloEffects e) Unit
init credentials options =
  _init (renderCredentials credentials) options

foreign import
  _login
    :: forall options e
     . RawNetwork
    -> {|options}
    -> Eff (HelloEffects e) Unit
    -> (Error -> Eff (HelloEffects e) Unit)
    -> Eff (HelloEffects e) Unit

foreign import
  _logout
    :: forall options e
     . RawNetwork
    -> {|options}
    -> Eff (HelloEffects e) Unit
    -> (Error -> Eff (HelloEffects e) Unit)
    -> Eff (HelloEffects e) Unit

login
  :: forall options e
   . Network
  -> {|options}
  -> Aff (HelloEffects e) Unit
login network options =
  makeAff \error success ->
    _login (renderNetwork network) options (success unit) error

logout
  :: forall options e
   . Network
  -> {|options}
  -> Aff (HelloEffects e) Unit
logout network options =
  makeAff \error success ->
    _logout (renderNetwork network) options (success unit) error

foreign import
  _getAuthResponse
    :: forall e resp
     . RawNetwork
    -> M.Maybe {|resp}
    -> ({|resp} -> M.Maybe {|resp})
    -> Eff (HelloEffects e) (M.Maybe {|resp})

getAuthResponse
  :: forall e resp
   . Network
  -> Eff (HelloEffects e) (M.Maybe {|resp})
getAuthResponse network =
  _getAuthResponse (renderNetwork network) M.Nothing M.Just

foreign import
  _api
    :: forall e request options response
     . RawNetwork
    -> APIPath
    -> RawMethod
    -> {|request}
    -> {|options}
    -> ({|response} -> Eff (HelloEffects e) Unit)
    -> (Error -> Eff (HelloEffects e) Unit)
    -> Eff (HelloEffects e) Unit

api
  :: forall e request options response
   . Network
  -> APIPath
  -> Method
  -> {|request}
  -> {|options}
  -> Aff (HelloEffects e) {|response}
api network path method request options =
  makeAff \error success ->
    _api (renderNetwork network) path (renderMethod method) request options success error

-- | An opaque token to represent an individual event subscription. Internally, `hello.js`
-- | makes the unfortunate choice of using symbolic reference equality of callback operations
-- | to avoid generating tokens for subscriptions as would be expected in a production codebase.
-- | This wrapper hides that design behind the abstract `Subscription` type.
foreign import
  data Subscription :: *

foreign import
  _subscribe
    :: forall e
     . RawEvent
    -> Eff (HelloEffects e) Unit
    -> Eff (HelloEffects e) Subscription

subscribe
  :: forall e
   . Event
  -> Eff (HelloEffects e) Unit
  -> Eff (HelloEffects e) Subscription
subscribe event =
  _subscribe (renderEvent event)

foreign import
  unsubscribe
    :: forall e
     . Subscription
    -> Eff (HelloEffects e) Unit
