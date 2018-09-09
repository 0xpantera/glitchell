{-# LANGUAGE OverloadedStrings #-}
module Lib
    ( someFunc
    ) where

import qualified Data.ByteString as BS
import qualified Data.ByteString.Char8 as BC


someFunc = putStrLn "Hello"

intToChar :: Int -> Char
intToChar int = toEnum safeInt
  where safeInt = int `mod` 255

intToBc :: Int -> BC.ByteString
intToBc int = BC.pack [intToChar int]
