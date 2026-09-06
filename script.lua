--// KIRILL_PANEL NO KEY V1.5
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")
local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

local AutoTrain = false
local AutoWeight = false
local AutoRebirth = false
local AutoKing = false
local AntiAFK = false
local AutoBoss = false
local AutoDurability = false
local AutoPunch = false
local AutoKingRock = false
local LastPosition = nil

local DodgeY = 28
local DodgeCount = 0
local MaxDodges = 8

if PlayerGui:FindFirstChild("KIRILL_PANEL_NO_KEY") then
    PlayerGui:FindFirstChild("KIRILL_PANEL_NO_KEY"):Destroy()
end

local Gui = Instance.new("ScreenGui")
Gui.Name = "KIRILL_PANEL_NO_KEY"
Gui.ResetOnSpawn = false
Gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Gui.Parent = PlayerGui

local Open = Instance.new("TextButton")
Open.Size = UDim2.new(0,45,0,45)
Open.Position = UDim2.new(1,-55,0,10)
Open.BackgroundColor3 = Color3.fromRGB(30,30,30)
Open.TextColor3 = Color3.new(1,1,1)
Open.Text = "⚡"
Open.TextSize = 22
Open.Font = Enum.Font.GothamBlack
Open.BorderSizePixel = 0
Open.Parent = Gui
Instance.new("UICorner", Open).CornerRadius = UDim.new(1,0)

local Panel = Instance.new("Frame")
Panel.Size = UDim2.new(0,230,0,280)
Panel.Position = UDim2.new(0.5,-115,0.5,-140)
Panel.BackgroundColor3 = Color3.fromRGB(25,25,25)
Panel.BorderSizePixel = 0
Panel.Visible = false
Panel.Parent = Gui
Instance.new("UICorner", Panel).CornerRadius = UDim.new(0,10)

local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1,0,0,35)
TitleBar.BackgroundColor3 = Color3.fromRGB(35,35,35)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = Panel

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1,-40,1,0)
Title.Position = UDim2.new(0,10,0,0)
Title.BackgroundTransparency = 1
Title.Text = "KIRILL_PANEL NO KEY V1.5"
Title.TextColor3 = Color3.new(1,1,1)
Title.TextSize = 10
Title.Font = Enum.Font.GothamBlack
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TitleBar

local Close = Instance.new("TextButton")
Close.Size = UDim2.new(0,25,0,25)
Close.Position = UDim2.new(1,-32,0,5)
Close.BackgroundColor3 = Color3.fromRGB(170,50,50)
Close.Text = "×"
Close.TextColor3 = Color3.new(1,1,1)
Close.TextSize = 16
Close.Font = Enum.Font.GothamBlack
Close.BorderSizePixel = 0
Close.Parent = TitleBar
Instance.new("UICorner", Close).CornerRadius = UDim.new(0,5)

local UserInputService = game:GetService("UserInputService")
local Dragging = false
local DragStart = nil
local StartPos = nil

TitleBar.InputBegan:Connect(function(Input)
    if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
        Dragging = true
        DragStart = Input.Position
        StartPos = Panel.Position
    end
end)

TitleBar.InputEnded:Connect(function(Input)
    if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
        Dragging = false
    end
end)

UserInputService.InputChanged:Connect(function(Input)
    if not Dragging then return end
    if Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch then
        local Delta = Input.Position - DragStart
        Panel.Position = UDim2.new(StartPos.X.Scale, StartPos.X.Offset + Delta.X, StartPos.Y.Scale, StartPos.Y.Offset + Delta.Y)
    end
end)

local Scroll = Instance.new("ScrollingFrame")
Scroll.Size = UDim2.new(1,-10,1,-40)
Scroll.Position = UDim2.new(0,5,0,40)
Scroll.BackgroundTransparency = 1
Scroll.BorderSizePixel = 0
Scroll.CanvasSize = UDim2.new(0,0,0,400)
Scroll.ScrollBarThickness = 4
Scroll.ScrollBarImageColor3 = Color3.fromRGB(80,80,80)
Scroll.ScrollingDirection = Enum.ScrollingDirection.Y
Scroll.Parent = Panel

