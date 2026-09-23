--// KIRILL_PANEL NO KEY V1.55
--// БЕЗ АВТО-СУНДУКА
--// НОВАЯ ФУНКЦИЯ: АВТО-БОССЫ И ГАНТЕЛЯ

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

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
local AutoBossAndWeight = false

local RebirthTarget = 0
local RebirthDone = 0
local CurrentLanguage = "ru"

--//==================================================
--// ОБЫЧНЫЙ AUTO BOSS
--//==================================================

local BossX = 7
local BossNormalY = 28
local BossDamageY = 4
local BossZ = -1300

local BossSavedCFrame = nil
local BossSavedCollision = {}
local BossNoclipConnection = nil
local BossFlyConnection = nil
local BossY = BossNormalY
local LastBossHealth = nil

--//==================================================
--// AUTO БОССЫ И ГАНТЕЛЯ
--//==================================================

local BossWeightX = 7
local BossWeightY = 32
local BossWeightDamageY = 28
local BossWeightFinalY = 4
local BossWeightZ = -1300

local BossWeightSavedCFrame = nil
local BossWeightSavedCollision = {}

local BossWeightNoclipConnection = nil
local BossWeightFlyConnection = nil
local BossWeightHealthConnection = nil
local BossWeightLoopConnection = nil

local BossWeightStage = 0
local BossWeightResetTime = 0
local BossWeightLastHealth = nil

--//==================================================
--// TEXT
--//==================================================

local T = {
    ru = {
        title = "KIRILL_PANEL NO KEY V1.55",

        train = "💪 Авто-Прокачка",
        weight = "🏋️ Авто-Гантеля",
        rebirth = "🔄 Авто-Ребитхи",
        king = "👑 Тп-Кинг",
        afk = "🛡️ Анти-Афк",
        boss = "👹 Авто-Боссы",

        bossWeight = "👹 Авто-Боссы и Гантеля",

        durability = "🥊 Авто-Дурабилити",
        punch = "⚡ Авто-Удары",
        kingrock = "🗿 Кинг-Камень",

        off = "ВЫКЛ",
        on = "ВКЛ",

        bossSmall = "[ТОЛЬКО РАЗМЕР 12]",

        rebirthQuestion = "Сколько ты хочешь сделать ребитхов?",
        rebirthInfo = "Цифра 0 это бесконечно",
        ok = "OK"
    },

    en = {
        title = "KIRILL_PANEL NO KEY V1.55",

        train = "💪 Auto-Train",
        weight = "🏋️ Auto-Weight",
        rebirth = "🔄 Auto-Rebirth",
        king = "👑 TP-King",
        afk = "🛡️ Anti-AFK",
        boss = "👹 Auto-Boss",

        bossWeight = "👹 Auto-Boss & Weight",

        durability = "🥊 Auto-Durability",
        punch = "⚡ Auto-Punch",
        kingrock = "🗿 King-Rock",

        off = "OFF",
        on = "ON",

        bossSmall = "[SIZE 12 ONLY]",

        rebirthQuestion = "How many rebirths do you want?",
        rebirthInfo = "Number 0 means infinite",
        ok = "OK"
    }
}

--//==================================================
--// GUI
--//==================================================

local OldGui = PlayerGui:FindFirstChild("KIRILL_PANEL")

if OldGui then
    OldGui:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "KIRILL_PANEL"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = PlayerGui

--// OPEN BUTTON

local OpenButton = Instance.new("TextButton")
OpenButton.Name = "OpenButton"
OpenButton.Size = UDim2.new(0, 48, 0, 48)
OpenButton.Position = UDim2.new(1, -60, 0, 15)
OpenButton.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
OpenButton.TextColor3 = Color3.fromRGB(255, 255, 255)
OpenButton.Text = "💪"
OpenButton.TextSize = 25
OpenButton.BorderSizePixel = 0
OpenButton.Parent = ScreenGui

local OpenCorner = Instance.new("UICorner")
OpenCorner.CornerRadius = UDim.new(1, 0)
OpenCorner.Parent = OpenButton

--// MAIN FRAME

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 230, 0, 280)
MainFrame.Position = UDim2.new(0.5, -115, 0.5, -140)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 10)
MainCorner.Parent = MainFrame

--// TITLE

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 38)
Title.Position = UDim2.new(0, 0, 0, 0)
Title.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Text = T[CurrentLanguage].title
Title.TextSize = 14
Title.Font = Enum.Font.SourceSansBold
Title.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 10)
TitleCorner.Parent = Title

--// SCROLL

