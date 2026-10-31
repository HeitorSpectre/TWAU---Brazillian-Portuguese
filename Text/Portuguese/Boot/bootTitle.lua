require("DeveloperFeedHandler.lua")
require("StatChoicesHandler.lua")
require("CabooseHandler.lua")
require("SoundMusic.lua")
require("RichPresence.lua")
local kBackButtonInputMap = "backButtonBoot.imap"
local mbPopupShown = false

function PopupSwapInput(bUseCursor)
  if mbPopupShown then
    if bUseCursor then
      AgentHide("popup_navhelp_a", true)
      AgentHide("ui_menu_popup_navhelp_a", true)
    else
      AgentHide("popup_navhelp_a", false)
      AgentHide("ui_menu_popup_navhelp_a", false)
    end
  end
end

function ShowPopup(message)
  if message == "badlogin" then
    CreateEventLogEvent("Login Result", "false")
    AgentSetProperty("popup_header", "Text Dialog 2.0 Node Name", "popup_badlogin_header")
    AgentSetProperty("popup_message", "Text Dialog 2.0 Node Name", "popup_badlogin_message")
    AgentSetProperty("popup_button1", "Text Dialog 2.0 Node Name", "popup_button_signout")
    AgentSetProperty("popup_button1", "Button - Command", "SignOut()")
    AgentSetProperty("popup_button2", "Text Dialog 2.0 Node Name", "popup_button_exit")
    AgentSetProperty("popup_button2", "Button - Command", "EngineQuit()")
  elseif message == "dontown" then
    CreateEventLogEvent("Login Result", "false")
    CreateEventLogEvent("Does Not Own", "true")
    AgentSetProperty("popup_header", "Text Dialog 2.0 Node Name", "popup_dontown_header")
    AgentSetProperty("popup_message", "Text Dialog 2.0 Node Name", "popup_dontown_message")
    AgentSetProperty("popup_button1", "Text Dialog 2.0 Node Name", "popup_button_buy")
    AgentSetProperty("popup_button1", "Button - Command", "BuyGame()")
    AgentSetProperty("popup_button2", "Text Dialog 2.0 Node Name", "popup_button_signout")
    AgentSetProperty("popup_button2", "Button - Command", "SignOut()")
    AgentSetProperty("popup_button3", "Text Dialog 2.0 Node Name", "popup_button_exit")
    AgentSetProperty("popup_button3", "Button - Command", "EngineQuit()")
  else
    CreateEventLogEvent("Login Result", "false")
    AgentSetProperty("popup_header", "Text Dialog 2.0 Node Name", "popup_login_error_header")
    AgentSetProperty("popup_message", "Text Dialog 2.0 Node Name", "popup_login_error_message")
    AgentSetProperty("popup_button1", "Text Dialog 2.0 Node Name", "popup_login_error_button")
    AgentSetProperty("popup_button1", "Button - Command", "HidePopup()")
  end
  ChorePlayAndWait("ui_menu_popup_show.chore")
  InputMapperActivate("popupButton.imap")
  if message == "badlogin" then
    AgentHide("popup_button1", false)
    AgentHide("popup_button2", false)
    AgentHide("popup_button3", true)
  elseif message == "dontown" then
    AgentHide("popup_button1", false)
    AgentHide("popup_button2", false)
    AgentHide("popup_button3", false)
  else
    AgentHide("popup_button1", false)
    AgentHide("popup_button2", true)
    AgentHide("popup_button3", true)
  end
  mbPopupShown = true
  PopupSwapInput(Input_UseCursor())
end

function HidePopup()
  AgentHide("popup_button1", true)
  AgentHide("popup_button2", true)
  AgentHide("popup_button3", true)
  AgentHide("popup_navhelp_a", true)
  AgentHide("ui_menu_popup_navhelp_a", true)
  mbPopupShown = false
  InputMapperDeactivate("popupButton.imap")
  ChorePlayAndWait("ui_menu_popup_hide.chore")
  InputMapperActivate("pressStart.imap")
end

function BuyGame()
  CreateEventLogEvent("Platform Open URL", "true")
  PlatformOpenURL("http://www.telltalegames.com/")
  WaitForNextFrame()
  HidePopup()
end

function SignOut()
  UserManager_TTAuthentication_Reset()
  HidePopup()
end

Callback_OnSetInputMode:Add(PopupSwapInput)

function PopupButton_OnRollOn(event)
  Buttons_OnRollOn(event, AgentGetScene("popup_parent"))
end

function PopupButton_OnRollOff(event)
  Buttons_OnRollOff(event, AgentGetScene("popup_parent"))
end

function PopupButton_OnUp(event)
  Buttons_OnUp(event, AgentGetScene("popup_parent"))
end

function PopupButton_OnDown(event)
  Buttons_OnDown(event, AgentGetScene("popup_parent"))
