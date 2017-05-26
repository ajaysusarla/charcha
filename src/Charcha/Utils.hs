module Utils where

import Prelude ()
import Prelude.Compat

import Data.Version (showVersion)

getCharchaVersion :: String
getCharchaVersion = "Charcha development version: " ++ showVersion version ++ suffix
  where
    suffix = if gitHash == "" then "" else "-" ++ gitHash

getCharchaVersionWithoutGit :: String
getCharchaVersionWithoutGit = "Charcha version: " ++ showVersion version

