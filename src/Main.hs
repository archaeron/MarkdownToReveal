module Main where

import Options.Applicative
import Text.Blaze.Html.Renderer.String

import ParseMd

data Sample = Sample
	{ input :: String
	, quiet :: Bool
	}

headerPath = "html/header.html"
footerPath = "html/footer.html"

sample :: Parser Sample
sample = Sample
	<$> strOption
		( long "input"
		<> metavar "TARGET"
		<> help "Target for the greeting" )
	<*> switch
		( long "quiet"
		<> help "Whether to be quiet" )

greet :: Sample -> IO ()
greet (Sample path False) =
	do	file <- readFile path
		header <- readFile headerPath
		footer <- readFile footerPath
		let html = markDownToslides file
		putStrLn $ header ++ renderHtml html ++ footer
		return ()
greet _ = return ()

main :: IO ()
main = execParser opts >>= greet
	where
		opts = info (helper <*> sample)
			(fullDesc
				<> progDesc "Print a greeting for TARGET"
				<> header "hello - a test for optparse-applicative" )
