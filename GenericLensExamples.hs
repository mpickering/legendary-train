{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE NoMonomorphismRestriction #-}
module GenericLensExamples where

import Logic (Logic(..))
import Types
import GHC.Generics
import Control.Monad.Identity

updateStringLogic :: (Char -> Char) -> Logic -> Logic
updateStringLogic f = over types f

updateLogicConst :: Logic -> Logic
updateLogicConst l = updateStringLogic (const 'y') l


over t f = runIdentity . t (Identity . f)

