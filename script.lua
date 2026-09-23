--==================================================
-- KIRILL_PANEL NO KEY V1.6
--==================================================

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

--==================================================
-- VARIABLES
--==================================================

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

--==================================================
-- ORDINARY AUTO BOSS
--==================================================

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

--==================================================
-- AUTO BOSS & WEIGHT
--==================================================

local BossWeightX = 7
local BossWeightY = 32
local BossWeightDamageY = 28
local BossWeightFinalY = 4
local BossWeightZ = -1300

local BossWeightSavedCFrame = nil

local BossWeightNoclipConnection = nil
local BossWeightFlyConnection = nil
local BossWeightHealthConnection = nil

local BossWeightStage = 0
local BossWeightTimerEnd = 0
local BossWeightTimerToken = 0
local BossWeightLoopRunning = false

--==================================================
-- TEXT
--==================================================

local T = {

    ru = {
        title = "KIRILL_PANEL NO KEY V1.6",

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
        title = "KIRILL_PANEL NO KEY V1.6",

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

--==================================================
-- REMOVE OLD GUI
--==================================================

local OldGui = PlayerGui:FindFirstChild("KIRILL_PANEL")

if OldGui then
    OldGui:Destroy()
end

local OldLanguageGui = PlayerGui:FindFirstChild("KIRILL_LANGUAGE")

if OldLanguageGui then
    OldLanguageGui:Destroy()
end

--==================================================
-- MAIN GUI
--==================================================

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "KIRILL_PANEL"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = PlayerGui

--==================================================
-- OPEN BUTTON
--==================================================

local OpenButton = Instance.new("TextButton")

OpenButton.Name = "OpenButton"
OpenButton.Size = UDim2.new(0, 48, 0, 48)
OpenButton.Position = UDim2.new(1, -60, 0, 15)

OpenButton.BackgroundColor3 =
    Color3.fromRGB(35, 35, 35)

OpenButton.TextColor3 =
    Color3.fromRGB(255, 255, 255)

OpenButton.Text = "💪"
OpenButton.TextSize = 25

OpenButton.BorderSizePixel = 0
OpenButton.Visible = false
OpenButton.Parent = ScreenGui

local OpenCorner = Instance.new("UICorner")
OpenCorner.CornerRadius = UDim.new(1, 0)
OpenCorner.Parent = OpenButton

--==================================================
-- MAIN FRAME
--==================================================

local MainFrame = Instance.new("Frame")

MainFrame.Name = "MainFrame"

MainFrame.Size = UDim2.new(0, 230, 0, 280)

MainFrame.Position =
    UDim2.new(0.5, -115, 0.5, -140)

MainFrame.BackgroundColor3 =
    Color3.fromRGB(25, 25, 25)

MainFrame.BorderSizePixel = 0

-- ВАЖНО:
-- панель скрыта до выбора языка
MainFrame.Visible = false

MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 10)
MainCorner.Parent = MainFrame

--==================================================
-- TITLE
--==================================================

local Title = Instance.new("TextLabel")

Title.Size = UDim2.new(1, 0, 0, 38)

Title.Position =
    UDim2.new(0, 0, 0, 0)

Title.BackgroundColor3 =
    Color3.fromRGB(35, 35, 35)

Title.TextColor3 =
    Color3.fromRGB(255, 255, 255)

Title.Text =
    T.ru.title

Title.TextSize = 14
Title.Font = Enum.Font.SourceSansBold

Title.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 10)
TitleCorner.Parent = Title

--==================================================
-- SCROLL
--==================================================

local Scroll = Instance.new("ScrollingFrame")

Scroll.Name = "Scroll"

Scroll.Size =
    UDim2.new(1, -10, 1, -45)

Scroll.Position =
    UDim2.new(0, 5, 0, 40)

Scroll.BackgroundTransparency = 1
Scroll.BorderSizePixel = 0

Scroll.ScrollBarThickness = 5

Scroll.CanvasSize =
    UDim2.new(0, 0, 0, 445)

Scroll.Parent = MainFrame

--==================================================
-- BUTTON CREATOR
--==================================================

local function CreateToggleButton(Name, Text, Y)

    local Button = Instance.new("TextButton")

    Button.Name = Name

    Button.Size =
        UDim2.new(1, -10, 0, 38)

    Button.Position =
        UDim2.new(0, 5, 0, Y)

    Button.BackgroundColor3 =
        Color3.fromRGB(160, 55, 55)

    Button.TextColor3 =
        Color3.fromRGB(255, 255, 255)

    Button.Text =
        Text .. ": " .. T.ru.off

    Button.TextSize = 14
    Button.Font = Enum.Font.SourceSansBold

    Button.BorderSizePixel = 0

    Button.Parent = Scroll

    local Corner = Instance.new("UICorner")

    Corner.CornerRadius =
        UDim.new(0, 7)

    Corner.Parent = Button

    return Button
