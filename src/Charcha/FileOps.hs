{-# LANGUAGE TupleSelections #-}
module FileOps
  ( xdgName
  , configFileName
  , findConfigFile
  ) where

import Prelude

import System.Directory ( doesFileExist
                        , doesDirectoryExist
                        , getPermissions
                        , executable
                        )

import System.Environment.XDG.BaseDir (getUserConfigFile, getAllConfigFiles)

xdgName :: String
xdgName = "Charcha"

configFileName :: FilePath
configFileName = "charcha.cfg"

isExecutable :: FilePath -> IO Bool
isExecutable fp = do
  perm <- getPermissions fp
  return (executable perm)

