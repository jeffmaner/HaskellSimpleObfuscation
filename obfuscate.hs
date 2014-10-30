module Main where

import Obfuscation (obfuscate, obfuscateEx)
import System.Environment (getArgs)
import System.Random (getStdGen)

helpMessage = [ "Usage: cat filename(s) | obfuscate [-x filename] > filename",
  "",
  "Obfuscates text files. This obliterates the text--there is no recovery. This",
  "is not encryption. It's simple, if slow, obfuscation.",
  "",
  "To include a list of words not to obfuscate, use the -x option. List one word",
  "per line in the file.",
  "" ]

data CLOpts = CLOpts { help           :: Bool
                     , exceptionFileP :: Bool
                     , exceptionFile  :: String }

main = do
  args <- getArgs
  let opts = parseCL args CLOpts { help=False, exceptionFileP=False, exceptionFile="" }
  if help opts
  then do putStrLn $ unlines helpMessage
  else do
    g <- getStdGen
    c <- getContents
    if exceptionFileP opts
    then do exceptions <- readFile $ exceptionFile opts
            putStrLn $ obfuscateEx (lines exceptions) g c
    else do putStrLn $ obfuscate g c

parseCL :: [String] -> CLOpts -> CLOpts
parseCL []          opts = opts
parseCL ("-x":f:xs) opts = parseCL xs opts { exceptionFileP=True, exceptionFile=f }
parseCL      (_:xs) opts = parseCL xs opts { help=True }

-- vim: fenc=utf-8: guifont=DejaVu\ Sans\ Mono
