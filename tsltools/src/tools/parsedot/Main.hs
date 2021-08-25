----------------------------------------------------------------------------
-- |
-- Module      :  Main
-- Maintainer  :  Morgan Zee, Wonhyuk Choi
-- 
--
-----------------------------------------------------------------------------
{-# LANGUAGE PartialTypeSignatures #-}
module Main
  ( main
  ) where

-----------------------------------------------------------------------------
import TSL (decodeOutputAP) 
import TSL (decodeInputAP)
import Data.Either 
import Data.List.Split
import Data.Char 
import Data.List 

TODO: 
--remove logical operators, decode predicates and updates, put the AND and NOT back to decode 
 
main :: IO ()
main = do  
       filename <- getLine  
       contents <- readFile filename
       putStr contents  

--Splitting at &#10 which indicates the end of a label 

       let specLabels = splitOn "&#10;" contents

--Splitting at / which separates predicate and update terms 

       let predUpPairs = map splitAtDash specLabels 

--Created a list of conjunction terms        
       let conjunctionList = map splitAtAnd (predUpPairs :: [(String,String)])  	
--Created a list of negate terms 
       let notList = map splitAtNot (conjunctionList :: [([String],[String])])

       let loopThrough = map safeDecode (notList :: [([String],[String])])  
       
       let result = map decodeInputWrapper (splitL splitByDash)

--Below are all functions called above  

--TODO: Write splitAtNot function         
splitAtNot :: ([String], [String]) -> ([(String, Bool)]) 
   
--TODO: Write getNot function - map within a map after ::  
getNot :: 

safeDecode :: (String,String) -> _ 
safeDecode c = 
  let
    parsedInput = decodeInputAP $ takeWhile (isAlphaNum)(fst c) 
    parsedOutput = decodeOutputAP (snd c)
  in 
    (parsedInput, parsedOutput)

splitAtDash :: String -> (String,String) 
splitAtDash c = 
  let 
    splitList = splitOn "/" c
  in 
    (head splitList, last splitList)

splitAtAnd :: (String,String) -> ([String],[String]) 
splitAtAnd c = splitOn "&#8743;"
  (splitAtAnd (fst c), splitAtAnd (snd c)) 

decodeInputWrapper :: String -> (String, String)
decodeInputWrapper splitByDash = 
  case splitDash of 
    "&#8743;" -> "AND" 
    "&#172;" -> "NOT"
    other -> 
      case decodeOutputAP other of 
        Left err -> "err" 
        Right result -> result       

Helpful: 
-- | https://stackoverflow.com/questions/7867723/haskell-file-reading

