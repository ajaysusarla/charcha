{-# LANGUAGE TemplateHaskell #-}

module Charcha.Utils where

import Prelude (String, (++), (==), take)
--import Prelude.Compat (String, (++), (==), take)

import Development.GitRev
import Data.Version (showVersion)
import Paths_charcha (version)

getCharchaVersion :: String
getCharchaVersion = "Charcha development version: " ++ showVersion version ++ suffix
  where
    suffix = if $(gitHash) == "" then "" else "-" ++ take 7 $(gitHash)

getCharchaVersionWithoutGit :: String
getCharchaVersionWithoutGit = "Charcha version: " ++ showVersion version

