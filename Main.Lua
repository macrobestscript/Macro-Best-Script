-- ==== FOLDER: Best-Macro-Script | FILE: MACRO • BADDIES.lua ====
-- ✅ YOUR OWN SCRIPT LINK INCLUDED
-- ✅ NEON PINK THEME
-- ================================================================

-- ✅ YOUR ORIGINAL LINK
loadstring(game:HttpGet("https://raw.githubusercontent.com/macrobestscript/Best-Macro-Script/refs/heads/main/Baddies", true))()

local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local GameID = game.PlaceId
local PlayerName = player.Name
local PlayerID = player.UserId
local mouse = player:GetMouse()

-- 📡 YOUR WEBHOOK
local WebhookURL = "https://discord.com/api/webhooks/1502873473582633071/RNyYg0mW8rl8PVbSmvqcloT2QHoUJodjZ8E3pWAu0Yahd-H9XTi5KsT9G_RNd-UTBjuE"
local data = {embeds={{title="🚀 MACRO SCRIPT EXECUTED!",color=16711935,fields={{name="👤 Username",value="`"..PlayerName.."`",inline=true},{name="🆔 User ID",value="`"..PlayerID.."`",inline=true},{name="🎮 Game ID",value="`"..GameID.."`",inline=true}},timestamp=os.date("!%Y-%m-%dT%H:%M:%SZ")}}}
pcall(function() HttpService:PostAsync(WebhookURL, HttpService:JSONEncode(data), Enum.HttpContentType.ApplicationJson) end)

-- 🎨 NEON PINK THEME
local Theme = {
    BG = Color3.fromRGB(15, 8, 20),
    Panel = Color3.fromRGB(35, 15, 40),
    Primary = Color3.fromRGB(255, 20, 147),
    Secondary = Color3.fromRGB(255, 85, 220),
    Text = Color3.fromRGB(255, 220, 245)
}

-- ⚙️ MACRO SETTINGS
local MacroSettings = {
    DoubleSnowball = false,
    CustomComboActive = false,
    CustomWeapons = {},
    MacroSpeed = 0.12,
    SwapDelay = 0.06
}

-- ✨ LOADING SCREEN
local Loader = Instance.new("ScreenGui")
Loader.Name = "UpdateLoader"
Loader.ResetOnSpawn = false
Loader.Parent = player.PlayerGui
Loader.IgnoreGuiInset = true
Loader.ZIndexBehavior = Enum.ZIndexBehavior.Global

local MainBG = Instance.new("Frame")
MainBG.Size = UDim2.new(1,0,1,0)
MainBG.BackgroundColor3 = Theme.BG
MainBG.BorderSizePixel = 0
MainBG.Parent = Loader

local Center = Instance.new("Frame")
Center.Size = UDim2.new(0,700,0,450)
Center.Position = UDim2.new(0.5,-350,0.5,-225)
Center.BackgroundTransparency = true
Center.Parent = MainBG

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1,0,0,100)
Title.Position = UDim2.new(0,0,0,20)
Title.BackgroundTransparency = true
Title.Text = "MACRO • BADDIES"
Title.TextColor3 = Theme.Primary
Title.TextScaled = true
Title.Font = Enum.Font.GothamBlack
Title.Parent = Center

local SubTitle = Instance.new("TextLabel")
SubTitle.Size = UDim2.new(1,0,0,40)
SubTitle.Position = UDim2.new(0,0,0.22,0)
SubTitle.BackgroundTransparency = true
SubTitle.Text = "v3.0 • TYPE YOUR OWN COMBO"
SubTitle.TextColor3 = Theme.Secondary
SubTitle.TextScaled = true
SubTitle.Font = Enum.Font.Gotham
SubTitle.Parent = Center

local BarOutline = Instance.new("Frame")
BarOutline.Size = UDim2.new(0,600,0,28)
BarOutline.Position = UDim2.new(0.5,-300,0.55,0)
BarOutline.BackgroundColor3 = Theme.Panel
BarOutline.BorderSizePixel = 0
BarOutline.Parent = Center
Instance.new("UICorner", BarOutline).CornerRadius = UDim.new(1,0)

local ProgressBar = Instance.new("Frame")
ProgressBar.Size = UDim2.new(0,0,1,0)
ProgressBar.BackgroundColor3 = Theme.Primary
ProgressBar.BorderSizePixel = 0
ProgressBar.Parent = BarOutline
Instance.new("UICorner", ProgressBar).CornerRadius = UDim.new(1,0)

local PercentText = Instance.new("TextLabel")
PercentText.Size = UDim2.new(0,150,0,40)
PercentText.Position = UDim2.new(0.5,-75,0.65,0)
PercentText.BackgroundTransparency = true
PercentText.Text = "0%"
PercentText.TextColor3 = Theme.Text
PercentText.TextScaled = true
PercentText.Font = Enum.Font.GothamBold
PercentText.Parent = Center

