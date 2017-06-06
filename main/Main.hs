---------------------------------------------------------------
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
-- module Main where

-- import Lens.Micro ((^.), (&), (.~), (%~))
-- import Lens.Micro.TH (makeLenses)
-- import Control.Monad (void, forever)
-- import Control.Concurrent (threadDelay, forkIO)
-- import Data.Monoid
-- import qualified Graphics.Vty as V

-- import Brick.BChan
-- import Brick.Main
--   ( App(..)
--   , showFirstCursor
--   , customMain
--   , continue
--   , halt
--   )
-- import Brick.AttrMap
--   ( attrMap
--   )
-- import Brick.Types
--   ( Widget
--   , Next
--   , EventM
--   , BrickEvent(..)
--   )
-- import Brick.Widgets.Core
--   ( (<=>)
--   , str
--   )

-- data CustomEvent = Counter deriving Show

-- data St =
--     St { _stLastBrickEvent :: Maybe (BrickEvent () CustomEvent)
--        , _stCounter :: Int
--        }

-- makeLenses ''St

-- drawUI :: St -> [Widget ()]
-- drawUI st = [a]
--     where
--         a = (str $ "Last event: " <> (show $ st^.stLastBrickEvent))
--             <=>
--             (str $ "Counter value is: " <> (show $ st^.stCounter))

-- appEvent :: St -> BrickEvent () CustomEvent -> EventM () (Next St)
-- appEvent st e =
--     case e of
--         VtyEvent (V.EvKey V.KEsc []) -> halt st
--         VtyEvent _ -> continue $ st & stLastBrickEvent .~ (Just e)
--         AppEvent Counter -> continue $ st & stCounter %~ (+1)
--                                           & stLastBrickEvent .~ (Just e)
--         _ -> continue st

-- initialState :: St
-- initialState =
--     St { _stLastBrickEvent = Nothing
--        , _stCounter = 0
--        }

-- theApp :: App St CustomEvent ()
-- theApp =
--     App { appDraw = drawUI
--         , appChooseCursor = showFirstCursor
--         , appHandleEvent = appEvent
--         , appStartEvent = return
--         , appAttrMap = const $ attrMap V.defAttr []
--         }

-- main :: IO ()
-- main = do
--     chan <- newBChan 10

--     _ <- forkIO $ forever $ do
--         writeBChan chan Counter
--         threadDelay 1000000

--     void $ customMain (V.mkVty V.defaultConfig) (Just chan) theApp initialState
-----------------------------------------------------

-- {-# LANGUAGE OverloadedStrings #-}
-- {-# LANGUAGE TemplateHaskell #-}
-- module Main where

-- import Lens.Micro ((^.), (&), (%~))
-- import Lens.Micro.TH (makeLenses)
-- import Control.Monad (void)
-- import qualified Graphics.Vty as V

-- import qualified Brick.Types as T
-- import Brick.Types (locationRowL, locationColumnL, Widget)
-- import qualified Brick.Main as M
-- import qualified Brick.Widgets.Border as B
-- import qualified Brick.Widgets.Center as C
-- import Brick.Widgets.Core
--   ( translateBy
--   , str
--   )
-- import Brick.AttrMap
--   ( attrMap
--   )

-- data St =
--     St { _topLayerLocation :: T.Location
--        , _bottomLayerLocation :: T.Location
--        }

-- makeLenses ''St

-- drawUi :: St -> [Widget ()]
-- drawUi st =
--     [ C.centerLayer $
--       B.border $ str "This layer is centered but other\nlayers are placed underneath it."
--     , topLayer st
--     , bottomLayer st
--     ]

-- topLayer :: St -> Widget ()
-- topLayer st =
--     translateBy (st^.topLayerLocation) $
--     B.border $ str "Top layer\n(Arrow keys move)"

-- bottomLayer :: St -> Widget ()
-- bottomLayer st =
--     translateBy (st^.bottomLayerLocation) $
--     B.border $ str "Bottom layer\n(Ctrl-arrow keys move)"

-- appEvent :: St -> T.BrickEvent () e -> T.EventM () (T.Next St)
-- appEvent st (T.VtyEvent (V.EvKey V.KDown []))  =
--     M.continue $ st & topLayerLocation.locationRowL %~ (+ 1)
-- appEvent st (T.VtyEvent (V.EvKey V.KUp []))    =
--     M.continue $ st & topLayerLocation.locationRowL %~ (subtract 1)
-- appEvent st (T.VtyEvent (V.EvKey V.KRight [])) =
--     M.continue $ st & topLayerLocation.locationColumnL %~ (+ 1)
-- appEvent st (T.VtyEvent (V.EvKey V.KLeft []))  =
--     M.continue $ st & topLayerLocation.locationColumnL %~ (subtract 1)

-- appEvent st (T.VtyEvent (V.EvKey V.KDown  [V.MCtrl])) =
--     M.continue $ st & bottomLayerLocation.locationRowL %~ (+ 1)
-- appEvent st (T.VtyEvent (V.EvKey V.KUp    [V.MCtrl])) =
--     M.continue $ st & bottomLayerLocation.locationRowL %~ (subtract 1)
-- appEvent st (T.VtyEvent (V.EvKey V.KRight [V.MCtrl])) =
--     M.continue $ st & bottomLayerLocation.locationColumnL %~ (+ 1)
-- appEvent st (T.VtyEvent (V.EvKey V.KLeft  [V.MCtrl])) =
--     M.continue $ st & bottomLayerLocation.locationColumnL %~ (subtract 1)

-- appEvent st (T.VtyEvent (V.EvKey V.KEsc [])) = M.halt st
-- appEvent st _ = M.continue st

-- app :: M.App St e ()
-- app =
--     M.App { M.appDraw = drawUi
--           , M.appStartEvent = return
--           , M.appHandleEvent = appEvent
--           , M.appAttrMap = const $ attrMap V.defAttr []
--           , M.appChooseCursor = M.neverShowCursor
--           }

-- main :: IO ()
-- main = void $ M.defaultMain app $ St (T.Location (0, 0)) (T.Location (0, 0))

-----------------------------------------------------
module Main where

import Prelude

import Brick()
import Brick.BChan()
-- import qualified Graphics.Vty as Vty

import Charcha.OptArgs (parseOptArgs)

main :: IO ()
main = do
  opts <- parseOptArgs
  putStrLn "Nothing for now."

