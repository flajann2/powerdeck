-- testing the hidapi
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE RankNTypes #-}
module Main where

import qualified System.HIDAPI as H
import Text.Printf

main = do
  H.init
  devinfo <- H.enumerate (Just hvendor) Nothing
  devall <- H.enumerateAll

  printf ">> All things: \n"
  mapM_ print devall

  printf ">> Just Egalto Streamdeck(s): \n"
  mapM_ print devinfo
  if length(devinfo) > 0
    then do
      printf ">> Streamdeck discovered. Doing button test.\n"
      dev <- H.openDeviceInfo (head(devinfo))
      H.setBlocking dev True
      keyread dev
      H.close dev
    else printf ">> No Streamdecks found."
  H.exit
  
  where  
    hvendor = 0x0fd9 :: H.VendorID
    keyread d = do
      printf ">>> waiting for key \n"
      bs <- H.read d 32
      printf "   Read %d bytes: \n" length(bs)
      print bs
      keyread d
