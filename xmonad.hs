import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Actions.CycleWS
import System.IO


main = do
    xmproc <- spawnPipe "xmobar"

    xmonad $ defaultConfig
        { terminal = "urxvt"
	, focusedBorderColor = "#0000ff"
	, manageHook = manageDocks <+> manageHook defaultConfig
        , layoutHook = avoidStruts  $  layoutHook defaultConfig
        , logHook = dynamicLogWithPP xmobarPP
                        { ppOutput = hPutStrLn xmproc
                        , ppTitle = xmobarColor "green" "" . shorten 25
                        }
	} `additionalKeys`
	[((mod1Mask, xK_y), spawn "chromium")
	,((mod1Mask, xK_u), spawn "emacs")
	,((0       , xK_F1), prevWS)
   	,((0       , xK_F2), nextWS)
	,((0       , xK_F6), spawn "xbacklight -dec 10")
	,((0       , xK_F7), spawn "xbacklight -inc 10")
	,((0       , xK_F8), spawn "amixer set Master toggle")
	,((0       , xK_F9), spawn "amixer set Master 10- unmute")
	,((0       , xK_F10),spawn "amixer set Master 10+ unmute")
	]
