module Auth.Hello.Credentials
  ( Credentials()
  , RawCredentials()
  , renderCredentials
  ) where

import Prelude
import Auth.Hello.Network
import Data.List as L
import Data.Map as Map
import Data.Tuple as T

type Credentials = Map.Map Network String

type RawCredentials =
  Array
    { network :: String
    , id :: String
    }


renderCredentials
  :: Credentials
  -> RawCredentials
renderCredentials =
  Map.toList
    >>> map (\(T.Tuple n i) -> { network: renderNetwork n, id: i })
    >>> L.fromList