local Scroll = Instance.new("ScrollingFrame")
Scroll.Name = "Scroll"
Scroll.Size = UDim2.new(1, -10, 1, -45)
Scroll.Position = UDim2.new(0, 5, 0, 40)
Scroll.BackgroundTransparency = 1
Scroll.BorderSizePixel = 0
Scroll.ScrollBarThickness = 5
Scroll.CanvasSize = UDim2.new(0, 0, 0, 440)
Scroll.Parent = MainFrame

--// BUTTON CREATOR

local function CreateToggleButton(name, text, y)

    local Button = Instance.new("TextButton")

    Button.Name = name
    Button.Size = UDim2.new(1, -10, 0, 38)
    Button.Position = UDim2.new(0, 5, 0, y)

    Button.BackgroundColor3 = Color3.fromRGB(160, 55, 55)
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)

    Button.Text = text .. ": " .. T[CurrentLanguage].off

    Button.TextSize = 14
    Button.Font = Enum.Font.SourceSansBold
    Button.BorderSizePixel = 0

    Button.Parent = Scroll

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 7)
    Corner.Parent = Button

    return Button
end

local TrainButton = CreateToggleButton(
    "TrainButton",
    T[CurrentLanguage].train,
    2
)

local WeightButton = CreateToggleButton(
    "WeightButton",
    T[CurrentLanguage].weight,
    46
)

local RebirthButton = CreateToggleButton(
    "RebirthButton",
    T[CurrentLanguage].rebirth,
    90
)

local KingButton = CreateToggleButton(
    "KingButton",
    T[CurrentLanguage].king,
    134
)

local AFKButton = CreateToggleButton(
    "AFKButton",
    T[CurrentLanguage].afk,
    178
)

local BossButton = CreateToggleButton(
    "BossButton",
    T[CurrentLanguage].boss,
    222
)

local BossSmall = Instance.new("TextLabel")
BossSmall.Name = "BossSmall"
BossSmall.Size = UDim2.new(1, -10, 0, 18)
BossSmall.Position = UDim2.new(0, 5, 0, 223)
BossSmall.BackgroundTransparency = 1
BossSmall.TextColor3 = Color3.fromRGB(255, 220, 80)
BossSmall.Text = T[CurrentLanguage].bossSmall
BossSmall.TextSize = 10
BossSmall.Font = Enum.Font.SourceSansBold
BossSmall.Parent = Scroll

local DurabilityButton = CreateToggleButton(
    "DurabilityButton",
    T[CurrentLanguage].durability,
    266
)

local PunchButton = CreateToggleButton(
    "PunchButton",
    T[CurrentLanguage].punch,
    310
)

local KingRockButton = CreateToggleButton(
    "KingRockButton",
    T[CurrentLanguage].kingrock,
    354
)

local BossWeightButton = CreateToggleButton(
    "BossWeightButton",
    T[CurrentLanguage].bossWeight,
    398
)

--//==================================================
--// DRAG
--//==================================================

local dragging = false
local dragStart
local startPos

Title.InputBegan:Connect(function(input)

    if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then

        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)

    if not dragging then
        return
    end

    if input.UserInputType == Enum.UserInputType.MouseMovement
    or input.UserInputType == Enum.UserInputType.Touch then

        local delta = input.Position - dragStart

        MainFrame.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)

UserInputService.InputEnded:Connect(function(input)

    if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then

        dragging = false
    end
end)

OpenButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

--//==================================================
--// REMOTES
--//==================================================

local function GetMuscleEvent()

    local Event = Player:FindFirstChild("muscleEvent")

    if Event and Event:IsA("RemoteEvent") then
        return Event
    end

    local rEvents = ReplicatedStorage:FindFirstChild("rEvents")

    if rEvents then

        local Event2 = rEvents:FindFirstChild("muscleEvent")

        if Event2 and Event2:IsA("RemoteEvent") then
            return Event2
        end
    end

    return nil
end

local function GetRebirthRemote()

    local rEvents = ReplicatedStorage:FindFirstChild("rEvents")

    if not rEvents then
        return nil
    end

    return rEvents:FindFirstChild("rebirthRemote")
end

local function GetPunch()

    local Character = Player.Character
    local Backpack = Player:FindFirstChild("Backpack")

    if Character then

        local Tool = Character:FindFirstChild("Punch")

        if Tool and Tool:IsA("Tool") then
            return Tool
        end
    end

    if Backpack then

        local Tool = Backpack:FindFirstChild("Punch")

        if Tool and Tool:IsA("Tool") then
            return Tool
        end
    end

    return nil
end

local function DoPunch()

    local Character = Player.Character

    if not Character then
        return
    end

    local Humanoid = Character:FindFirstChildOfClass("Humanoid")
    local Event = GetMuscleEvent()
    local Punch = GetPunch()

    if Punch and Humanoid and Punch.Parent ~= Character then

        pcall(function()
            Humanoid:EquipTool(Punch)
        end)

        task.wait(0.02)
    end

    if Event then

        pcall(function()
            Event:FireServer("punch", "rightHand")
        end)

        pcall(function()
            Event:FireServer("punch", "leftHand")
        end)
    end

    if Punch then

        pcall(function()
            Punch:Activate()
        end)
    end
