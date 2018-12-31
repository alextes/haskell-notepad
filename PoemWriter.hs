{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}

module PoemWriter where

import           Data.Text
import Data.Text (pack)
import           NeatInterpolation

helpText :: Text
helpText =
  [text|
    help        see this menu, obviously
    say         say some text placed in a ascii banner
    poem        say a little poem for your muse
    exit        say bye!
  |]

decorate :: Text -> Text
decorate message =
  [text|
    xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
    $message
    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  |]

writePoem :: Text -> Text
writePoem muse =
  [text|
    Dear $muse,

    Roses are not blue
    Violets are not red
    Whatever you do
    It trumps being dead
  |]

exec :: [Text] -> Text
exec ["poem", muse] = writePoem muse
exec ["say", message] = decorate message
exec ["exit"] = decorate "Bye cruel world!"
exec ["help"] = helpText
exec x =
  [text|"'${input}' was an example of an incorrect command"|]
  where
    input = Data.Text.unwords x

userInputs = [
  "Incorrect command",
  "say Welcome to the mean poem machine",
  "poem reader",
  "exit"
  ]

main = do
  let textOutputs = Prelude.map (exec . Data.Text.words) userInputs
  mapM_ (putStrLn . unpack) textOutputs
