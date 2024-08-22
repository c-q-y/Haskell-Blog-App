{-# LANGUAGE OverloadedStrings #-}

module BlogApp.Query where

import BlogApp.Types (User)
import Data.Text (Text)
import Database.SQLite.Simple
  ( Only (Only),
    close,
    execute,
    open,
    query,
  )

fetchUserEmail :: Text -> IO [User]
fetchUserEmail email = do
  conn <- open "/home/abdulkadir/projects/haskell/blogAppDB"
  userList <- query conn "SELECT * from users where user_email = ?" (Only email) :: IO [User]
  close conn
  pure userList

insertUser :: Text -> Text -> Text -> IO ()
insertUser userName userEmail userPassword = do
  conn <- open "/home/abdulkadir/projects/haskell/blogAppDB"
  execute conn "INSERT into users (user_name,user_email,user_password) values (?,?,?)" (userName, userEmail, userPassword)
  close conn