end

--//==================================================
--// АВТО-ПРОКАЧКА
--//==================================================

TrainButton.MouseButton1Click:Connect(function()

    AutoTrain = not AutoTrain

    if AutoTrain then

        TrainButton.Text =
            T[CurrentLanguage].train .. ": " ..
            T[CurrentLanguage].on

        TrainButton.BackgroundColor3 =
            Color3.fromRGB(45, 170, 70)

        task.spawn(function()

            while AutoTrain do

                local Event = GetMuscleEvent()

                if Event then

                    pcall(function()
                        Event:FireServer("rep")
                    end)
                end

                task.wait(0.05)
            end
        end)

    else

        TrainButton.Text =
            T[CurrentLanguage].train .. ": " ..
            T[CurrentLanguage].off

        TrainButton.BackgroundColor3 =
            Color3.fromRGB(160, 55, 55)
    end
end)

--//==================================================
--// АВТО-ГАНТЕЛЯ
--//==================================================

WeightButton.MouseButton1Click:Connect(function()

    AutoWeight = not AutoWeight

    if AutoWeight then

        WeightButton.Text =
            T[CurrentLanguage].weight .. ": " ..
            T[CurrentLanguage].on

        WeightButton.BackgroundColor3 =
            Color3.fromRGB(45, 170, 70)

        task.spawn(function()

            while AutoWeight do

                local Character = Player.Character
                local Backpack = Player:FindFirstChild("Backpack")
                local Humanoid =
                    Character and Character:FindFirstChildOfClass("Humanoid")

                if Character and Backpack and Humanoid then

                    local Weight =
                        Character:FindFirstChild("Weight")

                    if not Weight then
                        Weight =
                            Backpack:FindFirstChild("Weight")
                    end

                    if Weight and Weight:IsA("Tool") then

                        pcall(function()
                            Humanoid:EquipTool(Weight)
                        end)
                    end
                end

                local Event = GetMuscleEvent()

                if Event then

                    pcall(function()
                        Event:FireServer("rep")
                    end)
                end

                task.wait(0.05)
            end
        end)

    else

        WeightButton.Text =
            T[CurrentLanguage].weight .. ": " ..
            T[CurrentLanguage].off

        WeightButton.BackgroundColor3 =
            Color3.fromRGB(160, 55, 55)
    end
end)

--//==================================================
--// РЕБИТХ
--//==================================================

local function AskRebirthAmount()

    local PromptGui = Instance.new("ScreenGui")
    PromptGui.Name = "RebirthPrompt"
    PromptGui.ResetOnSpawn = false
    PromptGui.Parent = PlayerGui

    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(0, 260, 0, 160)
    Frame.Position = UDim2.new(0.5, -130, 0.5, -80)
    Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Frame.BorderSizePixel = 0
    Frame.Parent = PromptGui

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 10)
    Corner.Parent = Frame

    local Question = Instance.new("TextLabel")
    Question.Size = UDim2.new(1, -20, 0, 45)
    Question.Position = UDim2.new(0, 10, 0, 10)
    Question.BackgroundTransparency = 1
    Question.TextColor3 = Color3.fromRGB(255, 255, 255)
    Question.Text = T[CurrentLanguage].rebirthQuestion
    Question.TextWrapped = true
    Question.TextSize = 14
    Question.Parent = Frame

    local Info = Instance.new("TextLabel")
    Info.Size = UDim2.new(1, -20, 0, 20)
    Info.Position = UDim2.new(0, 10, 0, 55)
    Info.BackgroundTransparency = 1
    Info.TextColor3 = Color3.fromRGB(255, 220, 80)
    Info.Text = T[CurrentLanguage].rebirthInfo
    Info.TextSize = 12
    Info.Parent = Frame

    local Box = Instance.new("TextBox")
    Box.Size = UDim2.new(1, -20, 0, 32)
    Box.Position = UDim2.new(0, 10, 0, 82)
    Box.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    Box.TextColor3 = Color3.fromRGB(255, 255, 255)
    Box.PlaceholderText = "0"
    Box.Text = ""
    Box.TextSize = 14
    Box.Parent = Frame

    local BoxCorner = Instance.new("UICorner")
    BoxCorner.CornerRadius = UDim.new(0, 6)
    BoxCorner.Parent = Box

    local OK = Instance.new("TextButton")
    OK.Size = UDim2.new(1, -20, 0, 30)
    OK.Position = UDim2.new(0, 10, 0, 120)
    OK.BackgroundColor3 = Color3.fromRGB(45, 170, 70)
    OK.TextColor3 = Color3.fromRGB(255, 255, 255)
    OK.Text = T[CurrentLanguage].ok
    OK.TextSize = 14
    OK.Parent = Frame

    local OKCorner = Instance.new("UICorner")
    OKCorner.CornerRadius = UDim.new(0, 6)
    OKCorner.Parent = OK

    local result = nil

    OK.MouseButton1Click:Connect(function()

        local number = tonumber(Box.Text)

        if number then

            result = math.max(0, math.floor(number))

            PromptGui:Destroy()
        end
    end)

    repeat
        task.wait()
    until result ~= nil or not PromptGui.Parent

    if result == nil then
        return 0
    end

    return result
