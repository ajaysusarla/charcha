module Charcha.Types (
) where

import Prelude(Int, Bool, Eq, Show)

import Data.Maybe
import qualified Data.Text as T

-- Session
-- The data that we carry around, contains the session information
-- data CharchaSession  = CharchaSession
--   {
--   }

-- Configuration
-- As read from the config file.
data CharchaConfig = CharchaConfig
  {
    configUser :: Maybe T.Text
  , configHost :: Maybe T.Text
  , configPort :: Int
  , configPass :: Maybe T.Text -- This needs to change and some point
  , configBell :: Bool
  , configNotification :: Bool
  } deriving (Eq, Show)
