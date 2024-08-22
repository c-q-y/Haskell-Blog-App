{-# LANGUAGE OverloadedStrings #-}

module BlogApp.Core where

import BlogApp.HTML (registerPage)
import BlogApp.Query (fetchUserEmail, insertUser)
import Data.Text (Text)
import Web.Scotty
  ( ActionM,
    formParam,
    get,
    html,
    liftIO,
    post,
    redirect,
    scotty,
    text,
  )

homeR :: ActionM ()
homeR = html "<h1> Home Page</h1>"

aboutR :: ActionM ()
aboutR = html "<h1> About Page</h1>"

registerR :: ActionM ()
registerR = html registerPage

addUserR :: ActionM ()
addUserR = do
  userName <- formParam "user_name"
  userEmail <- formParam "user_email"
  userPassword <- formParam "user_password"
  (userConfirmPassword :: Text) <- formParam "user_confirm_password"
  userList <- liftIO $ fetchUserEmail userEmail
  case userList of
    [] -> do
      if userPassword /= userConfirmPassword
        then text "password not matching"
        else liftIO (insertUser userName userEmail userPassword) >> redirect "/"
    _ -> text "user email already exists"

main :: IO ()
main = scotty 8080 $ do
  get "/" homeR
  get "/about" aboutR
  get "/register" registerR
  post "/addUser" addUserR