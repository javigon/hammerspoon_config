-- hs main configuration
-- Copyright Javier González (javier@javigon.com)
--
-- Inspiration on:
--	- Tristan Hume's configuration
--	- Chris Jones' configuration


--TODO list
--	- Define layouts for all applications
--
--
-- Load Extensions ============================================
local application = hs.application
local window      = hs.window
local hotkey      = hs.hotkey
local keycodes = hs.keycodes
local fnutils     = hs.fnutils
local alert       = hs.alert
local grid        = hs.grid
local tiling = hs.tiling
local screen = hs.screen
local hints = hs.hints
local appfinder = hs.appfinder
local layout = hs.layout
local applescript = hs.applescript

-- Load own extensions ========================================
require "layouts"
require "screen_detector"
require "grid_setup"

-- Set up hotkey combinations =================================
local mash      = {"cmd", "alt", "ctrl"}
local mashshift = {"cmd", "alt", "shift"}
local cmdshift = {"cmd",  "shift"}
local altshift = {"alt", "shift"}

--Watcherts and internal objects ==============================
local hsConfigFileWatcher = nil

-- Internal operations ========================================
local gridset = function(frame)
	return function()
		local win = window.focusedWindow()
		if win then
			grid.set(win, frame, win:screen())
		else
			alert.show("No focused window.")
		end
	end
end

function saveFocus()
	auxWin = window.focusedWindow()
	alert.show("Window '" .. auxWin:title() .. "' saved.")
end

function focusSaved()
	if auxWin then
		auxWin:focus()
	end
end

-- Application specific ======================================

function reloadConfig(paths)
	doReload = false
	for _,file in pairs(paths) do
		if file:sub(-4) == ".lua" then
			print("A lua file changed, doing reload")
						doReload = true
		end
	end
	if not doReload then
		print("No lua file changed, skipping reload")
		return
	end

	hs.reload()
end

function loadItermProfile()
	applescript.applescript(
		"tell application \"iTerm\" \
		create window with profile \"uHalley\" \
		end tell"
		)
end

function loadItermProfileLocal()
	applescript.applescript(
		"tell application \"iTerm\" \
		create window with profile \"Default\" \
		end tell"
		)
end

-- Automatic Operations =======================================
-- hsConfigFileWatcher = hs.pathwatcher.new(os.getenv("HOME") .. "/.", reloadConfig)
-- hsConfigFileWatcher:start()

screenWatcher = screen.watcher.new(reloadScreens)
screenWatcher:start()

defineLayout()

-- Launch Applications ========================================
	hotkey.bind(cmdshift, "T", function() application.launchOrFocus("iTerm") end)
	hotkey.bind(cmdshift, "A", function() application.launchOrFocus("Alfred 2") end)
	hotkey.bind(cmdshift, 'N', function() loadItermProfile() end)
	hotkey.bind(cmdshift, 'J', function() loadItermProfileLocal() end)
	hotkey.bind(mashshift, "R", hs.reload)

-- Applications Interaction (not from hammerspoon)
-- mashshift + P: Start Pomodoro (stop notifications + rescuetime + timer)
-- mashshift + C: See world clock + calendar
-- cmd + spacebar: Alfred
-- option + spacebar: FullContact

-- Key bindings ===============================================
	hotkey.bind(mashshift, 'F', function() applyLayout(work_layout) end)
	hotkey.bind(mashshift, 'D', function() launchApp(work_layout) end)
	hotkey.bind(mashshift, 'G', function() reloadScreens() end)

	-- hotkey.bind(mashshift, ';', saveFocus)
	-- hotkey.bind(mashshift, "'", focusSaved)

	hotkey.bind(mashshift, 'left', gridset(goleft))
	hotkey.bind(mashshift, 'right', gridset(goright))
	hotkey.bind(mashshift, 'up', grid.maximizeWindow)
	hotkey.bind(mashshift, 'down',  grid.pushWindowNextScreen)

	hotkey.bind(altshift, 'left',  gridset(goupleft))
	hotkey.bind(altshift, 'right', gridset(goupright))
	hotkey.bind(cmdshift, 'left',  gridset(godownleft))
	hotkey.bind(cmdshift, 'right', gridset(godownright))

	hotkey.bind(mashshift, 'M', gridset(gomiddle))

	hotkey.bind(mashshift, 'J', grid.pushWindowDown)
	hotkey.bind(mashshift, 'K', grid.pushWindowUp)
	hotkey.bind(mashshift, 'H', grid.pushWindowLeft)
	hotkey.bind(mashshift, 'L', grid.pushWindowRight)

	hotkey.bind(mashshift, 'U', grid.resizeWindowTaller)
	hotkey.bind(mashshift, 'O', grid.resizeWindowWider)
	hotkey.bind(mashshift, 'I', grid.resizeWindowThinner)
	hotkey.bind(mashshift, 'Y', grid.resizeWindowShorter)

	hotkey.bind(cmdshift, 'space',  function() hints.windowHints(window.focusedWindow():application():allWindows()) end)
	hotkey.bind(mashshift, 'space',  function() hints.windowHints(nil) end)
	hotkey.bind(mashshift, 'T', function() alert.show(os.date("%A %b %d, %Y - %I:%M%p"), 4) end)

	alert.show("Hammerspoon, at your service.", 3)
