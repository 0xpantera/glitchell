{-# LANGUAGE OverloadedStrings #-}
module Lib
    ( randomReplaceByte
    , randomSortSection
    ) where

import qualified Data.ByteString as BS
import qualified Data.ByteString.Char8 as BC
import System.Random


intToChar :: Int -> Char
intToChar int = toEnum safeInt
  where safeInt = int `mod` 255


intToBc :: Int -> BC.ByteString
intToBc int = BC.pack [intToChar int]


replaceByte :: Int -> Int -> BC.ByteString -> BC.ByteString
replaceByte loc charVal bytes = mconcat [before,newChar,after]
  where (before, rest) = BC.splitAt loc bytes
        after = BC.drop 1 rest
        newChar = intToBc charVal


randomReplaceByte :: BC.ByteString -> IO BC.ByteString
randomReplaceByte bytes = do
  let bytesLength = BC.length bytes
  location <- randomRIO (1,bytesLength)
  charVal <- randomRIO (0,255)
  return (replaceByte location charVal bytes)  

-- More sophisticated approach:

sortSection :: Int -> Int -> BC.ByteString -> BC.ByteString
sortSection start size bytes = mconcat [before,changed,after]
  where (before,rest) = BC.splitAt start bytes
        (target,after) = BC.splitAt size rest
        changed = BC.reverse (BC.sort target)


randomSortSection :: BC.ByteString -> IO BC.ByteString
randomSortSection bytes = do
  let sectionSize = 25 --arbitrary section size
  let bytesLength = BC.length bytes
  start <- randomRIO (0,bytesLength - sectionSize)
  return (sortSection start sectionSize bytes)  
