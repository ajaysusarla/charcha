module Charcha.Config where

import Prelude (Int)

import Charcha.Types

-- default port to connect to on the IRC server
defaultPort :: Int
defaultPort = 6697


-- This is Charcha's default config
defaultConfig :: CharchaConfig
defaultConfig =
  CharchaConfig { configUser          = Nothing
                , configHost          = Nothing
                , configPort          = defaultPort
                , configPass          = Nothing
                , configBell          = False
                , configNotification  = True
                }
