-- You are given a perfect binary tree where all leaves are on the same level, and every parent has two children. The binary tree has the following definition:

-- Populate each next pointer to point to its next right node. If there is no next right node, the next pointer should be set to Nothing.

module Connect
  (
    connect
  , Tree(..)
  ) where

connect :: Tree a -> [Next a]
connect = fromList . connect'

connect' :: Tree a -> [[a]]
connect' Empty = []
connect' (Node a b c) = [a] : flattern (connect' b) (connect' c)

flattern :: [[a]] -> [[a]] -> [[a]]
flattern a [] = a
flattern [] a = a
flattern (x:xs) (y:ys) = (x ++ y) : flattern xs ys

fromList :: [[a]] -> [Next a]
fromList [] = []
fromList (x:xs) = next x ++ fromList xs
  where next :: [a] -> [Next a]
        next [] = []
        next [a] = [Next a Nothing]
        next (a:c@(b:_)) = Next a (Just b) : next c

data Tree a = Empty
            | Node a (Tree a) (Tree a) deriving (Eq, Show)

data Next a = Next { value :: a
                   , next :: Maybe a } deriving (Eq, Show)
