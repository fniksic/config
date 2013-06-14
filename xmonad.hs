import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Util.EZConfig
import XMonad.Util.Run(spawnPipe)
import System.IO

myTerminal           = "urxvtc"
myModMask            = mod4Mask
myBorderWidth        = 1
myNormalBorderColor  = "#dddddd"
myFocusedBorderColor = "#ff0000"

myManageHook = composeAll
    [ className =? "Skype" --> doFloat
    ]

myLogHook h = dynamicLogWithPP myXmobarPP { ppOutput = hPutStrLn h }

myXmobarPP = xmobarPP
    { ppTitle = xmobarColor "white" "" . shorten 50
    }

myKeys = [ ("M-b", sendMessage ToggleStruts )
         , ("M-r", spawn "gmrun" )
         , ("M-c", spawn "chromium" )
         , ("M-v", spawn "gvim" )
         , ("M-a", spawn "urxvtc" )
         , ("M-s", spawn "skype" )
         , ("M-o", spawn "slock" )
         ]

main = do
    xmobarPipe <- spawnPipe "/usr/bin/xmobar ~/.xmobarrc"
    xmonad $ defaultConfig
        { terminal           = myTerminal
        , modMask            = myModMask
        , borderWidth        = myBorderWidth
        , normalBorderColor  = myNormalBorderColor
        , focusedBorderColor = myFocusedBorderColor
        , manageHook         = manageDocks <+> myManageHook <+> manageHook defaultConfig
        , layoutHook         = avoidStruts $ layoutHook defaultConfig
        , logHook            = myLogHook xmobarPipe
        , handleEventHook    = fullscreenEventHook
        }
        `additionalKeysP` myKeys
