module Main where

import Criterion
import Criterion.Main
import qualified HandExamples as H
import qualified GenericLensExamples as GL
import Logic (bigLogic)

import Control.DeepSeq

logicBench name f = env logicEnv (\h -> bench name $ nf f h)

logicEnv = return bigLogic


main = defaultMain [
  bgroup "update/logic" [
      logicBench "hand"  H.updateLogicConst
      , logicBench "gl"  GL.updateLogicConst
   ]
 ]