local function CreateButton(Text, Y)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(1,-10,0,40)
    Btn.Position = UDim2.new(0,5,0,Y)
    Btn.BackgroundColor3 = Color3.fromRGB(150,50,50)
    Btn.TextColor3 = Color3.new(1,1,1)
    Btn.Text = Text
    Btn.TextSize = 12
    Btn.Font = Enum.Font.GothamBlack
    Btn.BorderSizePixel = 0
    Btn.Parent = Scroll
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0,6)
    return Btn
end

local TrainBtn = CreateButton("💪 Авто-Прокачка: ВЫКЛ", 2)
local WeightBtn = CreateButton("🏋️ Авто-Гантеля: ВЫКЛ", 46)
local RebirthBtn = CreateButton("🔄 Ребитх: ВЫКЛ", 90)
local KingBtn = CreateButton("👑 Тп-Кинг: ВЫКЛ", 134)
local AFKBtn = CreateButton("🛡️ Анти-Афк: ВЫКЛ", 178)
local BossBtn = CreateButton("👹 Авто-Боссы: ВЫКЛ [РАЗМЕР 12]", 222)
local DurBtn = CreateButton("🥊 Авто-Дурабилити: ВЫКЛ", 266)
local AutoPunchBtn = CreateButton("⚡ Авто-Удары: ВЫКЛ", 310)
local KingRockBtn = CreateButton("🗿 Кинг-Камень: ВЫКЛ", 354)

local function SetBtn(Btn, Text, On)
    if On then
        Btn.Text = Text .. ": ВКЛ"
        Btn.BackgroundColor3 = Color3.fromRGB(50,160,70)
    else
        Btn.Text = Text .. ": ВЫКЛ"
        Btn.BackgroundColor3 = Color3.fromRGB(150,50,50)
    end
end

local function SetBossBtn(Btn, Text, On)
    if On then
        Btn.Text = Text .. ": ВКЛ [РАЗМЕР 12]"
        Btn.BackgroundColor3 = Color3.fromRGB(50,160,70)
    else
        Btn.Text = Text .. ": ВЫКЛ [РАЗМЕР 12]"
        Btn.BackgroundColor3 = Color3.fromRGB(150,50,50)
    end
end

Open.Activated:Connect(function()
    Panel.Visible = true
    Open.Visible = false
end)

Close.Activated:Connect(function()
    Panel.Visible = false
    Open.Visible = true
end)

-- ФУНКЦИИ
local function GetPunch()
    local Character = Player.Character
    if Character then
        local Punch = Character:FindFirstChild("Punch")
        if Punch then return Punch end
    end
    local Backpack = Player:FindFirstChild("Backpack")
    if Backpack then
        return Backpack:FindFirstChild("Punch")
    end
    return nil
end

local function ClickClaimReward()
    for _, gui in ipairs(PlayerGui:GetChildren()) do
        if gui:IsA("ScreenGui") then
            for _, child in ipairs(gui:GetDescendants()) do
                if child:IsA("TextButton") and child.Visible then
                    local t = string.lower(child.Text)
                    if string.find(t, "claim") or string.find(t, "reward") then
                        pcall(function()
                            child:Activate()
                        end)
                        return true
                    end
                end
            end
        end
    end
    return false
end

local function DoPunch()
    local Character = Player.Character
    if not Character then return end
    local Humanoid = Character:FindFirstChildOfClass("Humanoid")
    local Punch = GetPunch()
    if Punch and Humanoid then
        if Punch.Parent ~= Character then
            Humanoid:EquipTool(Punch)
        end
        Punch:Activate()
        local MuscleEvent = Player:FindFirstChild("muscleEvent")
        if MuscleEvent then
            MuscleEvent:FireServer("punch", "leftHand")
            MuscleEvent:FireServer("punch", "rightHand")
        end
    end
end

-- АВТО-ПРОКАЧКА
TrainBtn.Activated:Connect(function()
    AutoTrain = not AutoTrain
    SetBtn(TrainBtn, "💪 Авто-Прокачка", AutoTrain)
end)

spawn(function()
    while wait(0.1) do
        if AutoTrain then
            pcall(function()
                local MuscleEvent = Player:FindFirstChild("muscleEvent")
                if MuscleEvent then
                    MuscleEvent:FireServer("rep")
                end
            end)
        end
    end
end)

-- АВТО-ГАНТЕЛЯ
WeightBtn.Activated:Connect(function()
    AutoWeight = not AutoWeight
    SetBtn(WeightBtn, "🏋️ Авто-Гантеля", AutoWeight)
end)