end

RebirthButton.MouseButton1Click:Connect(function()

    if AutoRebirth then

        AutoRebirth = false

        RebirthButton.Text =
            T[CurrentLanguage].rebirth .. ": " ..
            T[CurrentLanguage].off

        RebirthButton.BackgroundColor3 =
            Color3.fromRGB(160, 55, 55)

        return
    end

    RebirthTarget = AskRebirthAmount()
    RebirthDone = 0
    AutoRebirth = true

    RebirthButton.Text =
        T[CurrentLanguage].rebirth .. ": " ..
        T[CurrentLanguage].on

    RebirthButton.BackgroundColor3 =
        Color3.fromRGB(45, 170, 70)

    task.spawn(function()

        while AutoRebirth do

            local Remote = GetRebirthRemote()

            if Remote then

                pcall(function()
                    Remote:InvokeServer("rebirthRequest")
                end)

                RebirthDone =
                    RebirthDone + 1
            end

            if RebirthTarget > 0
            and RebirthDone >= RebirthTarget then

                AutoRebirth = false

                RebirthButton.Text =
                    T[CurrentLanguage].rebirth .. ": " ..
                    T[CurrentLanguage].off

                RebirthButton.BackgroundColor3 =
                    Color3.fromRGB(160, 55, 55)

                break
            end

            task.wait(0.1)
        end
    end)
end)

--//==================================================
--// TP KING
--//==================================================

KingButton.MouseButton1Click:Connect(function()

    AutoKing = not AutoKing

    if AutoKing then

        KingButton.Text =
            T[CurrentLanguage].king .. ": " ..
            T[CurrentLanguage].on

        KingButton.BackgroundColor3 =
            Color3.fromRGB(45, 170, 70)

        local Character = Player.Character
        local Root =
            Character and Character:FindFirstChild("HumanoidRootPart")

        if Root then

            Root.CFrame = CFrame.new(
                4195.27344,
                990.221802,
                -3876.88794
            )
        end

    else

        KingButton.Text =
            T[CurrentLanguage].king .. ": " ..
            T[CurrentLanguage].off

        KingButton.BackgroundColor3 =
            Color3.fromRGB(160, 55, 55)
    end
end)

--//==================================================
--// ANTI AFK
--//==================================================

AFKButton.MouseButton1Click:Connect(function()

    AntiAFK = not AntiAFK

    if AntiAFK then

        AFKButton.Text =
            T[CurrentLanguage].afk .. ": " ..
            T[CurrentLanguage].on

        AFKButton.BackgroundColor3 =
            Color3.fromRGB(45, 170, 70)

        Player.Idled:Connect(function()

            if AntiAFK then

                pcall(function()

                    VirtualUser:Button2Down(
                        Vector2.new(0, 0),
                        workspace.CurrentCamera.CFrame
                    )

                    task.wait(1)

                    VirtualUser:Button2Up(
                        Vector2.new(0, 0),
                        workspace.CurrentCamera.CFrame
                    )
                end)
            end
        end)

    else

        AFKButton.Text =
            T[CurrentLanguage].afk .. ": " ..
            T[CurrentLanguage].off

        AFKButton.BackgroundColor3 =
            Color3.fromRGB(160, 55, 55)
    end
end)

--//==================================================
--// ОБЫЧНЫЙ AUTO BOSS
--//==================================================

local function StartBossNoclip()

    if BossNoclipConnection then
        BossNoclipConnection:Disconnect()
    end

    BossNoclipConnection =
        RunService.Stepped:Connect(function()

            if not AutoBoss then
                return
            end

            local Character = Player.Character

            if not Character then
                return
            end

            for _, Part in ipairs(Character:GetDescendants()) do

                if Part:IsA("BasePart") then

                    if BossSavedCollision[Part] == nil then
                        BossSavedCollision[Part] =
                            Part.CanCollide
                    end

                    Part.CanCollide = false
                end
            end
        end)
end

