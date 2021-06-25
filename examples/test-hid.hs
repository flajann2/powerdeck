-- testing the hidapi
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE RankNTypes #-}
module Main where

import qualified System.HIDAPI as H
 
main = do
  H.init
  devinfo <- H.enumerate (Just hvendor) Nothing
  devall <- H.enumerateAll

  putStrLn ">> All things:"
  mapM_ print devall

  putStrLn ">> Just Egalto Streamdeck(s):"
  mapM_ print devinfo
  if length(devinfo) > 0
    then do
      putStrLn ">> Streamdeck discovered. Doing button test."
      dev <- H.openDeviceInfo (head(devinfo))
      H.setBlocking dev True
      keyread dev
      H.close dev
    else putStrLn ">> No Streamdecks found."
  H.exit
  
  where  
    hvendor = 0x0fd9 :: H.VendorID
    keyread d = do
      putStrLn ">>> waiting for key"
      bs <- H.read d 32
      print bs
      keyread d
