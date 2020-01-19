module Main where

import Prelude

import Affjax as AX
import Affjax.ResponseFormat as RF
import Data.Argonaut.Decode as Argonaut
import Data.Either (Either(..))
import Effect (Effect)
import Effect.Aff (launchAff_)
import Effect.Class.Console as Console

type Todo =
  { id :: Int
  , title :: String
  }

main :: Effect Unit
main = launchAff_ do
  res <- AX.get RF.json "https://jsonplaceholder.typicode.com/todos/1"
  case res of
    Left err ->
      Console.error (AX.printError err)
    Right { body } -> case Argonaut.decodeJson body of
      Left err ->
        Console.error err
      Right (todo :: Todo) ->
        Console.log (show todo)
