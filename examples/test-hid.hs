-- testing the hidapi
{-# LANGUAGE DataKinds #-}
module Main where

import qualified System.HIDAPI as H
-- Bus 001 Device 010: ID 0fd9:006c Elgato Systems GmbH Stream Deck XL

 
main = do
  H.init
  devinfo <- H.enumerate (Just hvendor) Nothing
  devall <- H.enumerateAll

  putStrLn ">> All things:"
  mapM_ print devall

  putStrLn ">> Just Egalto Streamdeck(s):"
  mapM_ print devinfo
  H.exit
  
  where  
    hvendor = 0x0fd9 :: H.VendorID

