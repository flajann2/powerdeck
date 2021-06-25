-- testing the hidapi
module Main where

import qualified System.HIDAPI as H
-- Bus 001 Device 010: ID 0fd9:006c Elgato Systems GmbH Stream Deck XL

main = do
  devinfo <- H.enumerate 0x0fd9::H.VendorID 0x006c::H.ProductID 
  mapM print devinfo
  return ()
  
