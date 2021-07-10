-- Test of GUI and Yampa FRP
{-# LANGUAGE OverloadedLabels  #-}
{-# LANGUAGE OverloadedLists   #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards   #-}

module Main where

import           Control.Monad                  ( void )
import           Data.Text                      ( Text, pack )
import           GI.Gtk                         ( Button(..)
                                                , Grid(..)
                                                , Label(..)
                                                , Window(..)
                                                )
import           GI.Gtk.Declarative
import           GI.Gtk.Declarative.App.Simple
import           GI.Gtk.Declarative.Container.Grid

data State = State (Maybe Text)

data Event =
  Confirmed
  | Cancelled
  | Closed
  | Apple
  | Bananna
  | Carrot
  | Durian

view' :: State -> AppView Window Event
view' (State msg) =
  bin
      Window
      [ #title := "Test GUI"
      , on #deleteEvent (const (True, Closed))
      , #widthRequest := 640
      , #heightRequest := 400
      ]
    $ container
        Grid
        [ #rowSpacing := 5
        , #columnSpacing := 5
        , #margin := 2]
        [ GridChild
          { properties = defaultGridChildProperties { width = 3, height = 3 }
          , child      = widget Button [#label := "Apple"
                                       , #vexpand := True
                                       , on #clicked Apple]
          }
        , GridChild
          { properties = defaultGridChildProperties { width      = 3
                                                    , height     = 1
                                                    , leftAttach = 3
                                                    }
          , child = widget Button
                           [#label := "Bananna"
                           , #hexpand := True
                           , #vexpand := True
                           , on #clicked Bananna]
          
          }
        , GridChild
          { properties = defaultGridChildProperties { width      = 2
                                                    , height     = 2
                                                    , leftAttach = 3
                                                    , topAttach  = 1
                                                    }
          , child = widget Button
                           [#label := "Carrot"
                           , #hexpand := True
                           , #vexpand := True
                           , on #clicked Carrot]
          }
        , GridChild
          { properties = defaultGridChildProperties { width      = 1
                                                    , height     = 1
                                                    , leftAttach = 5
                                                    , topAttach  = 2
                                                    }
          , child      = widget Button [#label := "Durian"
                                       , on #clicked Durian]
          }
        ]

update' :: State -> Event -> Transition State Event
-- update' State Closed = Exit
update' _ Apple = Transition (State (Just "Apple.")) (pure Nothing)
update' _ Bananna = Transition (State (Just "Bananna.")) (pure Nothing)
update' _ Durian = Transition (State (Just "Durian.")) (pure Nothing)
update' _ Carrot = Transition (State (Just "Carrot.")) (pure Nothing) 
update' _ Closed = Exit

main :: IO ()
main = void $ run App { view         = view'
                      , update       = update'
                      , inputs       = []
                      , initialState = State Nothing
                      }
