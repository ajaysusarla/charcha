module Charcha.IRC.Types (
  -- Type Synonyms
    Command
  , Parameter
  , RealName
  , ServerName
  , UserName
  -- IRC Types
  , IRCMessage(..)
  , Prefix(..)
  -- Functions
  , mkIRCMessage
  ) where

import Data.ByteString(ByteString)

type Command = ByteString
type Parameter = ByteString
type RealName = ByteString
type ServerName = ByteString
type UserName = ByteString


-- According to https://tools.ietf.org/html/rfc2813#section-3.3:
-- Each IRC message may consist of up to three main parts: the prefix
-- (OPTIONAL), the command, and the command parameters (maximum of
-- fifteen (15)).  The prefix, command, and all parameters are separated
--  by one ASCII space character (0x20) each.
--
-- prefix(OPTIONAL) command parameters
data Prefix =
  Server ServerName
  | NickName ByteString (Maybe UserName) (Maybe ServerName)
    deriving (Show, Read, Eq)

data IRCMessage = IRCMessage
  {
    prefix :: Maybe Prefix
  , command :: Command
  , params :: [Parameter]
  } deriving (Show, Read, Eq)


mkIRCMessage :: Command -> [Parameter] -> IRCMessage
mkIRCMessage = IRCMessage Nothing