spawn(function()
    while wait(0.2) do
        if AutoWeight then
            pcall(function()
                local Character = Player.Character
                if Character then
                    local Humanoid = Character:FindFirstChildOfClass("Humanoid")
                    local Backpack = Player:FindFirstChild("Backpack")
                    local Weight = nil
                    
                    if Backpack then
                        Weight = Backpack:FindFirstChild("Weight")
                    end
                    if not Weight then
                        Weight = Character:FindFirstChild("Weight")
                    end
                    
                    if Weight and Humanoid then
                        if Weight.Parent ~= Character then
                            Humanoid:EquipTool(Weight)
                            wait(0.2)
                        end
                        Weight:Activate()
                        local MuscleEvent = Player:FindFirstChild("muscleEvent")
                        if MuscleEvent then
                            MuscleEvent:FireServer("rep")
                        end
                    end
                end
            end)
        end
    end
end)

-- АВТО-РЕБИТХ
RebirthBtn.Activated:Connect(function()
    AutoRebirth = not AutoRebirth
    SetBtn(RebirthBtn, "🔄 Ребитх", AutoRebirth)
end)

spawn(function()
    while wait(0.001) do
        if AutoRebirth then
            pcall(function()
                local rEvents = ReplicatedStorage:FindFirstChild("rEvents")
                local Remote = rEvents and rEvents:FindFirstChild("rebirthRemote")
                if Remote then
                    Remote:InvokeServer("rebirthRequest")
                end
            end)
        end
    end
end)

-- АВТО-КИНГ
KingBtn.Activated:Connect(function()
    AutoKing = not AutoKing
    SetBtn(KingBtn, "👑 Тп-Кинг", AutoKing)
end)

spawn(function()
    while wait(0.001) do
        if AutoKing then
            pcall(function()
                local Character = Player.Character
                if Character then
                    local Root = Character:FindFirstChild("HumanoidRootPart")
                    if Root then
                        Root.CFrame = CFrame.new(-8744.821, 121.183, -5859.323)
                    end
                end
            end)
        end
    end
end)

-- АНТИ-АФК
AFKBtn.Activated:Connect(function()
    AntiAFK = not AntiAFK
    SetBtn(AFKBtn, "🛡️ Анти-Афк", AntiAFK)
end)

spawn(function()
    while wait(900) do
        if AntiAFK then
            pcall(function()
                VirtualUser:CaptureController()
                VirtualUser:ClickButton2(Vector2.new(0,0))
            end)
        end
    end
end)

-- АВТО-БОССЫ (телепорт каждые 0.1, с ноклипом и флаем)
local function CheckDamage()
    local Character = Player.Character
    if Character then
        local Humanoid = Character:FindFirstChildOfClass("Humanoid")
        if Humanoid then
            if Humanoid.Health < Humanoid.MaxHealth then
                return true
            end
        end
    end
    return false
end

BossBtn.Activated:Connect(function()
    AutoBoss = not AutoBoss
    SetBossBtn(BossBtn, "👹 Авто-Боссы", AutoBoss)
    
    if AutoBoss then
        local Character = Player.Character
        if Character then
            local Root = Character:FindFirstChild("HumanoidRootPart")
            if Root then
                LastPosition = Root.CFrame
            end
            -- Включаем ноклип и флай
            pcall(function()
                for _, part in ipairs(Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
                local Humanoid = Character:FindFirstChildOfClass("Humanoid")
                if Humanoid then
                    Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
                    Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
                    Humanoid:SetStateEnabled(Enum.HumanoidStateType.Physics, false)
                end
            end)
        end
        DodgeY = 28
        DodgeCount = 0
    else
        if LastPosition then
            local Character = Player.Character
            if Character then
                local Root = Character:FindFirstChild("HumanoidRootPart")
                if Root then
                    Root.CFrame = LastPosition
                end
                -- Выключаем ноклип и флай
                pcall(function()
                    for _, part in ipairs(Character:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.CanCollide = true
                        end
                    end
                    local Humanoid = Character:FindFirstChildOfClass("Humanoid")
                    if Humanoid then
                        Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, true)
                        Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, true)
                        Humanoid:SetStateEnabled(Enum.HumanoidStateType.Physics, true)
                    end
                end)
            end
            LastPosition = nil
        end
        DodgeY = 28
        DodgeCount = 0
    end
end)

