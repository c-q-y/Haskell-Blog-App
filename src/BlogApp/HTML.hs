{-# LANGUAGE OverloadedStrings #-}

module BlogApp.HTML where

import Data.Text.Lazy (Text)
import Text.Blaze.Html5
  ( body,
    br,
    button,
    form,
    h1,
    html,
    input,
    label,
    (!),
  )
import Text.Blaze.Html5.Attributes
  ( action,
    method,
    name,
    type_,
  )
import Text.Blaze.Renderer.Text (renderMarkup)

registerPage :: Text
registerPage = renderMarkup $ do
  html $ do
    body $ do
      h1 "Register"
      form ! method "POST" ! action "/addUser" $ do
        label "user name"
        input ! type_ "text" ! name "user_name"
        br
        label "user email"
        input ! type_ "email" ! name "user_email"
        br
        label "password"
        input ! type_ "password" ! name "user_password"
        br
        label "confirm password"
        input ! type_ "password" ! name "user_confirm_password"
        br
        button ! type_ "submit" $ "register"