local function StopBossNoclip()

    if BossNoclipConnection then
        BossNoclipConnection:Disconnect()
        BossNoclipConnection = nil
    end

    for Part, Value in pairs(BossSavedCollision) do

        if Part and Part.Parent then
            Part.CanCollide = Value
        end
    end

    BossSavedCollision = {}
end

local function StartBossFly()

    if BossFlyConnection then
        BossFlyConnection:Disconnect()
    end

    BossFlyConnection =
        RunService.Heartbeat:Connect(function()

            if not AutoBoss then
                return
            end

            local Character = Player.Character
            local Root =
                Character and Character:FindFirstChild("HumanoidRootPart")

            if Root then

                Root.CFrame = CFrame.new(
                    BossX,
                    BossY,
                    BossZ
                )

                Root.AssemblyLinearVelocity =
                    Vector3.zero

                Root.AssemblyAngularVelocity =
                    Vector3.zero
            end
        end)
end

local function StopBossFly()

    if BossFlyConnection then
        BossFlyConnection:Disconnect()
        BossFlyConnection = nil
    end
end

BossButton.MouseButton1Click:Connect(function()

    AutoBoss = not AutoBoss

    if AutoBoss then

        local Character = Player.Character
        local Humanoid =
            Character and Character:FindFirstChildOfClass("Humanoid")

        local Root =
            Character and Character:FindFirstChild("HumanoidRootPart")

        if Root then
            BossSavedCFrame = Root.CFrame
        end

        BossY = BossNormalY

        LastBossHealth =
            Humanoid and Humanoid.Health or nil

        StartBossNoclip()
        StartBossFly()

        BossButton.Text =
            T[CurrentLanguage].boss .. ": " ..
            T[CurrentLanguage].on

        BossButton.BackgroundColor3 =
            Color3.fromRGB(45, 170, 70)

        task.spawn(function()

            while AutoBoss do

                local Character2 = Player.Character

                local Humanoid2 =
                    Character2 and
                    Character2:FindFirstChildOfClass("Humanoid")

                if Humanoid2 then

                    if LastBossHealth
                    and Humanoid2.Health < LastBossHealth then

                        BossY = BossDamageY
                    end

                    LastBossHealth = Humanoid2.Health
                end

                DoPunch()

                task.wait(0.05)
            end
        end)

    else

        AutoBoss = false

        StopBossFly()
        StopBossNoclip()

        local Character = Player.Character
        local Root =
            Character and Character:FindFirstChild("HumanoidRootPart")

        if Root and BossSavedCFrame then
            Root.CFrame = BossSavedCFrame
        end

        BossSavedCFrame = nil
        BossY = BossNormalY
        LastBossHealth = nil

        BossButton.Text =
            T[CurrentLanguage].boss .. ": " ..
            T[CurrentLanguage].off

        BossButton.BackgroundColor3 =
            Color3.fromRGB(160, 55, 55)
    end
end)

--//==================================================
--// АВТО-БОССЫ И ГАНТЕЛЯ
--//==================================================

local function BossWeightGetCharacter()

    local Character = Player.Character

    if not Character then
        return nil, nil, nil
    end

    local Humanoid =
        Character:FindFirstChildOfClass("Humanoid")

    local Root =
        Character:FindFirstChild("HumanoidRootPart")

    return Character, Humanoid, Root
end

--// ТОЧНО ЛОГИКА АВТО-ГАНТЕЛИ
local function BossWeightDoWeight()

    local Character = Player.Character
    local Backpack = Player:FindFirstChild("Backpack")

    if not Character or not Backpack then
        return
    end

    local Humanoid =
        Character:FindFirstChildOfClass("Humanoid")

    if not Humanoid then
        return
    end

    local Weight =
        Character:FindFirstChild("Weight")

    if not Weight then
        Weight =
            Backpack:FindFirstChild("Weight")
    end

    if Weight and Weight:IsA("Tool") then

        pcall(function()

            if Weight.Parent ~= Character then
                Humanoid:EquipTool(Weight)
            end
        end)
    end

    local Event = GetMuscleEvent()

    if Event then

        pcall(function()
            Event:FireServer("rep")
        end)
    end
end

local function BossWeightMove(Y)

    local Character, Humanoid, Root =
        BossWeightGetCharacter()

    if Root then

        Root.CFrame = CFrame.new(
            BossWeightX,
            Y,
            BossWeightZ
        )

        Root.AssemblyLinearVelocity =
            Vector3.zero

        Root.AssemblyAngularVelocity =
            Vector3.zero
    end
end

--// NOCLIP
local function BossWeightStartNoclip()

    if BossWeightNoclipConnection then
        BossWeightNoclipConnection:Disconnect()
    end

    BossWeightNoclipConnection =
        RunService.Stepped:Connect(function()

            if not AutoBossAndWeight then
                return
            end

            local Character = Player.Character

            if not Character then
                return
            end

            for _, Part in ipairs(Character:GetDescendants()) do

                if Part:IsA("BasePart") then

                    if BossWeightSavedCollision[Part] == nil then
                        BossWeightSavedCollision[Part] =
                            Part.CanCollide
                    end

                    Part.CanCollide = false
                end
            end
        end)