end

function PopupButton_OnLeft(event)
  Buttons_OnLeft(event, AgentGetScene("popup_parent"))
end

function PopupButton_OnRight(event)
  Buttons_OnRight(event, AgentGetScene("popup_parent"))
end

function PopupButton_OnMouseLDown(event)
  Buttons_OnPress(event, AgentGetScene("popup_parent"))
end

function PopupButton_OnMouseLUp(event)
  Buttons_OnRelease(event, AgentGetScene("popup_parent"))
end

function PopupButton_OnLeftStick(event)
  Buttons_OnLeftStick(event, AgentGetScene("popup_parent"))
end

if rawget(_G, "IsSGFDemo") and IsSGFDemo() and not ResourceSetEnabled("Demo") then
  ResourceSetEnable("Demo")
end
if IsPlatformPS4() then
  local platformResourceSets = {"PS4"}
  for _, loc in ipairs(platformResourceSets) do
    if loc ~= "PS4" and ResourceSetEnabled(loc) then
      ResourceSetDisable(loc, true)
    end
  end
  if not ResourceSetEnabled("PS4") then
    ResourceSetEnable("PS4")
  end
end
if IsPlatformPS5() then
  local platformResourceSets = {"PS5"}
  for _, loc in ipairs(platformResourceSets) do
    if loc ~= "PS5" and ResourceSetEnabled(loc) then
      ResourceSetDisable(loc, true)
    end
  end
  if not ResourceSetEnabled("PS5") then
    ResourceSetEnable("PS5")
  end
end
if IsPlatformXboxOne() then
  local platformResourceSets = {"XB1"}
  for _, loc in ipairs(platformResourceSets) do
    if loc ~= "XB1" and ResourceSetEnabled(loc) then
      ResourceSetDisable(loc, true)
    end
  end
  if not ResourceSetEnabled("XB1") then
    ResourceSetEnable("XB1")
  end
end
if IsPlatformNX() then
  local platformResourceSets = {"NX"}
  for _, loc in ipairs(platformResourceSets) do
    if loc ~= "NX" and ResourceSetEnabled(loc) then
      ResourceSetDisable(loc, true)
    end
  end
  if not ResourceSetEnabled("NX") then
    ResourceSetEnable("NX")
  end
end
if IsPlatformWin10() then
  local platformResourceSets = {"Win10"}
  for _, loc in ipairs(platformResourceSets) do
    if loc ~= "Win10" and ResourceSetEnabled(loc) then
      ResourceSetDisable(loc, true)
    end
  end
  if not ResourceSetEnabled("Win10") then
    ResourceSetEnable("Win10")
  end
end
if IsRunningSteam() then
  RichPresence_SetPlatform("Steam")
elseif IsPlatformXboxOne() or IsPlatformWin10() then
  RichPresence_SetPlatform("XB1")
end
local OnSetInputMode = function(bUseCursor)
  CursorHide(not bUseCursor)
  ChorePlay("ui_menu_title_start_idle_refresh.chore")
end

function UserManager_AutomaticallyLogIn()
  return IsEngineWin10() or not IsEnginePS3() and (not rawget(_G, "IsEnginePS4") or not IsEnginePS4()) and (not rawget(_G, "IsEnginePS5") or not IsEnginePS5()) and not IsEngineXbox360() and (not rawget(_G, "IsEngineXBOne") or not IsEngineXBOne()) and not IsEngineVita() and (not IsEnginePC() or IsRunningSteam() or not not IsRunningEpic())
end