end

--==================================================
-- BUTTONS
--==================================================

local TrainButton =
    CreateToggleButton(
        "TrainButton",
        T.ru.train,
        2
    )

local WeightButton =
    CreateToggleButton(
        "WeightButton",
        T.ru.weight,
        46
    )

local RebirthButton =
    CreateToggleButton(
        "RebirthButton",
        T.ru.rebirth,
        90
    )

local KingButton =
    CreateToggleButton(
        "KingButton",
        T.ru.king,
        134
    )

local AFKButton =
    CreateToggleButton(
        "AFKButton",
        T.ru.afk,
        178
    )

local BossButton =
    CreateToggleButton(
        "BossButton",
        T.ru.boss,
        222
    )

local BossSmall = Instance.new("TextLabel")

BossSmall.Name = "BossSmall"

BossSmall.Size =
    UDim2.new(1, -10, 0, 18)

BossSmall.Position =
    UDim2.new(0, 5, 0, 223)

BossSmall.BackgroundTransparency = 1

BossSmall.TextColor3 =
    Color3.fromRGB(255, 220, 80)

BossSmall.Text =
    T.ru.bossSmall

BossSmall.TextSize = 10
BossSmall.Font = Enum.Font.SourceSansBold

BossSmall.Parent = Scroll

local DurabilityButton =
    CreateToggleButton(
        "DurabilityButton",
        T.ru.durability,
        266
    )

local PunchButton =
    CreateToggleButton(
        "PunchButton",
        T.ru.punch,
        310
    )

local KingRockButton =
    CreateToggleButton(
        "KingRockButton",
        T.ru.kingrock,
        354
    )

local BossWeightButton =
    CreateToggleButton(
        "BossWeightButton",
        T.ru.bossWeight,
        398
    )

--==================================================
-- DRAG PANEL
--==================================================

local dragging = false
local dragStart = nil
local startPos = nil

Title.InputBegan:Connect(function(Input)

    if Input.UserInputType ==
        Enum.UserInputType.MouseButton1
        or
        Input.UserInputType ==
        Enum.UserInputType.Touch then

        dragging = true

        dragStart =
            Input.Position

        startPos =
            MainFrame.Position
    end
end)

UserInputService.InputChanged:Connect(function(Input)

    if not dragging then
        return
    end

    if Input.UserInputType ==
        Enum.UserInputType.MouseMovement
        or
        Input.UserInputType ==
        Enum.UserInputType.Touch then

        local Delta =
            Input.Position - dragStart

        MainFrame.Position =
            UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + Delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + Delta.Y
            )
    end
end)

UserInputService.InputEnded:Connect(function(Input)

    if Input.UserInputType ==
        Enum.UserInputType.MouseButton1
        or
        Input.UserInputType ==
        Enum.UserInputType.Touch then

        dragging = false
    end
end)

OpenButton.MouseButton1Click:Connect(function()

    MainFrame.Visible =
        not MainFrame.Visible
end)

--==================================================
-- MUSCLE EVENT
--==================================================

local function GetMuscleEvent()

    local Event =
        Player:FindFirstChild("muscleEvent")

    if Event and Event:IsA("RemoteEvent") then
        return Event
    end

    local rEvents =
        ReplicatedStorage:FindFirstChild("rEvents")

    if rEvents then

        local Event2 =
            rEvents:FindFirstChild("muscleEvent")

        if Event2 and Event2:IsA("RemoteEvent") then
            return Event2
        end
    end

    return nil
end

--==================================================
-- REBIRTH REMOTE
--==================================================

local function GetRebirthRemote()

    local rEvents =
        ReplicatedStorage:FindFirstChild("rEvents")

    if not rEvents then
        return nil
    end

    return rEvents:FindFirstChild("rebirthRemote")
end

--==================================================
-- PUNCH
--==================================================

local function GetPunch()

    local Character =
        Player.Character

    local Backpack =
        Player:FindFirstChild("Backpack")

    if Character then

        local Punch =
            Character:FindFirstChild("Punch")

        if Punch and Punch:IsA("Tool") then
            return Punch
        end
    end

    if Backpack then

        local Punch =
            Backpack:FindFirstChild("Punch")

        if Punch and Punch:IsA("Tool") then
            return Punch
        end
    end

    return nil
end

local function DoPunch()

    local Character =
        Player.Character

    if not Character then
        return
    end

    local Humanoid =
        Character:FindFirstChildOfClass(
            "Humanoid"
        )

    local Event =
        GetMuscleEvent()

    local Punch =
        GetPunch()

    if Punch
    and Humanoid
    and Punch.Parent ~= Character then

        pcall(function()
            Humanoid:EquipTool(Punch)
        end)

        task.wait(0.02)
    end

    if Event then

        pcall(function()
            Event:FireServer(
                "punch",
                "rightHand"
            )
        end)

        pcall(function()
            Event:FireServer(
                "punch",
                "leftHand"
            )
        end)
    end

    if Punch then

        pcall(function()
            Punch:Activate()
        end)
    end
