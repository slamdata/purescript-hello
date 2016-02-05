module Auth.Hello.Network
  ( Network(..)
  , RawNetwork()
  , renderNetwork
  ) where

import Prelude
import Data.Generic as G

-- | Three app networks are supported.
data Network
  = WindowsNetwork
  | FacebookNetwork
  | GoogleNetwork

type RawNetwork = String

derive instance genericNetwork :: G.Generic Network

instance eqNetwork :: Eq Network where
  eq = G.gEq

instance ordNetwork :: Ord Network where
  compare = G.gCompare

instance showNetwork :: Show Network where
  show = G.gShow

renderNetwork
  :: Network
  -> RawNetwork
renderNetwork n =
  case n of
    WindowsNetwork -> "windows"
    FacebookNetwork -> "facebook"
    GoogleNetwork -> "google"


