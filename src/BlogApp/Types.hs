{-# LANGUAGE DeriveAnyClass #-}

module BlogApp.Types where

import Data.Text (Text)
import Database.SQLite.Simple.FromRow (FromRow)
import GHC.Generics (Generic)

data User = User
  { userId :: Integer,
    userName :: Text,
    userEmail :: Text,
    userPassword :: Text
  }
  deriving (Eq, Show, Generic, FromRow)