end

local function BossWeightStopNoclip()

    if BossWeightNoclipConnection then
        BossWeightNoclipConnection:Disconnect()
        BossWeightNoclipConnection = nil
    end

    for Part, Value in pairs(BossWeightSavedCollision) do

        if Part and Part.Parent then
            Part.CanCollide = Value
        end
    end

    BossWeightSavedCollision = {}
end

--// ПОЛЁТ / ФИКСАЦИЯ
local function BossWeightStartFly()

    if BossWeightFlyConnection then
        BossWeightFlyConnection:Disconnect()
    end

    BossWeightFlyConnection =
        RunService.Heartbeat:Connect(function()

            if not AutoBossAndWeight then
                return
            end

            local Character = Player.Character
            local Root =
                Character and
                Character:FindFirstChild("HumanoidRootPart")

            if not Root then
                return
            end

            local CurrentY = BossWeightY

            if BossWeightStage == 1 then
                CurrentY = BossWeightDamageY
            elseif BossWeightStage == 2 then
                CurrentY = BossWeightFinalY
            end

            Root.CFrame = CFrame.new(
                BossWeightX,
                CurrentY,
                BossWeightZ
            )

            Root.AssemblyLinearVelocity =
                Vector3.zero

            Root.AssemblyAngularVelocity =
                Vector3.zero
        end)
end

local function BossWeightStopFly()

    if BossWeightFlyConnection then
        BossWeightFlyConnection:Disconnect()
        BossWeightFlyConnection = nil
    end
end

--// УРОН
local function BossWeightStartHealth()

    if BossWeightHealthConnection then
        BossWeightHealthConnection:Disconnect()
    end

    local Character, Humanoid, Root =
        BossWeightGetCharacter()

    if not Humanoid then
        return
    end

    BossWeightLastHealth = Humanoid.Health

    BossWeightHealthConnection =
        Humanoid.HealthChanged:Connect(function(NewHealth)

            if not AutoBossAndWeight then
                BossWeightLastHealth = NewHealth
                return
            end

            local OldHealth = BossWeightLastHealth

            BossWeightLastHealth = NewHealth

            if not OldHealth then
                return
            end

            if NewHealth >= OldHealth then
                return
            end

            --// ПЕРВЫЙ УРОН
            if BossWeightStage == 0 then

                BossWeightStage = 1

                BossWeightMove(BossWeightDamageY)

            --// ВТОРОЙ УРОН
            elseif BossWeightStage == 1 then

                BossWeightStage = 2

                BossWeightMove(BossWeightFinalY)

                --// 10 МИНУТ
                BossWeightResetTime =
                    os.clock() + 600
            end
        end)
end

local function BossWeightStopHealth()

    if BossWeightHealthConnection then
        BossWeightHealthConnection:Disconnect()
        BossWeightHealthConnection = nil
    end
end

--// ГЛАВНЫЙ ЦИКЛ
local function BossWeightStartLoop()

    if BossWeightLoopConnection then
        BossWeightLoopConnection:Disconnect()
    end

    BossWeightLoopConnection =
        RunService.Heartbeat:Connect(function()

            if not AutoBossAndWeight then
                return
            end

            local Character, Humanoid, Root =
                BossWeightGetCharacter()

            if not Humanoid or not Root then
                return
            end

            --// 10 МИНУТ ПРОШЛО
            if BossWeightStage == 2
            and BossWeightResetTime > 0
            and os.clock() >= BossWeightResetTime then

                BossWeightStage = 0
                BossWeightResetTime = 0
                BossWeightLastHealth = Humanoid.Health

                BossWeightMove(BossWeightY)
            end

            --// Y32 = ГАНТЕЛЯ
            if BossWeightStage == 0 then

                BossWeightDoWeight()

            --// Y28 = УДАРЫ
            elseif BossWeightStage == 1 then

                DoPunch()

            --// Y4 = УДАРЫ
            elseif BossWeightStage == 2 then

                DoPunch()
            end
        end)
end

local function BossWeightStopLoop()

    if BossWeightLoopConnection then
        BossWeightLoopConnection:Disconnect()
        BossWeightLoopConnection = nil
    end
end

