-- Informatics 1 - Functional Programming 
-- Tutorial 4
--
-- Due: the tutorial of week 6 (24/25 Oct)

import Data.List (nub)
import Data.Char
import Test.QuickCheck
import Network.HTTP (simpleHTTP,getRequest,getResponseBody)

-- <type decls>

type Link = String
type Name = String
type Email = String
type HTML = String
type URL = String

-- </type decls>
-- <sample data>

testURL     = "http://www.inf.ed.ac.uk/teaching/courses/inf1/fp/testpage.html"

testHTML :: String
testHTML =    "<html>"
           ++ "<head>"
           ++ "<title>FP: Tutorial 4</title>"
           ++ "</head>"
           ++ "<body>"
           ++ "<h1>A Boring test page</h1>"
           ++ "<h2>for tutorial 4</h2>"
           ++ "<a href=\"http://www.inf.ed.ac.uk/teaching/courses/inf1/fp/\">FP Website</a><br>"
           ++ "<b>Lecturer:</b> <a href=\"mailto:dts@inf.ed.ac.uk\">Don Sannella</a><br>"
           ++ "<b>TA:</b> <a href=\"mailto:c.banks@ed.ac.uk\">Chris Banks</a>"
           ++ "</body>"
           ++ "</html>"

testLinks :: [Link]
testLinks = [ "http://www.inf.ed.ac.uk/teaching/courses/inf1/fp/\">FP Website</a><br><b>Lecturer:</b> "
            , "mailto:dts@inf.ed.ac.uk\">Don Sannella</a><br><b>TA:</b> "
            , "mailto:c.banks@ed.ac.uk\">Chris Banks</a></body></html>" ]


testAddrBook :: [(Name,Email)]
testAddrBook = [ ("Don Sannella","dts@inf.ed.ac.uk")
               , ("Chris Banks","c.banks@ed.ac.uk")]

-- </sample data>
-- <system interaction>

getURL :: String -> IO String
getURL url = simpleHTTP (getRequest url) >>= getResponseBody

emailsFromURL :: URL -> IO ()
emailsFromURL url =
  do html <- getURL url
     let emails = (emailsFromHTML html)
     putStr (ppAddrBook emails)

emailsByNameFromURL :: URL -> Name -> IO ()
emailsByNameFromURL url name =
  do html <- getURL url
     let emails = (emailsByNameFromHTML html name)
     putStr (ppAddrBook emails)

-- </system interaction>
-- <exercises>

-- 1.
sameString :: String -> String -> Bool
sameString s1 s2 = lower s1 == lower s2
  where lower = map toLower


-- 2.
prefix :: String -> String -> Bool
prefix sub str = sub `sameString` take (length sub) str

prop_prefix :: String -> Int -> Bool
prop_prefix str n  =  prefix substr (map toLower str) &&
		      prefix substr (map toUpper str)
                          where
                            substr  =  take n str


-- 3.
{-
snd time trying, still not working
contains (x:xs) (y:ys) | equal x y = contains xs ys
                       | otherwise = contains xs (y:ys)
  where equal m n = toLower m == toLower n

contains _ [] = True
contains _ _ = False
-}

contains' :: String -> String -> Bool
contains' s1 s2 = any (\c -> prefix s2 c) candidates
  where candidates = [drop n s1 | n <- [ 0 .. len ]]
        len = length s1 - length s2

contains :: String -> String -> Bool
contains _ [] = True
contains s1@(x:xs) s2 = prefix s2 s1 || contains xs s2
contains _ _ = False



prop_contains :: String -> Int -> Int -> Bool
prop_contains = undefined


-- 4.
-- took longer than I though
{- what the fuck is this? Why did I think of this way?
takeUntil :: String -> String -> String
takeUntil s1 s2 = helper n
  where helper n | n == len
                 | prefix s1 back = front
                 | otherwise      = helper (n+1)
        front = take n s2
        back = drop n s2
-}

takeUntil :: String -> String -> String
takeUntil substr [] = ""
takeUntil substr (c:cs) | prefix substr (c:cs) = ""
                        | otherwise            = c : takeUntil substr cs

dropUntil :: String -> String -> String
dropUntil sub "" = ""
dropUntil sub str | prefix sub str = drop (length sub) str
                  | otherwise      = dropUntil sub (tail str)


-- 5.
split :: String -> String -> [String]
split sep str
  | str `contains` sep = takeUntil sep str : split sep (dropUntil sep str)
  | otherwise          = [str]

reconstruct :: String -> [String] -> String
reconstruct _ [] = []
reconstruct _ [s] = s
reconstruct sep (x:xs) = (x ++ sep) ++ (reconstruct sep xs)

prop_split :: Char -> String -> String -> Bool
prop_split c sep str = reconstruct sep' (split sep' str) `sameString` str
  where sep' = c : sep

-- 6.
linksFromHTML :: HTML -> [Link]
linksFromHTML html = case splitted of
                       [] -> []
                       xs -> tail xs
  where splitted = split "<a href=\"" html

testLinksFromHTML :: Bool
testLinksFromHTML  =  linksFromHTML testHTML == testLinks


-- 7.
takeEmails :: [Link] -> [Link]
takeEmails links = filter (\l -> prefix "mailto" l) links


-- 8.
link2pair :: Link -> (Name, Email)
link2pair link = (name, email)
  where name = get' ">" "</a>" link
        email = get' ":" "\"" link

get' snd fst link = last $ split snd $ head $ split fst link

-- 9.
emailsFromHTML :: HTML -> [(Name,Email)]
emailsFromHTML = nub. map link2pair . takeEmails . linksFromHTML

testEmailsFromHTML :: Bool
testEmailsFromHTML  =  emailsFromHTML testHTML == testAddrBook


-- 10.
findEmail :: Name -> [(Name, Email)] -> [(Name, Email)]
findEmail shortName = filter f
  where f = (\(fullName, _) -> fullName `contains` shortName)


-- 11.
emailsByNameFromHTML :: HTML -> Name -> [(Name,Email)]
emailsByNameFromHTML html name = findEmail name $ emailsFromHTML html


-- Optional Material

-- 12.
-- ppAddrBook :: [(Name, Email)] -> String
-- ppAddrBook addr = unlines [ name ++ ": " ++ email | (name,email) <- addr ]
-- ppAddrBook addr = unlines [ name ++ ": " ++ email | (name,email) <- addr ]

ppAddrBook :: [(Name, Email)] -> String
ppAddrBook addr = unlines [ prettier (prettyName name) ++ email | (name,email) <- addr ]

prettyName name = reconstruct ", " $ reverse $ split " " name
prettier ugly = head $ take 20 (ugly : repeat " ")
