-- Mjolnir layout configuration
-- Copyright Javier González (javier@javigon.com)
--

local grid =  hs.grid
local window = hs.window
local geometry = hs.geometry

window.animationDuration = 0;

grid.GRIDWIDTH  = 8
grid.GRIDHEIGHT = 8
grid.MARGINX    = 0
grid.MARGINY    = 0

gw = grid.GRIDWIDTH
gh = grid.GRIDHEIGHT

-- General positions
gomiddle = {x = 1, y = 1, w = 6, h = 6}
goleft = {x = 0, y = 0, w = gw/2, h = gh}
goright = {x = gw/2, y = 0, w = gw/2, h = gh}
goupright = {x = gw/2, y = 0, w = gw/2, h = gh/2}
godownright = {x = gw/2, y = gh/2, w = gw/2, h = gh/2}
goupleft = {x = 0, y = 0, w = gw/2, h = gh/2}
godownleft = {x = 0, y = gh/2, w = gw/2, h = gh/2}
goup = {x = 0, y = 0, w = gw, h = gh/2}
godown = {x = 0, y = gh/2, w = gw, h = gh/2}
gobig = {x = 0, y = 0, w = gw, h = gh}

-- Widescreen positions
gocenterw = {x = 2, y = 1, w = 4, h = 5}
goleftw = {x = 0, y = 0, w = gw/3, h = gh}
gomiddlew = {x = gw/3, y = 0, w = gw/3, h = gh}
gouprightw = {x = 2*gw/3, y = 0, w = gw/3, h = gh/2}
godownrightw = {x = 2*gw/3, y = gh/2, w = gw/3, h = gh/2}

gomiddlew_of = {x = gw/3, y = 0, w = 1.2*gw/3, h = gh}
gouprightw_of = {x = 2.2*gw/3, y = 0, w = 0.8*gw/3, h = gh/2}
godownrightw_of = {x = 2.2*gw/3, y = gh/2, w = 0.8*gw/3, h = gh/2}
gorightw_of = {x = 2.2*gw/3, y = 0, w = 0.8*gw/3, h = gh}

-- Custom positions
goupright_adium_contact = {x = gw/2 + (gw/2 - gw/2.2) , y = 0 , w = gw/10, h = gh/2}
goupright_adium_chat = {x = gw/2 + (gw/2 - gw/2.2) + gw/10 , y = 0 , w = gw/2.2 - gw/10, h = gh/2}
goupright_omnifocus = {x = gw/2 + (gw/2 - gw/2.2) , y = 0 , w = gw/2.2, h = gh/2}
godownright_omnifocus = {x = gw/2 + (gw/2 - gw/2.2) , y = gh/2 , w = gw/2.2, h = gh/2}
goleft_omnifocus = {x = 0, y = 0, w = gw/2 + (gw/2 - gw/2.2) , h = gh}

--TODO: 60 - 40, 70 - 30, custom configurations
