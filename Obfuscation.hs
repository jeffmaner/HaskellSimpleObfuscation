module Obfuscation (obfuscate, obfuscateEx) where

import Data.Char (isAlpha, isAlphaNum, isNumber, isUpper)
import System.Random (randomR, StdGen)

obfuscate :: StdGen -> String -> String
obfuscate g = fst . _obfuscate g

obfuscateEx :: [String] -> StdGen -> String -> String
obfuscateEx exceptions g c =
  let (gen,obfuscatedLines) = foldl obfuscateLine (g,[]) $ lines c
   in unlines $ reverse obfuscatedLines
  where obfuscateLine (gen,obf) line =
          let (gen',obfuscatedWords) = foldl obfuscateWord (gen,[]) $ words' line
           in (gen', (concat $ reverse obfuscatedWords):obf)
        obfuscateWord (gen,obf) word =
          if word `elem` exceptions
          then (gen, word:obf)
          else let (obf',gen') = _obfuscate gen word in (gen',obf':obf)

words' :: String -> [String]
words' text = f text [] 1
  where f [] a _ = reverse a
        f text@(c:cs) a s = let (h,t) = g isAlphaNum text in f t (h:a) s'
          where (g,s') = if s>0 then (break, 0) else (span, 1)

_obfuscate :: StdGen -> String -> (String, StdGen)
_obfuscate g = obfuscate' g []
  where
    obfuscate' g a [] = (reverse a, g)
    obfuscate' g a text@(c:cs)
      | isAlpha  c = obf obfuscateAlpha g a text
      | isNumber c = obf obfuscateDigit g a text
      | otherwise  = obf id             g a text
    obf f g a (c:cs) = let (x,g') = f (c,g) in obfuscate' g' (x:a) cs

obfuscateAlpha, obfuscateDigit :: (Char, StdGen) -> (Char, StdGen)
obfuscateAlpha (c,g) = obfuscateChar g range
  where range
          | isUpper c = ('A','Z')
          | otherwise = ('a','z')

obfuscateDigit (c,g) = obfuscateChar g ('0','9')

obfuscateChar :: StdGen -> (Char, Char) -> (Char, StdGen)
obfuscateChar = flip randomR

-- vim: fenc=utf-8: guifont=DejaVu\ Sans\ Mono