--// ЗАПУСК
local function StartBossWeight()

    if AutoBossAndWeight then
        return
    end

    local Character, Humanoid, Root =
        BossWeightGetCharacter()

    if not Character or not Humanoid or not Root then
        return
    end

    AutoBossAndWeight = true

    BossWeightSavedCFrame = Root.CFrame

    BossWeightStage = 0
    BossWeightResetTime = 0
    BossWeightLastHealth = Humanoid.Health

    BossWeightStartNoclip()
    BossWeightStartFly()
    BossWeightStartHealth()
    BossWeightStartLoop()

    --// СРАЗУ Y32
    BossWeightMove(BossWeightY)

    --// СРАЗУ ЗАПУСКАЕМ ГАНТЕЛЮ
    task.spawn(function()

        task.wait(0.1)

        if AutoBossAndWeight
        and BossWeightStage == 0 then

            BossWeightDoWeight()
        end
    end)
end

--// ОСТАНОВКА
local function StopBossWeight()

    AutoBossAndWeight = false

    BossWeightStopLoop()
    BossWeightStopHealth()
    BossWeightStopFly()
    BossWeightStopNoclip()

    BossWeightStage = 0
    BossWeightResetTime = 0
    BossWeightLastHealth = nil

    local Character, Humanoid, Root =
        BossWeightGetCharacter()

    if Root and BossWeightSavedCFrame then
        Root.CFrame = BossWeightSavedCFrame
    end

    BossWeightSavedCFrame = nil
end

--// КНОПКА
BossWeightButton.MouseButton1Click:Connect(function()

    if AutoBossAndWeight then

        StopBossWeight()

        BossWeightButton.Text =
            T[CurrentLanguage].bossWeight .. ": " ..
            T[CurrentLanguage].off

        BossWeightButton.BackgroundColor3 =
            Color3.fromRGB(160, 55, 55)

    else

        StartBossWeight()

        if AutoBossAndWeight then

            BossWeightButton.Text =
                T[CurrentLanguage].bossWeight .. ": " ..
                T[CurrentLanguage].on

            BossWeightButton.BackgroundColor3 =
                Color3.fromRGB(45, 170, 70)

        else

            BossWeightButton.Text =
                T[CurrentLanguage].bossWeight .. ": " ..
                T[CurrentLanguage].off

            BossWeightButton.BackgroundColor3 =
                Color3.fromRGB(160, 55, 55)
        end
    end
end)

--//==================================================
--// AUTO DURABILITY
--//==================================================

DurabilityButton.MouseButton1Click:Connect(function()

    AutoDurability = not AutoDurability

    if AutoDurability then

        DurabilityButton.Text =
            T[CurrentLanguage].durability .. ": " ..
            T[CurrentLanguage].on

        DurabilityButton.BackgroundColor3 =
            Color3.fromRGB(45, 170, 70)

        task.spawn(function()

            while AutoDurability do

                local Event = GetMuscleEvent()

                if Event then

                    pcall(function()
                        Event:FireServer("rep")
                    end)
                end

                task.wait(0.05)
            end
        end)

    else

        DurabilityButton.Text =
            T[CurrentLanguage].durability .. ": " ..
            T[CurrentLanguage].off

        DurabilityButton.BackgroundColor3 =
            Color3.fromRGB(160, 55, 55)
    end
end)

--//==================================================
--// AUTO PUNCH
--//==================================================

PunchButton.MouseButton1Click:Connect(function()

    AutoPunch = not AutoPunch

    if AutoPunch then

        PunchButton.Text =
            T[CurrentLanguage].punch .. ": " ..
            T[CurrentLanguage].on

        PunchButton.BackgroundColor3 =
            Color3.fromRGB(45, 170, 70)

        task.spawn(function()

            while AutoPunch do

                DoPunch()

                task.wait(0.03)
            end
        end)

    else

        PunchButton.Text =
            T[CurrentLanguage].punch .. ": " ..
            T[CurrentLanguage].off

        PunchButton.BackgroundColor3 =
            Color3.fromRGB(160, 55, 55)
    end
end)

--//==================================================
--// KING ROCK
--//==================================================

KingRockButton.MouseButton1Click:Connect(function()

    AutoKingRock = not AutoKingRock

    if AutoKingRock then

        KingRockButton.Text =
            T[CurrentLanguage].kingrock .. ": " ..
            T[CurrentLanguage].on

        KingRockButton.BackgroundColor3 =
            Color3.fromRGB(45, 170, 70)

        task.spawn(function()

            while AutoKingRock do

                local Character = Player.Character
                local Root =
                    Character and
                    Character:FindFirstChild("HumanoidRootPart")

                if Root then

                    Root.CFrame = CFrame.new(
                        4195.27344,
                        990.221802,
                        -3876.88794
                    )
                end

                task.wait(0.2)
            end
        end)

    else

        KingRockButton.Text =
            T[CurrentLanguage].kingrock .. ": " ..
            T[CurrentLanguage].off

        KingRockButton.BackgroundColor3 =
            Color3.fromRGB(160, 55, 55)
    end
end)

