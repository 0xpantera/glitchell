module Main where

import Lib
import System.Environment
import qualified Data.ByteString as BS
import qualified Data.ByteString.Char8 as BC


main :: IO ()
main = do
  args <- getArgs
  let fileName = head args
  imageFile <- BC.readFile fileName
  glitched <- randomReplaceByte imageFile
  let glitchedFileName =  mconcat ["glitched_", fileName]
  BC.writeFile glitchedFileName glitched
  print "done"
