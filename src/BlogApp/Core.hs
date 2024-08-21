{-# LANGUAGE OverloadedStrings #-}

module BlogApp.Core where

import Web.Scotty

main :: IO ()
main = scotty 8080 $ do
  get "/" $ html "<h1>Hello, from the root!</h1>"
  get "/about" $ text "Hello from About page"
  get "/:word" $ do
    beam <- pathParam "word"
    html $ mconcat ["<h1>Scotty, ", beam, " me up!</h1>"]
