module Charcha.OptArgs (
  -- Types
  argConfFile
  , argFlag
  -- Functions
  , parseOptArgs
                       ) where

import Prelude ()
import Prelude.Compat

import System.Console.GetOpt
import System.Environment (getArgs)
import System.Exit (exitFailure, exitSuccess)

import Charcha.Utils (getCharchaVersion)

data Flag
  = Normal
  | ShowVersion
  | ShowHelp
    deriving (Eq, Show)

data OptArgs = OptArgs
  {
    argConfFile :: Maybe FilePath
  , argFlag :: Flag
  } deriving (Eq, Show)

defaultOptArgs :: OptArgs
defaultOptArgs = OptArgs
  {
    argConfFile = Nothing
  , argFlag = Normal
  }

optArgsDescr :: [OptDescr (OptArgs -> OptArgs)]
optArgsDescr =
  [
    Option ['c'] ["config"]
    (ReqArg (\ path c -> c { argConfFile = Just path }) "PATH")
    "path to configuration file"
  , Option ['v'] ["version"]
    (NoArg (\ c -> c { argFlag = ShowVersion }))
    "print version information and exit"
  , Option ['h'] ["help"]
    (NoArg (\ c -> c { argFlag = ShowHelp }))
    "display this help and exit"
  ]

usage :: IO ()
usage = putStr (usageInfo "charcha" optArgsDescr)

parseOptArgs :: IO OptArgs
parseOptArgs = do
  args <- getArgs
  case getOpt Permute optArgsDescr args of
    (aps, [], []) -> do
      let rs = foldr (.) id aps defaultOptArgs
      case argFlag rs of
        Normal -> return rs
        ShowHelp -> usage >> exitSuccess
        showVersion -> putStrLn getCharchaVersion >> exitSuccess
    (_, _, []) -> do
      usage
      exitFailure
    (_, _, errs) -> do
      mapM_ putStr errs
      usage
      exitFailure

