{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE TypeApplications #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE NoMonomorphismRestriction #-}
{-# LANGUAGE StandaloneDeriving #-}
{-# LANGUAGE DeriveGeneric #-}
-- Like this for the HsModule example, would be fine with INLINE pragmas on
-- the generic methods
module GenericLensExamples where

import Logic (Logic(..))
import Types
import Lens
import GHC.Generics

updateStringLogic :: (Char -> Char) -> Logic -> Logic
updateStringLogic f = over types f

updateLogicConst :: Logic -> Logic
updateLogicConst l = updateStringLogic (const 'y') l


