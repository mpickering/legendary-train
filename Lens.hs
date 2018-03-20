module Lens where

import Control.Monad.Identity

over t f = runIdentity . t (Identity . f)