function PressStart()
  RenderDelay(1)
  InputMapperDeactivate("pressStart.imap")
  AgentHide("ui_menu_foreground_busy", false, true)
  AgentHide("ui_menu_title_startIcon", true)
  ChorePlay("ui_menu_title_update_show.chore")
  local bTryLogin = true
  if bTryLogin then
    local success, err = UserManager_LogIn()
    if not success and IsPlatformTTG() and not IsToolBuild() then
      if not err then
        ChorePlayAndWait("ui_menu_title_update_hide.chore")
        AgentSetProperty("text_start", "Non-Proportional Text Scale", Vector(1, 1, 1))
        AgentSetProperty("text_start", "Text Alpha Multiply", 1)
        AgentHide("text_start", false)
        ShowPopup("badlogin")
      end
      return
    end
  end
  local kUnknown = 0
  local bIsLocalTokenValid = false
  if rawget(_G, "TTStats_HasAuthToken") then
    bIsLocalTokenValid = TTStats_HasAuthToken()
  end
  PropertySet("user.prop", "Upload Result", kUnknown)
  PropertySet("user.prop", "TT User", bIsLocalTokenValid)
  Callback_OnSetInputMode:Remove(OnSetInputMode)
  CursorHide(true)
  WaitForNextFrame()
  if bTryLogin and PlatformIsConnectedToLicenseServer() then
    local needUpload = false
    if rawget(_G, "SessionLogUploadSetEnabled") then
      SessionLogUploadSetEnabled(true)
      if rawget(_G, "SessionLogProcess") then
        needUpload = SessionLogProcess(true)
      end
      if rawget(_G, "EventLogGetActiveSessionLogName") then
        local sessionLog = EventLogGetActiveSessionLogName()
        if EventLogActive(sessionLog) then
          local tags = {
            "Age Restricted",
            "Demo",
            "Platform Open URL",
            "Dev Feed Shown",
            "Stats Shown",
            "Menu Page Shown",
            "Purchase Episode Attempt",
            "Purchase Season Attempt",
            "Purchase Demo Attempt",
            "Purchase Succeed",
            "Download Episode Attempt",
            "Download Succeed",
            "Uninstall Attempt",
            "Branch Attempt",
            "Rewind Attempt",
            "Play Episode",
            "Login Result",
            "Does Not Own"
          }
          EventLogAddTags(sessionLog, tags, tags)
          local result = PlatformIsAgeRestricted() and "true" or "false"
          CreateEventLogEvent("Age Restricted", result)
          result = IsRegistered() and "true" or "false"
          CreateEventLogEvent("Demo", result)
        end
      end
    end
    if ResourceExists("bundle:global.bundle!fablespedia.prop") then
      UploadCachedObjectToServer("bundle:global.bundle!fablespedia.prop", "fablespedia", true)
      needUpload = true
    end
    if ResourceExists("bundle:global.bundle!achievement_status.prop") then
      UploadCachedObjectToServer("bundle:global.bundle!achievement_status.prop", "achievements", true)
      needUpload = true
    end
    if ResourceExists("prefs.prop") then
      UploadCachedObjectToServer("prefs.prop", "preferences", true)
      needUpload = true
    end
    local estores = ResourceLocationGetNames("<User>", "_saveslot*.estore")
    if estores and #estores then
      for i, file in ipairs(estores) do
        UploadCachedObjectToServer(file, "saveslot_choices", true)
        needUpload = true
      end
    end
    if needUpload then
      UploadPendingObjectsToServer()
    end
  end
  AgentHide("ui_menu_foreground_busy", true, true)
  ChorePlayAndWait("ui_menu_title_update_hide.chore")
  if not IsToolBuild() then
    local bReset = GetNeedResetEngine()
    bReset = bReset or PatchManager_NeedToReset and PatchManager_NeedToReset()
    bReset = bReset or LocalContentManager_NeedToReset and LocalContentManager_NeedToReset()
    if bReset then
      ResetEngine()
    end
  end
  ChorePlayAndWait("ui_menu_title_hide.chore")
  SceneHide("titlescreen.scene", true)
  SubProject_Switch("Menu", "Menu_Main.lua")
  if IsPlatformAndroid() then
    InputMapperDeactivate(kBackButtonInputMap)
  end
end

