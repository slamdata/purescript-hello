module Main where

import Prelude
import Data.Either
import Control.Monad.Aff
import Control.Monad.Eff
import Control.Monad.Eff.Class
import Control.Monad.Eff.Exception (message, throwException)
import Control.Monad.Eff.Console
import Data.Map as Map

import Auth.Hello as H

main :: Eff (H.HelloEffects (console :: CONSOLE)) Unit
main =
 runAff throwException pure $ do
   let credentials = Map.insert H.FacebookNetwork "my-app-id" Map.empty
   liftEff $ H.init credentials {}
   res <- attempt $ H.login H.FacebookNetwork {}
   liftEff do
     case res of
       Left err ->
         log $ "Failed: " <> message err
       Right _ ->
         log $ "Succeeded!"