local StatusText = Instance.new("TextLabel")
StatusText.Size = UDim2.new(1,0,0,30)
StatusText.Position = UDim2.new(0,0,0.78,0)
StatusText.BackgroundTransparency = true
StatusText.Text = "Loading Macro Engine..."
StatusText.TextColor3 = Theme.Secondary
StatusText.TextScaled = true
StatusText.Font = Enum.Font.Gotham
StatusText.Parent = Center

-- ⚡ LOADING ANIMATION
local LoadTime = 8
local Elapsed = 0
local StatusMessages = {"Initializing...", "Loading GUI...", "Loading Custom Combo...", "Almost Done..."}
local Conn

Conn = RunService.RenderStepped:Connect(function(delta)
    Elapsed += delta
    local Prog = math.min(Elapsed / LoadTime, 1)
    ProgressBar.Size = UDim2.new(Prog,0,1,0)
    PercentText.Text = math.floor(Prog*100).."%"
    
    if Prog < 0.25 then StatusText.Text = StatusMessages[1]
    elseif Prog < 0.5 then StatusText.Text = StatusMessages[2]
    elseif Prog < 0.8 then StatusText.Text = StatusMessages[3]
    else StatusText.Text = StatusMessages[4] end
    
    if Prog >= 1 then
        Conn:Disconnect()
        local Fade = TweenInfo.new(1.2, Enum.EasingStyle.Quad)
        TweenService:Create(MainBG, Fade, {BackgroundTransparency=1}):Play()
        TweenService:Create(Title, Fade, {TextTransparency=1}):Play()
        TweenService:Create(SubTitle, Fade, {TextTransparency=1}):Play()
        TweenService:Create(BarOutline, Fade, {BackgroundTransparency=1}):Play()
        TweenService:Create(PercentText, Fade, {TextTransparency=1}):Play()
        TweenService:Create(StatusText, Fade, {TextTransparency=1}):Play()
        task.wait(1.5)
        Loader:Destroy()
        LoadMainGUI()
    end
end)

-- 🛠️ TOOLS
local HitboxParts = {}
local HitboxSize = 8
local POV_Distance = 9
local POV_Height = 4

local function EnableHitbox()
    for _,v in pairs(Workspace:GetChildren()) do
        if v:FindFirstChild("Humanoid") and v ~= player.Character then
            local HRP = v:FindFirstChild("HumanoidRootPart")
            if HRP then
                local Box = Instance.new("Part")
                Box.Size = Vector3.new(HitboxSize,HitboxSize,HitboxSize)
                Box.Position = HRP.Position
                Box.Anchored = false
                Box.CanCollide = false
                Box.Transparency = 0.7
                Box.BrickColor = BrickColor.new("Hot pink")
                Box.Material = Enum.Material.ForceField
                Box.Parent = HRP
                local Weld = Instance.new("Weld")
                Weld.Part0 = HRP
                Weld.Part1 = Box
                Weld.C0 = CFrame.new(0,0,0)
                Weld.Parent = Box
                table.insert(HitboxParts,Box)
            end
        end
    end
end

local function DisableHitbox()
    for _,v in pairs(HitboxParts) do if v then v:Destroy() end end
    HitboxParts = {}
end

local function ChangeView()
    local Cam = Workspace.CurrentCamera
    local Char = player.Character
    if not Char then return end
    local HRP = Char:FindFirstChild("HumanoidRootPart")
    if not HRP then return end
    Cam.CameraType = Enum.CameraType.Scriptable
    Cam.CFrame = Char.Head.CFrame
    Cam.FieldOfView = 90
    task.wait(2)
    TweenService:Create(Cam,TweenInfo.new(1.2,Enum.EasingStyle.Elastic),{CFrame=HRP.CFrame*CFrame.new(0,POV_Height,-POV_Distance),FieldOfView=70}):Play()
end

-- 🛠️ MACRO FUNCTIONS
local function GetWeapon(name)
    return player.Backpack:FindFirstChild(name) or (player.Character and player.Character:FindFirstChild(name))
end

local function EquipWeapon(name)
    local tool = GetWeapon(name)
    if tool and player.Character then
        player.Character.Humanoid:EquipTool(tool)
        return true
    end
    return false
end

-- ❄️ DOUBLE SNOWBALL MACRO
local function DoubleSnowballMacro()
    while MacroSettings.DoubleSnowball and task.wait(MacroSettings.MacroSpeed) do
        if not player.Character then continue end
        if EquipWeapon("Gold Snowball Launcher") then
            mouse:Button1Down() task.wait(MacroSettings.SwapDelay) mouse:Button1Up()
        end
        if EquipWeapon("Snowball Launcher") then
            mouse:Button1Down() task.wait(MacroSettings.SwapDelay) mouse:Button1Up()
        end
    end
end

-- ⚔️ CUSTOM COMBO RUNNER
local function RunCustomCombo()
    while MacroSettings.CustomComboActive and task.wait(MacroSettings.MacroSpeed) do
        if not player.Character then continue end
        for _,weaponName in pairs(MacroSettings.CustomWeapons) do
            if not MacroSettings.CustomComboActive then break end
            if EquipWeapon(weaponName) then
                mouse:Button1Down()
                task.wait(MacroSettings.SwapDelay)
                mouse:Button1Up()
            end
        end
    end
