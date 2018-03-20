{-# LANGUAGE DeriveAnyClass, DeriveGeneric    #-}

module Logic (
    Logic(..), bigLogic
  ) where

import Data.Int (Int32(..))
import System.Random

import Control.DeepSeq
import GHC.Generics

-- Logic datatype
data Logic = Var String Int
           | T                            -- true
           | F                            -- false
           | Not Logic                    -- not
           | Impl  Logic Logic            -- implication
           | Equiv Logic Logic            -- equivalence
           | Conj  Logic Logic            -- and (conjunction)
           | Disj  Logic Logic            -- or (disjunction)
  deriving (Show, Eq, NFData, Generic)

genLogic :: [Int] -> Int -> Logic
genLogic []  n = case rem n 3 of
                   0 -> Var ("x" ++ show (rem n 10)) n
                   1 -> T
                   _ -> F
genLogic [x] _ = genLogic [] x
genLogic l   n = let (l1, l2) = (tail l, tail (tail l))
                 in case rem (head l) 5 of
                      0 -> Impl  (genLogic l1 n) (genLogic l2 n)
                      1 -> Equiv (genLogic l1 n) (genLogic l2 n)
                      2 -> Conj  (genLogic l1 n) (genLogic l2 n)
                      4 -> Disj  (genLogic l1 n) (genLogic l2 n)
                      _ -> Not (genLogic l1 n)


bigLogics :: [Logic]
bigLogics = [bigLogicGen seed | seed <- [123456789..223456789]]

bigLogicGen :: Int -> Logic
bigLogicGen seed = let (s1, s2) = select $ randomRs (0,100) (mkStdGen seed)
                       select (h:t) = (take 29 t, h)
                   in genLogic s1 s2

-- Big Logic expression (size 810250)
bigLogic :: Logic
bigLogic = head bigLogics