--//==================================================
--// LANGUAGE
--//==================================================

local LanguageGui = Instance.new("ScreenGui")
LanguageGui.Name = "LanguageSelector"
LanguageGui.ResetOnSpawn = false
LanguageGui.Parent = PlayerGui

local LanguageFrame = Instance.new("Frame")
LanguageFrame.Size = UDim2.new(0, 180, 0, 125)
LanguageFrame.Position = UDim2.new(0.5, -90, 0.5, -62)
LanguageFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
LanguageFrame.BorderSizePixel = 0
LanguageFrame.Parent = LanguageGui

local LanguageCorner = Instance.new("UICorner")
LanguageCorner.CornerRadius = UDim.new(0, 10)
LanguageCorner.Parent = LanguageFrame

local LanguageTitle = Instance.new("TextLabel")
LanguageTitle.Size = UDim2.new(1, 0, 0, 35)
LanguageTitle.BackgroundTransparency = 1
LanguageTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
LanguageTitle.Text = "Language / Язык"
LanguageTitle.TextSize = 14
LanguageTitle.Font = Enum.Font.SourceSansBold
LanguageTitle.Parent = LanguageFrame

local RUButton = Instance.new("TextButton")
RUButton.Size = UDim2.new(1, -20, 0, 32)
RUButton.Position = UDim2.new(0, 10, 0, 42)
RUButton.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
RUButton.TextColor3 = Color3.fromRGB(255, 255, 255)
RUButton.Text = "🇷🇺 Русский"
RUButton.TextSize = 14
RUButton.Parent = LanguageFrame

local RUCorner = Instance.new("UICorner")
RUCorner.CornerRadius = UDim.new(0, 6)
RUCorner.Parent = RUButton

local ENButton = Instance.new("TextButton")
ENButton.Size = UDim2.new(1, -20, 0, 32)
ENButton.Position = UDim2.new(0, 10, 0, 80)
ENButton.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
ENButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ENButton.Text = "🇬🇧 English"
ENButton.TextSize = 14
ENButton.Parent = LanguageFrame

local ENCorner = Instance.new("UICorner")
ENCorner.CornerRadius = UDim.new(0, 6)
ENCorner.Parent = ENButton

--//==================================================
--// APPLY LANGUAGE
--//==================================================

local function ApplyLanguage()

    Title.Text =
        T[CurrentLanguage].title

    TrainButton.Text =
        T[CurrentLanguage].train .. ": " ..
        (AutoTrain and T[CurrentLanguage].on
        or T[CurrentLanguage].off)

    WeightButton.Text =
        T[CurrentLanguage].weight .. ": " ..
        (AutoWeight and T[CurrentLanguage].on
        or T[CurrentLanguage].off)

    RebirthButton.Text =
        T[CurrentLanguage].rebirth .. ": " ..
        (AutoRebirth and T[CurrentLanguage].on
        or T[CurrentLanguage].off)

    KingButton.Text =
        T[CurrentLanguage].king .. ": " ..
        (AutoKing and T[CurrentLanguage].on
        or T[CurrentLanguage].off)

    AFKButton.Text =
        T[CurrentLanguage].afk .. ": " ..
        (AntiAFK and T[CurrentLanguage].on
        or T[CurrentLanguage].off)

    BossButton.Text =
        T[CurrentLanguage].boss .. ": " ..
        (AutoBoss and T[CurrentLanguage].on
        or T[CurrentLanguage].off)

    BossSmall.Text =
        T[CurrentLanguage].bossSmall

    DurabilityButton.Text =
        T[CurrentLanguage].durability .. ": " ..
        (AutoDurability and T[CurrentLanguage].on
        or T[CurrentLanguage].off)

    PunchButton.Text =
        T[CurrentLanguage].punch .. ": " ..
        (AutoPunch and T[CurrentLanguage].on
        or T[CurrentLanguage].off)

    KingRockButton.Text =
        T[CurrentLanguage].kingrock .. ": " ..
        (AutoKingRock and T[CurrentLanguage].on
        or T[CurrentLanguage].off)

    BossWeightButton.Text =
        T[CurrentLanguage].bossWeight .. ": " ..
        (AutoBossAndWeight and T[CurrentLanguage].on
        or T[CurrentLanguage].off)
end

RUButton.MouseButton1Click:Connect(function()

    CurrentLanguage = "ru"

    ApplyLanguage()

    LanguageGui:Destroy()
end)

ENButton.MouseButton1Click:Connect(function()

    CurrentLanguage = "en"

    ApplyLanguage()

    LanguageGui:Destroy()
end)

ApplyLanguage()

print("[KIRILL_PANEL] NO KEY V1.55 loaded")
print("[KIRILL_PANEL] Auto-Boss & Weight loaded")
