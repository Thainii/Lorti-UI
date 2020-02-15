  -----------------------------
  -- INIT
  -----------------------------

  --get the addon namespace
  local addon, ns = ...

  --generate a holder for the config data
  local cfg = CreateFrame("Frame")

  LortiUI = LibStub("AceAddon-3.0"):NewAddon("LortiUI", "AceConsole-3.0", "AceEvent-3.0")

  local options = {
      name = "LortiUI",
      handler = LortiUI,
      type = "group",
      args = {
        gActionbare = {
          type = "group",
          name = "Action Bar",
          inline = true,
          order = 0,
          args = {
            statusartframe = {
              type = "toggle",
              name = NORMAL_FONT_COLOR_CODE .. "Show Gryphons" .. FONT_COLOR_CODE_CLOSE,
              desc = "Show or Hide the Gryphons next to the Main Actionbar",
              get = "Getstatusartframe",
              set = "UpdateArtFrame",
              descStyle = "inline",
              width = "full",
              order = 0,
            },
            statushotkeytext = {
              type = "toggle",
              name = NORMAL_FONT_COLOR_CODE .. "Show Hotkey Text" .. FONT_COLOR_CODE_CLOSE,
              desc = "Show or Hide the Hotkey Text in Actionbars",
              get = "Getstatushotkeytext",
              set = "UpdateHotkeytext",
              descStyle = "inline",
              width = "full",
              order = 1,
            },
            statusmacrotext = {
              type = "toggle",
              name = NORMAL_FONT_COLOR_CODE .. "Show Macro Name" .. FONT_COLOR_CODE_CLOSE,
              desc = "Show or Hide the Macro Name in Actionbars",
              get = "Getstatusmarcotext",
              set = "UpdateMacrotext",
              descStyle = "inline",
              width = "full",
              order = 2,
            },
          }
        }

      },
  }

  local defaults = {
    profile =  {
      statusartframe = true,
      statushotkeytext = true,
      statusmacrotext = false,
    },
  }

  function LortiUI:OnInitialize()
      -- Called when the addon is loaded
      self.db = LibStub("AceDB-3.0"):New("LortiUIDB", defaults, true)

      LibStub("AceConfig-3.0"):RegisterOptionsTable("LortiUI", options)
      self.optionsFrame = LibStub("AceConfigDialog-3.0"):AddToBlizOptions("LortiUI", "LortiUI")

      self:UpdateInterface()
  end

  function LortiUI:OnEnable()
    self:UpdateInterface()
  end
  
  function LortiUI:OnDisable()
    self:UpdateInterface()
  end

  function LortiUI:UpdateInterface()
    self:UpdateArtFrame()
    self:UpdateHotkeytext()
    self:UpdateMacrotext()
  end

  function LortiUI:Getstatusartframe()
    return self.db.profile.statusartframe
  end 

  -- Gryphons
  function LortiUI:UpdateArtFrame()
    if (self.db.profile.statusartframe == nil) then return end
    local status = nil

    if self.db.profile.statusartframe == true then
      MainMenuBarLeftEndCap:Hide()
      MainMenuBarRightEndCap:Hide()
      status = false
    else
      MainMenuBarLeftEndCap:Show()
      MainMenuBarRightEndCap:Show()
      status = true
    end

    self.db.profile.statusartframe = status
  end

  -- Hotkey Text
  function LortiUI:Getstatushotkeytext()
    return self.db.profile.statushotkeytext
  end 

  function LortiUI:UpdateHotkeytext()
    if (self.db.profile.statushotkeytext == nil) then return end
    local _G = getfenv(0)
    local buttons = {
      "ActionButton",
      "MultiBarBottomLeftButton",
      "MultiBarBottomRightButton",
      "MultiBarLeftButton",
      "MultiBarRightButton",
      "PetActionButton"
    }

    if self.db.profile.statushotkeytext == true then
      for i = 1, getn(buttons) do
        for n = 1, 12 do
          local o = _G[buttons[i]..n.."HotKey"]
          if (o) then
            o:Hide()
          end
        end
      end
      self.db.profile.statushotkeytext = false
    else
      for i = 1, getn(buttons) do
        for n = 1, 12 do
          local o = _G[buttons[i]..n.."HotKey"]
          if (o) then
            o:Show()
          end
        end
      end
      self.db.profile.statushotkeytext = true
    end
  end

  -- Macro Text
  function LortiUI:Getstatusmarcotext()
    return self.db.profile.statusmacrotext
  end 

  function LortiUI:UpdateMacrotext()
    if (self.db.profile.statusmacrotext == nil) then return end
    local _G = getfenv(0)
    local buttons = {
      "ActionButton",
      "MultiBarBottomLeftButton",
      "MultiBarBottomRightButton",
      "MultiBarLeftButton",
      "MultiBarRightButton",
    }
    
    if self.db.profile.statusmacrotext == true then
      for i = 1, getn(buttons) do
        for n = 1, NUM_ACTIONBAR_BUTTONS do
          _G[buttons[i]..n.."Name"]:Hide()
        end
      end
      self.db.profile.statusmacrotext = false
    else
      for i = 1, getn(buttons) do
        for n = 1, NUM_ACTIONBAR_BUTTONS do
          _G[buttons[i]..n.."Name"]:Show()
        end
      end
      self.db.profile.statusmacrotext = true
    end
  end