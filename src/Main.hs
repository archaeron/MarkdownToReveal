module Main where

import Data.Maybe
import Control.Applicative
import Options.Applicative as Opts
import Text.Blaze.Html.Renderer.String

import ParseMd

data Params = Params
	{ inputPath :: String
	, outputPath :: String
	, headerPath :: Maybe String
	, footerPath :: Maybe String
	}

defaultHeaderPath :: String
defaultHeaderPath = "html/header.html"

defaultFooterPath :: String
defaultFooterPath = "html/footer.html"

inputParser :: Parser String
inputParser = strOption $
	long "input"
	<> short 'i'
	<> metavar "FILE"
	<> help "The input path."

outputParser :: Parser String
outputParser = strOption $
	long "output"
	<> short 'o'
	<> metavar "TARGET"
	<> help "The output path."

headerParser :: Parser (Maybe String)
headerParser = optional . strOption $
	long "header"
	<> short 'h'
	<> metavar "FILE"
	<> help "A custom header to insert before the output."

footerParser :: Parser (Maybe String)
footerParser = optional . strOption $
	long "footer"
	<> short 'f'
	<> metavar "FILE"
	<> help "A custom footer to insert after the output."

parser :: Parser Params
parser = Params
	<$> inputParser
	<*> outputParser
	<*> headerParser
	<*> footerParser

revealify :: Params -> IO ()
revealify params =
	do	file <- readFile $ inputPath params
		headerFile <- readFile $ fromMaybe defaultHeaderPath (headerPath params)
		footerFile <- readFile $ fromMaybe defaultFooterPath (footerPath params)
		let html = markDownToslides file
		writeFile (outputPath params) $ headerFile ++ renderHtml html ++ footerFile

main :: IO ()
main = execParser opts >>= revealify
	where
		opts = info (helper <*> parser)
			(fullDesc
				<> progDesc "Markdown to Reveal.js"
				<> header "MarkdownToReveal" )