function Startup()
  if LangGetCurLanguage() == "french" then
    AgentSetPosX("ui_menu_title_startIcon", 0.275)
  elseif LangGetCurLanguage() == "spanish" then
    AgentSetPosX("ui_menu_title_startIcon", 0.225)
  elseif LangGetCurLanguage() == "german" then
    AgentSetPosX("ui_menu_title_startIcon", 0.21)
  elseif LangGetCurLanguage() == "italian" then
    AgentSetPosX("ui_menu_title_startIcon", 0.225)
  end
  CursorHide(true)
  UI_SetCursor(true)
  RichPresence_Set("richPresence_mainMenu", false)
  SceneAdd("ui_menu_foreground.scene")
  SceneAdd("ui_menu_background_pause.scene")
  SceneAdd("ui_menu_popup.scene")
  WaitForNextFrame()
  AgentHide("popup_parent", true, true)
  local userFiles = ResourceLocationGetSymbols("<User>", "*.bundle")
  if userFiles and 0 < #userFiles then
    for i, v in ipairs(userFiles) do
      PreloadAsync(v)
    end
  end
  userFiles = ResourceLocationGetSymbols("<User>", "*.estore")
  if userFiles and 0 < #userFiles then
    for i, v in ipairs(userFiles) do
      PreloadAsync(v)
    end
  end
  GameMode()
  local prefs = GetPreferences()
  local dimensions = prefs.Windowed and prefs["Window Size"] or prefs["Fullscreen Size"]
  RenderSetAspectRatio(1.7777778)
  WaitForNextFrame()
  WaitForNextFrame()
  local aspectRatio = RenderGetAspectRatio()
  if GetResetCode() == 2 then
    UserManager_LogIn()
    SubProject_Switch("Menu", "Menu_Main.lua")
    return
  end
  RenderDelay(1)
  SceneAdd("ui_menu_legal.scene")
  WaitForNextFrame()
  AgentSetProperty("logic_music", "Music - File", "mus_loop_MainMenu_lite.wav")
  local scene = SceneFind("ui_menu_legal.scene")
  local textLegal = AgentFindInScene("legal text", scene)
  if LangGetCurLanguage() == "french" then
    local legalNotice = "© 2013-2026 LCG Entertainment, Inc. ©Bill Willingham et DC. Tous droits réservés. Telltale, Telltale Games et le logo Telltale sont des marques commerciales et/ou des marques déposées de LCG Entertainment, Inc.  Le logo DC/Vertigo ™ & © DC. Toutes les autres marques commerciales appartiennent à leurs propriétaires respectifs."
    AgentSetProperty(textLegal, "Text Width", "45")
    AgentSetProperty(textLegal, "Text Scale", 0.18)
    AgentSetProperty(textLegal, "Text Font", "ITC_kabel_book_message_120.font")
    AgentSetProperty(textLegal, "Text String", legalNotice)
  elseif LangGetCurLanguage() == "spanish" then
    local legalNotice = "© 2013-2026 LCG Entertainment, Inc. ©Bill Willingham y DC. Todos los derechos reservados. Telltale, Telltale Games, y el logo de Telltale son marcas y/o marcas registradas de LCG Entertainment, Inc. El logo de DC/Vertigo ™ y © DC. Todas las demás marcas son propiedad de sus respectivos dueños."
    AgentSetProperty(textLegal, "Text Width", "45")
    AgentSetProperty(textLegal, "Text Scale", 0.18)
    AgentSetProperty(textLegal, "Text Font", "ITC_kabel_book_message_120.font")
    AgentSetProperty(textLegal, "Text String", legalNotice)
  elseif LangGetCurLanguage() == "german" then
    local legalNotice = "© 2013-2026 LCG Entertainment, Inc. ©Bill Willingham and DC. All rights reserved. Telltale, Telltale Games, and the Telltale logo are trademarks and/or registered trademarks of LCG Entertainment, Inc.  The DC/Vertigo logo ™ & © DC. All other trademarks are the property of their respective owners."
    AgentSetProperty(textLegal, "Text Width", "45")
    AgentSetProperty(textLegal, "Text Scale", 0.18)
    AgentSetProperty(textLegal, "Text Font", "ITC_kabel_book_message_120.font")
    AgentSetProperty(textLegal, "Text String", legalNotice)
  elseif LangGetCurLanguage() == "italian" then
    local legalNotice = "© 2013-2026 LCG Entertainment, Inc. ©Bill Willingham e DC. Tutti i diritti riservati. Telltale, Telltale Games e il logo Telltale sono marchi di fabbrica e/o marchi registrati di LCG Entertainment, Inc. Il logo DC/Vertigo ™ & © DC. Tutti gli altri marchi sono di proprietà dei rispettivi titolari."
    AgentSetProperty(textLegal, "Text Width", "45")
    AgentSetProperty(textLegal, "Text Scale", 0.18)
    AgentSetProperty(textLegal, "Text Font", "ITC_kabel_book_message_120.font")
    AgentSetProperty(textLegal, "Text String", legalNotice)
  else
    local legalNotice = "© 2013-2026 LCG Entertainment, Inc. ©Bill Willingham e DC. Todos os direitos reservados. Telltale, Telltale Games e o logotipo da Telltale são marcas comerciais e/ou marcas registradas da LCG Entertainment, Inc. O logotipo DC/Vertigo ™ & © DC. Todas as outras marcas comerciais pertencem aos seus respectivos proprietários.\nTradução pela GameLab Traduções - HeitorSpectre, Niccbilac, Carlos Emmanuel e OAleex"
    AgentSetProperty(textLegal, "Text Width", "45")
    AgentSetProperty(textLegal, "Text Scale", 0.18)
    AgentSetProperty(textLegal, "Text Font", "ITC_kabel_book_message_120.font")
    AgentSetProperty(textLegal, "Text String", legalNotice)
  end
  print("ASPECT RATIO: " .. tostring(aspectRatio))
  ChorePlayAndWait("ui_menu_legal_widescreen.chore")
  RenderDelay(2)
  SceneRemove("ui_menu_legal.scene")
  WaitForNextFrame()
  WaitForNextFrame()
  ChorePlayAndWait("ui_menu_title_show_widescreen.chore")
  Callback_OnSetInputMode:Add(OnSetInputMode)
  OnSetInputMode(Input_UseCursor())
  InputMapperActivate("pressStart.imap")
end

function Boot_Exit()
  EngineQuit()
end

SceneOpen("ui_menu_title.scene", "Startup")
