module Main where

import qualified HandExamples as H
import qualified GenericLensExamples as GL
import Logic (bigLogic)

import Control.DeepSeq

{-
These should be same speed, with the late-specialisation pass, they are.

Otherwise GL is about 2x as slow as Hand
-}

main =
--  print $ rnf $ H.updateLogicConst bigLogic
  print $ rnf $ GL.updateLogicConst bigLogic
