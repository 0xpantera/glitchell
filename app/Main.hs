module Main where

import Lib
import System.Environment
import qualified Data.ByteString as BS
import qualified Data.ByteString.Char8 as BC
import Control.Monad


glitchActions :: [BC.ByteString -> IO BC.ByteString]
glitchActions = [randomReplaceByte
                ,randomSortSection
                ,randomReplaceByte
                ,randomSortSection
                ,randomReplaceByte]


main :: IO ()
main = do
  args <- getArgs
  let fileName = head args
  imageFile <- BC.readFile fileName
  glitched <- foldM (\bytes func -> func bytes) imageFile glitchActions
  let glitchedFileName =  mconcat ["glitched_", fileName]
  BC.writeFile glitchedFileName glitched
  print "done"
