module Main where

import Charcha.Utils (getCharchaVersion)
main :: IO ()
main = do
  putStrLn getCharchaVersion