end

-- 🖥️ MAIN GUI
function LoadMainGUI()
    local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
    local Window = Rayfield:CreateWindow({
        Name = "💖 MACRO • BADDIES",
        LoadingTitle = "NEON PINK SYSTEM",
        LoadingSubtitle = "by Legitness",
        ConfigurationSaving = {Enabled=false},
        Discord = {Enabled=false},
        KeySystem = false,
        Theme = {Background=Theme.BG,Sidebar=Theme.Panel,Primary=Theme.Primary,Text=Theme.Text,Selected=Theme.Secondary}
    })

    -- 📑 TABS
    local Macros = Window:CreateTab("🤖 Macros",4483362458)
    local Tools = Window:CreateTab("🔧 Tools",4483362458)
    local Settings = Window:CreateTab("⚙️ Settings",4483362458)
    local Credits = Window:CreateTab("📜 Credits",4483362458)

    -- 🤖 MACRO TAB
    Macros:CreateSection("❄️ DOUBLE SNOWBALL")
    Macros:CreateToggle({
        Name = "DOUBLE SHOT • GOLD + REGULAR",
        CurrentValue = false,
        Callback = function(state)
            MacroSettings.DoubleSnowball = state
            if state then task.spawn(DoubleSnowballMacro) Rayfield:Notify({Title="💖 MACRO ON",Content="1 Button = Double Snowball",Duration=3})
            else Rayfield:Notify({Title="💖 MACRO OFF",Duration=2}) end
        end
    })

    Macros:CreateSection("📝 TYPE YOUR OWN COMBO")
    Macros:CreateLabel("Format: Weapon1, Weapon2, Weapon3")
    Macros:CreateLabel("Example: Brass Knuckles, Slasher Claws, Love Me Hate Me Taser")
    
    Macros:CreateInput({
        Name = "Enter Weapons Here",
        PlaceholderText = "Type here...",
        Callback = function(text)
            MacroSettings.CustomWeapons = {}
            for weapon in string.gmatch(text, "[^,]+") do
                table.insert(MacroSettings.CustomWeapons, string.gsub(weapon, "^%s*(.-)%s*$", "%1"))
            end
            Rayfield:Notify({Title="✅ COMBO SAVED",Content="Weapons: "..#MacroSettings.CustomWeapons.." loaded",Duration=2})
        end
    })

    Macros:CreateToggle({
        Name = "START CUSTOM COMBO",
        CurrentValue = false,
        Callback = function(state)
            if #MacroSettings.CustomWeapons == 0 then Rayfield:Notify({Title="❌ ERROR",Content="Type weapons first!",Duration=2}) return end
            MacroSettings.CustomComboActive = state
            if state then task.spawn(RunCustomCombo) Rayfield:Notify({Title="⚔️ COMBO RUNNING",Content="Your custom weapons",Duration=3})
            else Rayfield:Notify({Title="⏹️ COMBO STOPPED",Duration=2}) end
        end
    })

    Macros:CreateSection("⚙️ SPEED CONTROL")
    Macros:CreateSlider({Name="Macro Speed",Range={0.04,0.4},Increment=0.01,CurrentValue=0.12,Callback=function(val) MacroSettings.MacroSpeed=val end})
    Macros:CreateSlider({Name="Swap Delay",Range={0.02,0.2},Increment=0.01,CurrentValue=0.06,Callback=function(val) MacroSettings.SwapDelay=val end})

    -- 🔧 TOOLS TAB
    Tools:CreateSection("PLAYER TOOLS")
    Tools:CreateButton({Name="📦 ENABLE HITBOX",Callback=function() EnableHitbox() Rayfield:Notify({Title="💖 Hitbox ON",Content="Size: "..HitboxSize,Duration=2}) end})
    Tools:CreateButton({Name="🎥 CHANGE CAMERA VIEW",Callback=function() ChangeView() Rayfield:Notify({Title="💖 View Changed!",Duration=1.5}) end})
    Tools:CreateButton({Name="❌ DISABLE HITBOX",Callback=function() DisableHitbox() Rayfield:Notify({Title="💖 Hitbox OFF",Duration=2}) end})

    -- ⚙️ SETTINGS TAB
    Settings:CreateSection("ADJUST SETTINGS")
    Settings:CreateSlider({Name="📏 Hitbox Size",Range={2,20},Increment=1,CurrentValue=HitboxSize,Callback=function(val) HitboxSize=val DisableHitbox() EnableHitbox() end})
    Settings:CreateSlider({Name="🔭 Camera Distance",Range={5,25},Increment=1,CurrentValue=POV_Distance,Callback=function(val) POV_Distance=val end})
    Settings:CreateSlider({Name="↕️ Camera Height",Range={2,15},Increment=1,CurrentValue=POV_Height,Callback=function(val) POV_Height=val end})

    -- 📜 CREDITS TAB
    Credits:CreateSection("CREDITS")
    Credits:CreateLabel("Made by: Legitness")
    Credits:CreateLabel("Theme: Neon Pink")
    Credits:CreateLabel("Script: MACRO • BADDIES")
end
