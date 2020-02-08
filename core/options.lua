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
              get = "GetArtFrame",
              set = "UpdateArtFrame",
              descStyle = "inline",
              width = "full",
              order = 0,
            },
          }
        }

      },
  }

  local defaults = {
    profile =  {
      statusartframe = true,
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
  end

  function LortiUI:UpdateArtFrame()
    if (self.db.profile.statusartframe == nil) then return end
    local status = nil

    if (self.db.profile.statusartframe) then
      MainMenuBarArtFrame.LeftEndCap:Hide()
      MainMenuBarArtFrame.RightEndCap:Hide()
      status = false
    else
      MainMenuBarArtFrame.LeftEndCap:Show()
      MainMenuBarArtFrame.RightEndCap:Show()
      status = true
    end

    self.db.profile.statusartframe = status
  end

  function LortiUI:GetArtFrame(info)
    return self.db.profile.statusartframe
  end