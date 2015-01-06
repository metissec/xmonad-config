import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Actions.CycleWS
import XMonad.Actions.SpawnOn
import qualified XMonad.StackSet as W
import System.IO


main = do
    xmproc <- spawnPipe "xmobar"

    xmonad $ defaultConfig
        { terminal = "urxvt"
	, modMask = myModMask
	, focusedBorderColor = "#0000ff"
	, startupHook = do
	  	      spawnOn "1" "urxvt"
		      spawnOn "1" "/home/james/.send_vol.sh"
	, manageHook = manageDocks <+> manageHook defaultConfig
        , layoutHook = avoidStruts  $  layoutHook defaultConfig
        , logHook = dynamicLogWithPP xmobarPP
                        { ppOutput = hPutStrLn xmproc
                        , ppTitle = xmobarColor "green" "" . shorten 25
                        }
	} `additionalKeys`
	[((myModMask, xK_y), spawn "chromium")
	,((myModMask, xK_u), spawn "emacs")
	,((myModMask, xK_grave), spawn "urxvt -e sudo wifi-menu")
	,((mod1Mask , xK_F1), windows W.focusUp)
	,((mod1Mask , xK_F2), windows W.focusDown)
	,((0        , xK_F1), prevWS)
   	,((0        , xK_F2), nextWS)
	,((0        , xK_F6), spawn "xbacklight -dec 10")
	,((0        , xK_F7), spawn "xbacklight -inc 10")
	,((0        , xK_F8), spawn "amixer set Master toggle && /home/james/.send_vol.sh")
	,((0        , xK_F9), spawn "amixer set Master 10- unmute && /home/james/.send_vol.sh")
	,((0        , xK_F10),spawn "amixer set Master 10+ unmute && /home/james/.send_vol.sh")
	]
	
myModMask = mod4Mask
