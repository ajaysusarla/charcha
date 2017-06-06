{-# LANGUAGE TemplateHaskell #-}

module Charcha.Utils (
  -- Functions
  getCharchaVersion
                     ) where

import Prelude (String, (++), (==), take)

import Development.GitRev
import Data.Version (showVersion)
import Paths_charcha (version)

getCharchaVersion :: String
getCharchaVersion = "Charcha version: " ++ showVersion version ++ suffix
  where
    suffix = if $(gitHash) == "UNKNOWN" then "" else "-" ++ take 7 $(gitHash)