spawn(function()
    while wait(0.1) do
        if AutoBoss then
            pcall(function()
                local Character = Player.Character
                if Character then
                    local Root = Character:FindFirstChild("HumanoidRootPart")
                    
                    if Root then
                        -- Ноклип + флай
                        for _, part in ipairs(Character:GetDescendants()) do
                            if part:IsA("BasePart") then
                                part.CanCollide = false
                            end
                        end
                        local Humanoid = Character:FindFirstChildOfClass("Humanoid")
                        if Humanoid then
                            Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
                            Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
                        end

                        if CheckDamage() and DodgeCount < MaxDodges then
                            DodgeCount = DodgeCount + 1
                            DodgeY = DodgeY - 3
                        end
                        
                        Root.CFrame = CFrame.new(7, DodgeY, -1299.706) * CFrame.Angles(0, math.pi, 0)
                        
                        if ClickClaimReward() then
                            DodgeY = 28
                            DodgeCount = 0
                        end
                        
                        DoPunch()
                    end
                end
            end)
        end
    end
end)

-- АВТО-ДУРАБИЛИТИ (лучший камень по дурабилити)
DurBtn.Activated:Connect(function()
    AutoDurability = not AutoDurability
    SetBtn(DurBtn, "🥊 Авто-Дурабилити", AutoDurability)
end)

spawn(function()
    while wait(0.12) do
        if AutoDurability then
            pcall(function()
                local Character = Player.Character
                if Character then
                    local Humanoid = Character:FindFirstChildOfClass("Humanoid")
                    local Punch = GetPunch()
                    
                    if Punch and Humanoid then
                        if Punch.Parent ~= Character then
                            Humanoid:EquipTool(Punch)
                            wait(0.1)
                        end
                        
                        local Root = Character:FindFirstChild("HumanoidRootPart")
                        local Durability = Player:FindFirstChild("Durability")
                        local MachinesFolder = workspace:FindFirstChild("machinesFolder")
                        
                        if Root and Durability and MachinesFolder then
                            local CurrentDurability = tonumber(Durability.Value) or 0
                            local BestRock = nil
                            local BestRequired = -1
                            
                            for _, Machine in ipairs(MachinesFolder:GetChildren()) do
                                local Rock = Machine:FindFirstChild("Rock")
                                if Rock and Rock:IsA("BasePart") then
                                    local Needed = Machine:FindFirstChild("neededDurability")
                                    local Required = nil
                                    if Needed then Required = tonumber(Needed.Value) end
                                    if not Required then
                                        Needed = Rock:FindFirstChild("neededDurability")
                                        if Needed then Required = tonumber(Needed.Value) end
                                    end
                                    
                                    if Required and Required <= CurrentDurability and Required > BestRequired then
                                        BestRequired = Required
                                        BestRock = Rock
                                    end
                                end
                            end
                            
                            if BestRock then
                                Root.CFrame = CFrame.new(BestRock.Position + Vector3.new(0, 3, 2))
                                
                                Punch:Activate()
                                
                                local MuscleEvent = Player:FindFirstChild("muscleEvent")
                                if MuscleEvent then
                                    MuscleEvent:FireServer("punch", "leftHand")
                                    wait(0.06)
                                    MuscleEvent:FireServer("punch", "rightHand")
                                end
                            end
                        end
                    end
                end
            end)
        end
    end
end)

-- АВТО-УДАРЫ
AutoPunchBtn.Activated:Connect(function()
    AutoPunch = not AutoPunch
    SetBtn(AutoPunchBtn, "⚡ Авто-Удары", AutoPunch)
end)

spawn(function()
    while wait(0.01) do
        if AutoPunch then
            pcall(function()
                DoPunch()
            end)
        end
    end
end)

-- АВТО-КИНГ-КАМЕНЬ
KingRockBtn.Activated:Connect(function()
    AutoKingRock = not AutoKingRock
    SetBtn(KingRockBtn, "🗿 Кинг-Камень", AutoKingRock)
end)

spawn(function()
    while wait(0.15) do
        if AutoKingRock then
            pcall(function()
                local Character = Player.Character
                if Character then
                    local Root = Character:FindFirstChild("HumanoidRootPart")
                    if Root then
                        Root.CFrame = CFrame.new(-8928.078, 13.199, -6004.433)
                        DoPunch()
                    end
                end
            end)
        end
    end
end)

print("KIRILL PANEL V1.5 LOADED")