end

--==================================================
-- AUTO TRAIN
--==================================================

TrainButton.MouseButton1Click:Connect(function()

    AutoTrain =
        not AutoTrain

    if AutoTrain then

        TrainButton.Text =
            T[CurrentLanguage].train ..
            ": " ..
            T[CurrentLanguage].on

        TrainButton.BackgroundColor3 =
            Color3.fromRGB(45, 170, 70)

        task.spawn(function()

            while AutoTrain do

                local Event =
                    GetMuscleEvent()

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
            T[CurrentLanguage].train ..
            ": " ..
            T[CurrentLanguage].off

        TrainButton.BackgroundColor3 =
            Color3.fromRGB(160, 55, 55)
    end
end)

--==================================================
-- AUTO WEIGHT
--==================================================

WeightButton.MouseButton1Click:Connect(function()

    AutoWeight =
        not AutoWeight

    if AutoWeight then

        WeightButton.Text =
            T[CurrentLanguage].weight ..
            ": " ..
            T[CurrentLanguage].on

        WeightButton.BackgroundColor3 =
            Color3.fromRGB(45, 170, 70)

        task.spawn(function()

            while AutoWeight do

                local Character =
                    Player.Character

                local Backpack =
                    Player:FindFirstChild("Backpack")

                local Humanoid =
                    Character
                    and
                    Character:FindFirstChildOfClass(
                        "Humanoid"
                    )

                if Character
                and Backpack
                and Humanoid then

                    local Weight =
                        Character:FindFirstChild(
                            "Weight"
                        )

                    if not Weight then

                        Weight =
                            Backpack:FindFirstChild(
                                "Weight"
                            )
                    end

                    if Weight
                    and Weight:IsA("Tool") then

                        pcall(function()

                            if Weight.Parent
                                ~= Character then

                                Humanoid:EquipTool(
                                    Weight
                                )
                            end
                        end)
                    end
                end

                local Event =
                    GetMuscleEvent()

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
            T[CurrentLanguage].weight ..
            ": " ..
            T[CurrentLanguage].off

        WeightButton.BackgroundColor3 =
            Color3.fromRGB(160, 55, 55)
    end
end)

--==================================================
-- REBIRTH PROMPT
--==================================================

local function AskRebirthAmount()

    local PromptGui =
        Instance.new("ScreenGui")

    PromptGui.Name =
        "RebirthPrompt"

    PromptGui.ResetOnSpawn =
        false

    PromptGui.Parent =
        PlayerGui

    local Frame =
        Instance.new("Frame")

    Frame.Size =
        UDim2.new(0, 260, 0, 160)

    Frame.Position =
        UDim2.new(0.5, -130, 0.5, -80)

    Frame.BackgroundColor3 =
        Color3.fromRGB(30, 30, 30)

    Frame.BorderSizePixel = 0
    Frame.Parent = PromptGui

    local Corner =
        Instance.new("UICorner")

    Corner.CornerRadius =
        UDim.new(0, 10)

    Corner.Parent = Frame

    local Question =
        Instance.new("TextLabel")

    Question.Size =
        UDim2.new(1, -20, 0, 45)

    Question.Position =
        UDim2.new(0, 10, 0, 10)

    Question.BackgroundTransparency = 1

    Question.TextColor3 =
        Color3.fromRGB(255, 255, 255)

    Question.Text =
        T[CurrentLanguage].rebirthQuestion

    Question.TextWrapped = true
    Question.TextSize = 14
    Question.Parent = Frame

    local Info =
        Instance.new("TextLabel")

    Info.Size =
        UDim2.new(1, -20, 0, 20)

    Info.Position =
        UDim2.new(0, 10, 0, 55)

    Info.BackgroundTransparency = 1

    Info.TextColor3 =
        Color3.fromRGB(255, 220, 80)

    Info.Text =
        T[CurrentLanguage].rebirthInfo

    Info.TextSize = 12
    Info.Parent = Frame

    local Box =
        Instance.new("TextBox")

    Box.Size =
        UDim2.new(1, -20, 0, 32)

    Box.Position =
        UDim2.new(0, 10, 0, 82)

    Box.BackgroundColor3 =
        Color3.fromRGB(45, 45, 45)

    Box.TextColor3 =
        Color3.fromRGB(255, 255, 255)

    Box.PlaceholderText = "0"
    Box.Text = ""
    Box.TextSize = 14

    Box.Parent = Frame

    local BoxCorner =
        Instance.new("UICorner")

    BoxCorner.CornerRadius =
        UDim.new(0, 6)

    BoxCorner.Parent = Box

    local OK =
        Instance.new("TextButton")

    OK.Size =
        UDim2.new(1, -20, 0, 30)

    OK.Position =
        UDim2.new(0, 10, 0, 120)

    OK.BackgroundColor3 =
        Color3.fromRGB(45, 170, 70)

    OK.TextColor3 =
        Color3.fromRGB(255, 255, 255)

    OK.Text =
        T[CurrentLanguage].ok

    OK.TextSize = 14
    OK.Parent = Frame

    local OKCorner =
        Instance.new("UICorner")

    OKCorner.CornerRadius =
        UDim.new(0, 6)

    OKCorner.Parent = OK

    local Result = nil

    OK.MouseButton1Click:Connect(function()

        local Number =
            tonumber(Box.Text)

        if Number then

            Result =
                math.max(
                    0,
                    math.floor(Number)
                )

            PromptGui:Destroy()
        end
    end)

    repeat
        task.wait()
    until Result ~= nil
    or not PromptGui.Parent

    return Result or 0
end

--==================================================
-- AUTO REBIRTH
--==================================================

RebirthButton.MouseButton1Click:Connect(function()

    if AutoRebirth then

        AutoRebirth = false

        RebirthButton.Text =
            T[CurrentLanguage].rebirth ..
            ": " ..
            T[CurrentLanguage].off

        RebirthButton.BackgroundColor3 =
            Color3.fromRGB(160, 55, 55)

        return
    end

    RebirthTarget =
        AskRebirthAmount()

    RebirthDone = 0
    AutoRebirth = true

    RebirthButton.Text =
        T[CurrentLanguage].rebirth ..
        ": " ..
        T[CurrentLanguage].on

    RebirthButton.BackgroundColor3 =
        Color3.fromRGB(45, 170, 70)

    task.spawn(function()

        while AutoRebirth do

            local Remote =
                GetRebirthRemote()

            if Remote then

                pcall(function()

                    Remote:InvokeServer(
                        "rebirthRequest"
                    )
                end)

                RebirthDone =
                    RebirthDone + 1
            end

            if RebirthTarget > 0
            and RebirthDone >= RebirthTarget then

                AutoRebirth = false

                RebirthButton.Text =
                    T[CurrentLanguage].rebirth ..
                    ": " ..
                    T[CurrentLanguage].off

                RebirthButton.BackgroundColor3 =
                    Color3.fromRGB(160, 55, 55)

                break
            end

            task.wait(0.1)
        end
    end)
end)

--==================================================
-- TP KING
--==================================================

KingButton.MouseButton1Click:Connect(function()

    AutoKing =
        not AutoKing

    if AutoKing then

        KingButton.Text =
            T[CurrentLanguage].king ..
            ": " ..
            T[CurrentLanguage].on

        KingButton.BackgroundColor3 =
            Color3.fromRGB(45, 170, 70)

        local Character =
            Player.Character

        local Root =
            Character
            and
            Character:FindFirstChild(
                "HumanoidRootPart"
            )

        if Root then

            Root.CFrame =
                CFrame.new(
                    4195.27344,
                    990.221802,
                    -3876.88794
                )
        end

    else

        KingButton.Text =
            T[CurrentLanguage].king ..
            ": " ..
            T[CurrentLanguage].off

        KingButton.BackgroundColor3 =
            Color3.fromRGB(160, 55, 55)
    end
end)

--==================================================
-- ANTI AFK
--==================================================

Player.Idled:Connect(function()

    if not AntiAFK then
        return
    end

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
end)

AFKButton.MouseButton1Click:Connect(function()

    AntiAFK =
        not AntiAFK

    if AntiAFK then

        AFKButton.Text =
            T[CurrentLanguage].afk ..
            ": " ..
            T[CurrentLanguage].on

        AFKButton.BackgroundColor3 =
            Color3.fromRGB(45, 170, 70)

    else

        AFKButton.Text =
            T[CurrentLanguage].afk ..
            ": " ..
            T[CurrentLanguage].off

        AFKButton.BackgroundColor3 =
            Color3.fromRGB(160, 55, 55)
    end
end)

--==================================================
-- ORDINARY AUTO BOSS NOCLIP
--==================================================

local function StartBossNoclip()

    if BossNoclipConnection then
        BossNoclipConnection:Disconnect()
    end

    BossNoclipConnection =
        RunService.Stepped:Connect(function()

            if not AutoBoss then
                return
            end

            local Character =
                Player.Character

            if not Character then
                return
            end

            for _, Part in
                ipairs(
                    Character:GetDescendants()
                ) do

                if Part:IsA("BasePart") then

                    if BossSavedCollision[Part]
                        == nil then

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

    for Part, Value in
        pairs(BossSavedCollision) do

        if Part and Part.Parent then
            Part.CanCollide = Value
        end
    end

    BossSavedCollision = {}
end

--==================================================
-- ORDINARY AUTO BOSS POSITION
--==================================================

local function StartBossFly()

    if BossFlyConnection then
        BossFlyConnection:Disconnect()
    end

    BossFlyConnection =
        RunService.Heartbeat:Connect(function()

            if not AutoBoss then
                return
            end

            local Character =
                Player.Character

            local Root =
                Character
                and
                Character:FindFirstChild(
                    "HumanoidRootPart"
                )

            if Root then

                Root.CFrame =
                    CFrame.new(
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

--==================================================
-- ORDINARY AUTO BOSS
--==================================================

BossButton.MouseButton1Click:Connect(function()

    AutoBoss =
        not AutoBoss

    if AutoBoss then

        local Character =
            Player.Character

        local Humanoid =
            Character
            and
            Character:FindFirstChildOfClass(
                "Humanoid"
            )

        local Root =
            Character
            and
            Character:FindFirstChild(
                "HumanoidRootPart"
            )

        if Root then
            BossSavedCFrame =
                Root.CFrame
        end

        BossY =
            BossNormalY

        LastBossHealth =
            Humanoid
            and
            Humanoid.Health
            or
            nil

        StartBossNoclip()
        StartBossFly()

        BossButton.Text =
            T[CurrentLanguage].boss ..
            ": " ..
            T[CurrentLanguage].on

        BossButton.BackgroundColor3 =
            Color3.fromRGB(45, 170, 70)

        task.spawn(function()

            while AutoBoss do

                local Character2 =
                    Player.Character

                local Humanoid2 =
                    Character2
                    and
                    Character2:FindFirstChildOfClass(
                        "Humanoid"
                    )

                if Humanoid2 then

                    if LastBossHealth
                    and
                    Humanoid2.Health
                    < LastBossHealth then

                        BossY =
                            BossDamageY
                    end

                    LastBossHealth =
                        Humanoid2.Health
                end

                DoPunch()

                task.wait(0.05)
            end
        end)

    else

        StopBossFly()
        StopBossNoclip()

        local Character =
            Player.Character

        local Root =
            Character
            and
            Character:FindFirstChild(
                "HumanoidRootPart"
            )

        if Root
        and
        BossSavedCFrame then

            Root.CFrame =
                BossSavedCFrame
        end

        BossSavedCFrame = nil
        BossY = BossNormalY
        LastBossHealth = nil

        BossButton.Text =
            T[CurrentLanguage].boss ..
            ": " ..
            T[CurrentLanguage].off

        BossButton.BackgroundColor3 =
            Color3.fromRGB(160, 55, 55)
    end
end)

--==================================================
-- AUTO BOSS & WEIGHT
--==================================================

local function BossWeightMove(Y)

    if not AutoBossAndWeight then
        return
    end

    local Character =
        Player.Character

    if not Character then
        return
    end

    local Root =
        Character:FindFirstChild(
            "HumanoidRootPart"
        )

    if not Root then
        return
    end

    Root.CFrame =
        CFrame.new(
            BossWeightX,
            Y,
            BossWeightZ
        )

    Root.AssemblyLinearVelocity =
        Vector3.zero

    Root.AssemblyAngularVelocity =
        Vector3.zero
end

--==================================================
-- WEIGHT LOGIC
--==================================================

local function BossWeightDoWeight()

    if not AutoBossAndWeight then
        return
    end

    if BossWeightStage ~= 0 then
        return
    end

    local Character =
        Player.Character

    local Backpack =
        Player:FindFirstChild("Backpack")

    if not Character
    or
    not Backpack then
        return
    end

    local Humanoid =
        Character:FindFirstChildOfClass(
            "Humanoid"
        )

    if not Humanoid then
        return
    end

    local Weight =
        Character:FindFirstChild("Weight")

    if not Weight then

        Weight =
            Backpack:FindFirstChild("Weight")
    end

    if Weight
    and
    Weight:IsA("Tool") then

        pcall(function()

            if Weight.Parent
                ~= Character then

                Humanoid:EquipTool(
                    Weight
                )
            end
        end)
    end

    local Event =
        GetMuscleEvent()

    if Event then

        pcall(function()
            Event:FireServer("rep")
        end)
    end
end

--==================================================
-- BOSS WEIGHT NOCLIP
--==================================================

local function BossWeightStartNoclip()

    if BossWeightNoclipConnection then

        BossWeightNoclipConnection:Disconnect()
    end

    BossWeightNoclipConnection =
        RunService.Stepped:Connect(function()

            if not AutoBossAndWeight then
                return
            end

            local Character =
                Player.Character

            if not Character then
                return
            end

            for _, Part in
                ipairs(
                    Character:GetDescendants()
                ) do

                if Part:IsA("BasePart") then
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
end

--==================================================
-- BOSS WEIGHT POSITION LOCK
--==================================================

local function BossWeightStartFly()

    if BossWeightFlyConnection then
        BossWeightFlyConnection:Disconnect()
    end

    BossWeightFlyConnection =
        RunService.Heartbeat:Connect(function()

            if not AutoBossAndWeight then
                return
            end

            local Character =
                Player.Character

            if not Character then
                return
            end

            local Root =
                Character:FindFirstChild(
                    "HumanoidRootPart"
                )

            if not Root then
                return
            end

            local Y

            if BossWeightStage == 0 then

                Y = BossWeightY

            elseif BossWeightStage == 1 then

                Y = BossWeightDamageY

            else

                Y = BossWeightFinalY
            end

            Root.CFrame =
                CFrame.new(
                    BossWeightX,
                    Y,
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

--==================================================
-- 10 MINUTE TIMER
--==================================================

local function BossWeightStartTimer()

    BossWeightTimerToken =
        BossWeightTimerToken + 1

    local MyToken =
        BossWeightTimerToken

    -- 600 секунд = 10 минут
    BossWeightTimerEnd =
        time() + 600

    task.spawn(function()

        while AutoBossAndWeight do

            if MyToken ~= BossWeightTimerToken then
                return
            end

            if BossWeightStage ~= 2 then
                return
            end

            if time() >= BossWeightTimerEnd then

                -- таймер закончен
                BossWeightTimerEnd = 0

                -- начинаем новый цикл
                BossWeightStage = 0

                -- Y32
                BossWeightMove(
                    BossWeightY
                )

                task.wait(0.2)

                if AutoBossAndWeight
                and BossWeightStage == 0 then

                    BossWeightDoWeight()
                end

                return
            end

            task.wait(0.1)
        end
    end)
end

--==================================================
-- HEALTH DAMAGE DETECTION
--==================================================

local function BossWeightConnectHealth()

    if BossWeightHealthConnection then

        BossWeightHealthConnection:Disconnect()
        BossWeightHealthConnection = nil
    end

    local Character =
        Player.Character

    if not Character then
        return
    end

    local Humanoid =
        Character:FindFirstChildOfClass(
            "Humanoid"
        )

    if not Humanoid then
        return
    end

    local LastHealth =
        Humanoid.Health

    BossWeightHealthConnection =
        Humanoid.HealthChanged:Connect(
            function(NewHealth)

                if not AutoBossAndWeight then

                    LastHealth =
                        NewHealth

                    return
                end

                if NewHealth >= LastHealth then

                    LastHealth =
                        NewHealth

                    return
                end

                LastHealth =
                    NewHealth

                --================================
                -- FIRST DAMAGE
                --================================

                if BossWeightStage == 0 then

                    BossWeightStage = 1

                    BossWeightMove(
                        BossWeightDamageY
                    )

                    return
                end

                --================================
                -- SECOND DAMAGE
                --================================

                if BossWeightStage == 1 then

                    BossWeightStage = 2

                    BossWeightMove(
                        BossWeightFinalY
                    )

                    -- запускаем 10 минут
                    BossWeightStartTimer()

                    return
                end
            end
        )
end

local function BossWeightDisconnectHealth()

    if BossWeightHealthConnection then

        BossWeightHealthConnection:Disconnect()
        BossWeightHealthConnection = nil
    end
end

--==================================================
-- BOSS WEIGHT MAIN LOOP
--==================================================

local function BossWeightStartLoop()

    if BossWeightLoopRunning then
        return
    end

    BossWeightLoopRunning = true

    task.spawn(function()

        while AutoBossAndWeight do

            if BossWeightStage == 0 then

                -- Y32
                -- Гантеля
                BossWeightDoWeight()

            elseif BossWeightStage == 1 then

                -- Y28
                -- Удары
                DoPunch()

            elseif BossWeightStage == 2 then

                -- Y4
                -- Удары во время 10 минут
                DoPunch()
            end

            task.wait(0.05)
        end

        BossWeightLoopRunning = false
    end)
end

--==================================================
-- START BOSS & WEIGHT
--==================================================

local function StartBossWeight()

    if AutoBossAndWeight then
        return
    end

    local Character =
        Player.Character

    if not Character then
        return
    end

    local Humanoid =
        Character:FindFirstChildOfClass(
            "Humanoid"
        )

    local Root =
        Character:FindFirstChild(
            "HumanoidRootPart"
        )

    if not Humanoid
    or
    not Root then
        return
    end

    AutoBossAndWeight = true

    BossWeightStage = 0

    BossWeightTimerEnd = 0

    BossWeightTimerToken =
        BossWeightTimerToken + 1

    BossWeightSavedCFrame =
        Root.CFrame

    BossWeightStartNoclip()

    BossWeightStartFly()

    BossWeightConnectHealth()

    BossWeightStartLoop()

    BossWeightMove(
        BossWeightY
    )

    task.spawn(function()

        task.wait(0.15)

        if AutoBossAndWeight
        and BossWeightStage == 0 then

            BossWeightDoWeight()
        end
    end)
end

--==================================================
-- STOP BOSS & WEIGHT
--==================================================

local function StopBossWeight()

    AutoBossAndWeight = false

    BossWeightTimerToken =
        BossWeightTimerToken + 1

    BossWeightTimerEnd = 0

    BossWeightDisconnectHealth()

    BossWeightStopFly()

    BossWeightStopNoclip()

    BossWeightStage = 0

    local Character =
        Player.Character

    local Root =
        Character
        and
        Character:FindFirstChild(
            "HumanoidRootPart"
        )

    if Root
    and
    BossWeightSavedCFrame then

        Root.CFrame =
            BossWeightSavedCFrame
    end

    BossWeightSavedCFrame = nil
end

--==================================================
-- BOSS & WEIGHT BUTTON
--==================================================

BossWeightButton.MouseButton1Click:Connect(function()

    if AutoBossAndWeight then

        StopBossWeight()

        BossWeightButton.Text =
            T[CurrentLanguage].bossWeight ..
            ": " ..
            T[CurrentLanguage].off

        BossWeightButton.BackgroundColor3 =
            Color3.fromRGB(160, 55, 55)

    else

        StartBossWeight()

        if AutoBossAndWeight then

            BossWeightButton.Text =
                T[CurrentLanguage].bossWeight ..
                ": " ..
                T[CurrentLanguage].on

            BossWeightButton.BackgroundColor3 =
                Color3.fromRGB(45, 170, 70)
        end
    end
end)

--==================================================
-- AUTO DURABILITY
--==================================================

DurabilityButton.MouseButton1Click:Connect(function()

    AutoDurability =
        not AutoDurability

    if AutoDurability then

        DurabilityButton.Text =
            T[CurrentLanguage].durability ..
            ": " ..
            T[CurrentLanguage].on

        DurabilityButton.BackgroundColor3 =
            Color3.fromRGB(45, 170, 70)

        task.spawn(function()

            while AutoDurability do

                local Event =
                    GetMuscleEvent()

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
            T[CurrentLanguage].durability ..
            ": " ..
            T[CurrentLanguage].off

        DurabilityButton.BackgroundColor3 =
            Color3.fromRGB(160, 55, 55)
    end
end)

--==================================================
-- AUTO PUNCH
--==================================================

PunchButton.MouseButton1Click:Connect(function()

    AutoPunch =
        not AutoPunch

    if AutoPunch then

        PunchButton.Text =
            T[CurrentLanguage].punch ..
            ": " ..
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
            T[CurrentLanguage].punch ..
            ": " ..
            T[CurrentLanguage].off

        PunchButton.BackgroundColor3 =
            Color3.fromRGB(160, 55, 55)
    end
end)

--==================================================
-- KING ROCK
--==================================================

KingRockButton.MouseButton1Click:Connect(function()

    AutoKingRock =
        not AutoKingRock

    if AutoKingRock then

        KingRockButton.Text =
            T[CurrentLanguage].kingrock ..
            ": " ..
            T[CurrentLanguage].on

        KingRockButton.BackgroundColor3 =
            Color3.fromRGB(45, 170, 70)

        task.spawn(function()

            while AutoKingRock do

                local Character =
                    Player.Character

                local Root =
                    Character
                    and
                    Character:FindFirstChild(
                        "HumanoidRootPart"
                    )

                if Root then

                    Root.CFrame =
                        CFrame.new(
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
            T[CurrentLanguage].kingrock ..
            ": " ..
            T[CurrentLanguage].off

        KingRockButton.BackgroundColor3 =
            Color3.fromRGB(160, 55, 55)
    end
end)

--==================================================
-- LANGUAGE SELECTOR
--==================================================

local LanguageGui =
    Instance.new("ScreenGui")

LanguageGui.Name =
    "KIRILL_LANGUAGE"

LanguageGui.ResetOnSpawn =
    false

LanguageGui.Parent =
    PlayerGui

local LanguageFrame =
    Instance.new("Frame")

LanguageFrame.Size =
    UDim2.new(0, 300, 0, 190)

LanguageFrame.Position =
    UDim2.new(0.5, -150, 0.5, -95)

LanguageFrame.BackgroundColor3 =
    Color3.fromRGB(30, 30, 30)

LanguageFrame.BorderSizePixel = 0

LanguageFrame.Parent =
    LanguageGui

local LanguageCorner =
    Instance.new("UICorner")

LanguageCorner.CornerRadius =
    UDim.new(0, 12)

LanguageCorner.Parent =
    LanguageFrame

--==================================================
-- LANGUAGE TITLE
--==================================================

local LanguageTitle =
    Instance.new("TextLabel")

LanguageTitle.Size =
    UDim2.new(1, -20, 0, 45)

LanguageTitle.Position =
    UDim2.new(0, 10, 0, 10)

LanguageTitle.BackgroundTransparency = 1

LanguageTitle.TextColor3 =
    Color3.fromRGB(255, 255, 255)

LanguageTitle.Text =
    "🌐 Выберите язык / Choose language"

LanguageTitle.TextSize = 17

LanguageTitle.Font =
    Enum.Font.SourceSansBold

LanguageTitle.Parent =
    LanguageFrame

--==================================================
-- RUSSIAN
--==================================================

local RUButton =
    Instance.new("TextButton")

RUButton.Size =
    UDim2.new(1, -30, 0, 50)

RUButton.Position =
    UDim2.new(0, 15, 0, 65)

RUButton.BackgroundColor3 =
    Color3.fromRGB(55, 55, 55)

RUButton.TextColor3 =
    Color3.fromRGB(255, 255, 255)

RUButton.Text =
    "🇷🇺  Русский"

RUButton.TextSize = 20

RUButton.Font =
    Enum.Font.SourceSans

RUButton.Parent =
    LanguageFrame

local RUCorner =
    Instance.new("UICorner")

RUCorner.CornerRadius =
    UDim.new(0, 8)

RUCorner.Parent =
    RUButton

--==================================================
-- ENGLISH
--==================================================

local ENButton =
    Instance.new("TextButton")

ENButton.Size =
    UDim2.new(1, -30, 0, 50)

ENButton.Position =
    UDim2.new(0, 15, 0, 125)

ENButton.BackgroundColor3 =
    Color3.fromRGB(55, 55, 55)

ENButton.TextColor3 =
    Color3.fromRGB(255, 255, 255)

ENButton.Text =
    "🇬🇧  English"

ENButton.TextSize = 20

ENButton.Font =
    Enum.Font.SourceSans

ENButton.Parent =
    LanguageFrame

local ENCorner =
    Instance.new("UICorner")

ENCorner.CornerRadius =
    UDim.new(0, 8)

ENCorner.Parent =
    ENButton

--==================================================
-- APPLY LANGUAGE
--==================================================

local function ApplyLanguage()

    Title.Text =
        T[CurrentLanguage].title

    TrainButton.Text =
        T[CurrentLanguage].train ..
        ": " ..
        (
            AutoTrain
            and
            T[CurrentLanguage].on
            or
            T[CurrentLanguage].off
        )

    WeightButton.Text =
        T[CurrentLanguage].weight ..
        ": " ..
        (
            AutoWeight
            and
            T[CurrentLanguage].on
            or
            T[CurrentLanguage].off
        )

    RebirthButton.Text =
        T[CurrentLanguage].rebirth ..
        ": " ..
        (
            AutoRebirth
            and
            T[CurrentLanguage].on
            or
            T[CurrentLanguage].off
        )

    KingButton.Text =
        T[CurrentLanguage].king ..
        ": " ..
        (
            AutoKing
            and
            T[CurrentLanguage].on
            or
            T[CurrentLanguage].off
        )

    AFKButton.Text =
        T[CurrentLanguage].afk ..
        ": " ..
        (
            AntiAFK
            and
            T[CurrentLanguage].on
            or
            T[CurrentLanguage].off
        )

    BossButton.Text =
        T[CurrentLanguage].boss ..
        ": " ..
        (
            AutoBoss
            and
            T[CurrentLanguage].on
            or
            T[CurrentLanguage].off
        )

    BossSmall.Text =
        T[CurrentLanguage].bossSmall

    DurabilityButton.Text =
        T[CurrentLanguage].durability ..
        ": " ..
        (
            AutoDurability
            and
            T[CurrentLanguage].on
            or
            T[CurrentLanguage].off
        )

    PunchButton.Text =
        T[CurrentLanguage].punch ..
        ": " ..
        (
            AutoPunch
            and
            T[CurrentLanguage].on
            or
            T[CurrentLanguage].off
        )

    KingRockButton.Text =
        T[CurrentLanguage].kingrock ..
        ": " ..
        (
            AutoKingRock
            and
            T[CurrentLanguage].on
            or
            T[CurrentLanguage].off
        )

    BossWeightButton.Text =
        T[CurrentLanguage].bossWeight ..
        ": " ..
        (
            AutoBossAndWeight
            and
            T[CurrentLanguage].on
            or
            T[CurrentLanguage].off
        )
end

--==================================================
-- LANGUAGE -> OPEN PANEL
--==================================================

RUButton.MouseButton1Click:Connect(function()

    CurrentLanguage = "ru"

    ApplyLanguage()

    LanguageGui:Destroy()

    -- только теперь показываем панель
    MainFrame.Visible = true
    OpenButton.Visible = true
end)

ENButton.MouseButton1Click:Connect(function()

    CurrentLanguage = "en"

    ApplyLanguage()

    LanguageGui:Destroy()

    -- только теперь показываем панель
    MainFrame.Visible = true
    OpenButton.Visible = true
end)

--==================================================
-- START
--==================================================

MainFrame.Visible = false
OpenButton.Visible = false

print(
    "[KIRILL_PANEL NO KEY V1.6] Loaded"
)

print(
    "[KIRILL_PANEL] Сначала выбор языка"
)
