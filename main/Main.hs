module Main where

import Prelude

import Charcha.Utils (getCharchaVersion)
main :: IO ()
main = do
  putStrLn getCharchaVersion

