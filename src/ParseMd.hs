{-# LANGUAGE OverloadedStrings #-}

module ParseMd where

import Data.List.Split (splitOn)
import Control.Monad (forM_)
import Text.Blaze.Html5 as H
import Text.Blaze.Html5.Attributes as A

-- Markdown

splitMd :: String -> [String]
splitMd = splitOn "\n---\n"

-- Slides

mdScript :: String -> Html
mdScript md = H.script ! A.type_ "text/template" $ toHtml md

mdSection :: String -> Html
mdSection md = H.section ! dataAttribute "markdown" "" $ mdScript md

mdSections :: [String] -> Html
mdSections mds = forM_ mds mdSection

-- Markdown -> Slides

markDownToslides :: String -> Html
markDownToslides = mdSections . splitMd 
