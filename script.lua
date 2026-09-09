--// KIRILL_PANEL NO KEY V1.55
--// БЕЗ АВТО-СУНДУКА

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

--==================================================
-- НАСТРОЙКИ
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

local RebirthTarget = 0
local RebirthDone = 0

local CurrentLanguage = "ru"

-- AUTO BOSS
local BossX = 7
local BossNormalY = 28
local BossDamageY = 4
local BossZ = -1300

-- Сохранённая позиция игрока
local BossSavedCFrame = nil

-- Для Noclip
local BossSavedCollision = {}

local BossNoclipConnection = nil
local BossFlyConnection = nil

local BossY = BossNormalY
local LastBossHealth = nil

--==================================================
-- УДАЛЯЕМ СТАРУЮ GUI
--==================================================

local OldGui = PlayerGui:FindFirstChild("KIRILL_PANEL_NO_KEY")

if OldGui then
    OldGui:Destroy()
end

--==================================================
-- ВЫБОР ЯЗЫКА
--==================================================

local LangGui = Instance.new("ScreenGui")
LangGui.Name = "KIRILL_LANGUAGE"
LangGui.ResetOnSpawn = false
LangGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
LangGui.Parent = PlayerGui

local LangFrame = Instance.new("Frame")
LangFrame.Size = UDim2.new(0,260,0,150)
LangFrame.Position = UDim2.new(0.5,-130,0.5,-75)
LangFrame.BackgroundColor3 = Color3.fromRGB(25,25,25)
LangFrame.BorderSizePixel = 0
LangFrame.Parent = LangGui

Instance.new("UICorner", LangFrame).CornerRadius = UDim.new(0,10)

local LangTitle = Instance.new("TextLabel")
LangTitle.Size = UDim2.new(1,0,0,45)
LangTitle.BackgroundTransparency = 1
LangTitle.Text = "Language / Язык"
LangTitle.TextColor3 = Color3.new(1,1,1)
LangTitle.TextSize = 20
LangTitle.Font = Enum.Font.GothamBlack
LangTitle.Parent = LangFrame

local EnglishBtn = Instance.new("TextButton")
EnglishBtn.Size = UDim2.new(0,210,0,38)
EnglishBtn.Position = UDim2.new(0.5,-105,0,55)
EnglishBtn.BackgroundColor3 = Color3.fromRGB(50,100,180)
EnglishBtn.TextColor3 = Color3.new(1,1,1)
EnglishBtn.Text = "English"
EnglishBtn.TextSize = 15
EnglishBtn.Font = Enum.Font.GothamBlack
EnglishBtn.BorderSizePixel = 0
EnglishBtn.Parent = LangFrame

Instance.new("UICorner", EnglishBtn).CornerRadius = UDim.new(0,6)

local RussianBtn = Instance.new("TextButton")
RussianBtn.Size = UDim2.new(0,210,0,38)
RussianBtn.Position = UDim2.new(0.5,-105,0,102)
RussianBtn.BackgroundColor3 = Color3.fromRGB(150,50,50)
RussianBtn.TextColor3 = Color3.new(1,1,1)
RussianBtn.Text = "Русский"
RussianBtn.TextSize = 15
RussianBtn.Font = Enum.Font.GothamBlack
RussianBtn.BorderSizePixel = 0
RussianBtn.Parent = LangFrame

Instance.new("UICorner", RussianBtn).CornerRadius = UDim.new(0,6)

local LanguageChosen = false

EnglishBtn.Activated:Connect(function()
    CurrentLanguage = "en"
    LanguageChosen = true
    LangGui:Destroy()
end)

RussianBtn.Activated:Connect(function()
    CurrentLanguage = "ru"
    LanguageChosen = true
    LangGui:Destroy()
end)

repeat
    task.wait()
until LanguageChosen

--==================================================
-- ТЕКСТЫ
--==================================================

local T = {
    ru = {
        title = "KIRILL_PANEL NO KEY V1.55",

        train = "💪 Авто-Прокачка",
        weight = "🏋️ Авто-Гантеля",
        rebirth = "🔄 Авто-Ребитхи",
        king = "👑 Тп-Кинг",
        afk = "🛡️ Анти-Афк",
        boss = "👹 Авто-Боссы",
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

local function L(Name)
    return T[CurrentLanguage][Name]
end

--==================================================
-- GUI
--==================================================

local Gui = Instance.new("ScreenGui")
Gui.Name = "KIRILL_PANEL_NO_KEY"
Gui.ResetOnSpawn = false
Gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Gui.Parent = PlayerGui

--==================================================
-- КНОПКА ОТКРЫТИЯ
--==================================================

local Open = Instance.new("TextButton")
Open.Size = UDim2.new(0,45,0,45)
Open.Position = UDim2.new(1,-65,0,10)
Open.BackgroundColor3 = Color3.fromRGB(30,30,30)
Open.TextColor3 = Color3.new(1,1,1)
Open.Text = "⚡"
Open.TextSize = 22
Open.Font = Enum.Font.GothamBlack
Open.BorderSizePixel = 0
Open.Parent = Gui

Instance.new("UICorner", Open).CornerRadius = UDim.new(1,0)

--==================================================
-- ПАНЕЛЬ
--==================================================

local Panel = Instance.new("Frame")
Panel.Size = UDim2.new(0,230,0,280)
Panel.Position = UDim2.new(0.5,-115,0.5,-140)
Panel.BackgroundColor3 = Color3.fromRGB(25,25,25)
Panel.BorderSizePixel = 0
Panel.Visible = false
Panel.Parent = Gui

Instance.new("UICorner", Panel).CornerRadius = UDim.new(0,10)

--==================================================
-- TITLE
--==================================================

local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1,0,0,35)
TitleBar.BackgroundColor3 = Color3.fromRGB(35,35,35)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = Panel

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1,-40,1,0)
Title.Position = UDim2.new(0,10,0,0)
Title.BackgroundTransparency = 1
Title.Text = L("title")
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

--==================================================
-- ПЕРЕТАСКИВАНИЕ
--==================================================

local Dragging = false
local DragStart = nil
local StartPos = nil

TitleBar.InputBegan:Connect(function(Input)

    if Input.UserInputType == Enum.UserInputType.MouseButton1
    or Input.UserInputType == Enum.UserInputType.Touch then

        Dragging = true
        DragStart = Input.Position
        StartPos = Panel.Position

    end

end)

TitleBar.InputEnded:Connect(function(Input)

    if Input.UserInputType == Enum.UserInputType.MouseButton1
    or Input.UserInputType == Enum.UserInputType.Touch then

        Dragging = false

    end

end)

UserInputService.InputChanged:Connect(function(Input)

    if not Dragging then
        return
    end

    if Input.UserInputType == Enum.UserInputType.MouseMovement
    or Input.UserInputType == Enum.UserInputType.Touch then

        local Delta =
            Input.Position - DragStart

        Panel.Position = UDim2.new(
            StartPos.X.Scale,
            StartPos.X.Offset + Delta.X,
            StartPos.Y.Scale,
            StartPos.Y.Offset + Delta.Y
        )

    end

end)

--==================================================
-- SCROLL
--==================================================

local Scroll = Instance.new("ScrollingFrame")
Scroll.Size = UDim2.new(1,-10,1,-40)
Scroll.Position = UDim2.new(0,5,0,40)
Scroll.BackgroundTransparency = 1
Scroll.BorderSizePixel = 0
Scroll.CanvasSize = UDim2.new(0,0,0,390)
Scroll.ScrollBarThickness = 4
Scroll.ScrollingDirection = Enum.ScrollingDirection.Y
Scroll.Parent = Panel

--==================================================
-- СОЗДАНИЕ КНОПОК
--==================================================

local function CreateButton(Text, Y)

    local Btn = Instance.new("TextButton")

    Btn.Size = UDim2.new(1,-10,0,40)
    Btn.Position = UDim2.new(0,5,0,Y)

    Btn.BackgroundColor3 =
        Color3.fromRGB(150,50,50)

    Btn.TextColor3 =
        Color3.new(1,1,1)

    Btn.Text = Text
    Btn.TextSize = 12
    Btn.Font = Enum.Font.GothamBlack

    Btn.BorderSizePixel = 0
    Btn.Parent = Scroll

    Instance.new("UICorner", Btn)
        .CornerRadius = UDim.new(0,6)

    return Btn

end

local TrainBtn =
    CreateButton(
        L("train") .. ": " .. L("off"),
        2
    )

local WeightBtn =
    CreateButton(
        L("weight") .. ": " .. L("off"),
        46
    )

local RebirthBtn =
    CreateButton(
        L("rebirth") .. ": " .. L("off"),
        90
    )

local KingBtn =
    CreateButton(
        L("king") .. ": " .. L("off"),
        134
    )

local AFKBtn =
    CreateButton(
        L("afk") .. ": " .. L("off"),
        178
    )

local BossBtn =
    CreateButton(
        L("boss") .. ": " .. L("off"),
        222
    )

local DurBtn =
    CreateButton(
        L("durability") .. ": " .. L("off"),
        266
    )

local PunchBtn =
    CreateButton(
        L("punch") .. ": " .. L("off"),
        310
    )

local KingRockBtn =
    CreateButton(
        L("kingrock") .. ": " .. L("off"),
        354
    )

-- маленький текст AutoBoss
local BossSmall = Instance.new("TextLabel")
BossSmall.Size = UDim2.new(0,95,0,15)
BossSmall.Position = UDim2.new(1,-100,0,225)
BossSmall.BackgroundTransparency = 1
BossSmall.Text = L("bossSmall")
BossSmall.TextColor3 = Color3.fromRGB(210,210,210)
BossSmall.TextSize = 7
BossSmall.Font = Enum.Font.Gotham
BossSmall.TextXAlignment = Enum.TextXAlignment.Right
BossSmall.ZIndex = 5
BossSmall.Parent = Scroll

--==================================================
-- SET BUTTON
--==================================================

local function SetBtn(Btn, Text, On)

    if On then

        Btn.Text =
            Text .. ": " .. L("on")

        Btn.BackgroundColor3 =
            Color3.fromRGB(50,160,70)

    else

        Btn.Text =
            Text .. ": " .. L("off")

        Btn.BackgroundColor3 =
            Color3.fromRGB(150,50,50)

    end

end

--==================================================
-- OPEN / CLOSE
--==================================================

Open.Activated:Connect(function()

    Panel.Visible = true
    Open.Visible = false

end)

Close.Activated:Connect(function()

    Panel.Visible = false
    Open.Visible = true

end)

--==================================================
-- MUSCLE EVENT
--==================================================

local function GetMuscleEvent()

    local Event =
        Player:FindFirstChild("muscleEvent")

    if Event then
        return Event
    end

    local Events =
        ReplicatedStorage:FindFirstChild("events")

    if Events then

        Event =
            Events:FindFirstChild(
                "muscleEvent"
            )

        if Event then
            return Event
        end

    end

    Event =
        ReplicatedStorage:FindFirstChild(
            "muscleEvent"
        )

    return Event

end

--==================================================
-- PUNCH
--==================================================

local function GetPunch()

    local Character =
        Player.Character

    if Character then

        local Punch =
            Character:FindFirstChild("Punch")

        if Punch then
            return Punch
        end

    end

    local Backpack =
        Player:FindFirstChild("Backpack")

    if Backpack then
        return Backpack:FindFirstChild("Punch")
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

    local Punch =
        GetPunch()

    if Punch and Humanoid then

        if Punch.Parent ~= Character then

            Humanoid:EquipTool(Punch)

        end

        Punch:Activate()

        local MuscleEvent =
            GetMuscleEvent()

        if MuscleEvent then

            pcall(function()

                MuscleEvent:FireServer(
                    "punch",
                    "leftHand"
                )

            end)

            pcall(function()

                MuscleEvent:FireServer(
                    "punch",
                    "rightHand"
                )

            end)

        end

    end

end

--==================================================
-- AUTO TRAIN
--==================================================

TrainBtn.Activated:Connect(function()

    AutoTrain = not AutoTrain

    SetBtn(
        TrainBtn,
        L("train"),
        AutoTrain
    )

end)

task.spawn(function()

    while task.wait(0.1) do

        if AutoTrain then

            pcall(function()

                local MuscleEvent =
                    GetMuscleEvent()

                if MuscleEvent then

                    MuscleEvent:FireServer(
                        "rep"
                    )

                end

            end)

        end

    end

end)

--==================================================
-- AUTO WEIGHT
--==================================================

WeightBtn.Activated:Connect(function()

    AutoWeight = not AutoWeight

    SetBtn(
        WeightBtn,
        L("weight"),
        AutoWeight
    )

end)

task.spawn(function()

    while task.wait(0.001) do

        if AutoWeight then

            pcall(function()

                local Character =
                    Player.Character

                if not Character then
                    return
                end

                local Humanoid =
                    Character:FindFirstChildOfClass(
                        "Humanoid"
                    )

                local Backpack =
                    Player:FindFirstChild(
                        "Backpack"
                    )

                local Weight = nil

                if Backpack then

                    Weight =
                        Backpack:FindFirstChild(
                            "Weight"
                        )

                end

                if not Weight then

                    Weight =
                        Character:FindFirstChild(
                            "Weight"
                        )

                end

                if Weight and Humanoid then

                    if Weight.Parent ~= Character then

                        Humanoid:EquipTool(
                            Weight
                        )

                    end

                    Weight:Activate()

                    local MuscleEvent =
                        GetMuscleEvent()

                    if MuscleEvent then

                        MuscleEvent:FireServer(
                            "rep"
                        )

                    end

                end

            end)

        end

    end

end)

--==================================================
-- АВТО РЕБИТХИ
--==================================================

local function ShowRebirthPrompt()

    local PromptGui =
        Instance.new("ScreenGui")

    PromptGui.Name =
        "RebirthPrompt"

    PromptGui.ResetOnSpawn = false

    PromptGui.ZIndexBehavior =
        Enum.ZIndexBehavior.Global

    PromptGui.Parent = PlayerGui

    local Frame =
        Instance.new("Frame")

    Frame.Size =
        UDim2.new(0,320,0,190)

    Frame.Position =
        UDim2.new(0.5,-160,0.5,-95)

    Frame.BackgroundColor3 =
        Color3.fromRGB(25,25,25)

    Frame.BorderSizePixel = 0
    Frame.Parent = PromptGui

    Instance.new("UICorner",Frame)
        .CornerRadius = UDim.new(0,10)

    local Question =
        Instance.new("TextLabel")

    Question.Size =
        UDim2.new(1,-20,0,50)

    Question.Position =
        UDim2.new(0,10,0,10)

    Question.BackgroundTransparency = 1

    Question.Text =
        L("rebirthQuestion")

    Question.TextColor3 =
        Color3.new(1,1,1)

    Question.TextSize = 16
    Question.Font =
        Enum.Font.GothamBlack

    Question.TextWrapped = true
    Question.Parent = Frame

    local Info =
        Instance.new("TextLabel")

    Info.Size =
        UDim2.new(1,-20,0,30)

    Info.Position =
        UDim2.new(0,10,0,58)

    Info.BackgroundTransparency = 1

    Info.Text =
        L("rebirthInfo")

    Info.TextColor3 =
        Color3.fromRGB(180,180,180)

    Info.TextSize = 12
    Info.Font = Enum.Font.Gotham
    Info.Parent = Frame

    local Input =
        Instance.new("TextBox")

    Input.Size =
        UDim2.new(0,250,0,35)

    Input.Position =
        UDim2.new(0.5,-125,0,95)

    Input.BackgroundColor3 =
        Color3.fromRGB(45,45,45)

    Input.TextColor3 =
        Color3.new(1,1,1)

    Input.PlaceholderText = "0"
    Input.Text = ""
    Input.TextSize = 16
    Input.Font = Enum.Font.GothamBold

    Input.ClearTextOnFocus = false
    Input.Parent = Frame

    Instance.new("UICorner",Input)
        .CornerRadius = UDim.new(0,6)

    local OK =
        Instance.new("TextButton")

    OK.Size =
        UDim2.new(0,100,0,35)

    OK.Position =
        UDim2.new(0.5,-50,0,145)

    OK.BackgroundColor3 =
        Color3.fromRGB(50,160,70)

    OK.TextColor3 =
        Color3.new(1,1,1)

    OK.Text =
        L("ok")

    OK.TextSize = 14
    OK.Font =
        Enum.Font.GothamBlack

    OK.Parent = Frame

    Instance.new("UICorner",OK)
        .CornerRadius = UDim.new(0,6)

    OK.Activated:Connect(function()

        local Number =
            tonumber(Input.Text)

        if not Number then
            Number = 0
        end

        Number =
            math.floor(Number)

        if Number < 0 then
            Number = 0
        end

        RebirthTarget = Number
        RebirthDone = 0
        AutoRebirth = true

        SetBtn(
            RebirthBtn,
            L("rebirth"),
            true
        )

        PromptGui:Destroy()

    end)

end

RebirthBtn.Activated:Connect(function()

    if AutoRebirth then

        AutoRebirth = false

        SetBtn(
            RebirthBtn,
            L("rebirth"),
            false
        )

    else

        ShowRebirthPrompt()

    end

end)

task.spawn(function()

    while task.wait(0.08) do

        if AutoRebirth then

            if RebirthTarget > 0
            and RebirthDone >= RebirthTarget then

                AutoRebirth = false

                SetBtn(
                    RebirthBtn,
                    L("rebirth"),
                    false
                )

            else

                pcall(function()

                    local rEvents =
                        ReplicatedStorage:FindFirstChild(
                            "rEvents"
                        )

                    local Remote =
                        rEvents
                        and rEvents:FindFirstChild(
                            "rebirthRemote"
                        )

                    if Remote then

                        Remote:InvokeServer(
                            "rebirthRequest"
                        )

                        if RebirthTarget > 0 then

                            RebirthDone += 1

                        end

                    end

                end)

            end

        end

    end

end)

--==================================================
-- TP KING
--==================================================

KingBtn.Activated:Connect(function()

    AutoKing = not AutoKing

    SetBtn(
        KingBtn,
        L("king"),
        AutoKing
    )

end)

task.spawn(function()

    while task.wait(0.001) do

        if AutoKing then

            pcall(function()

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
                        -8744.821,
                        121.183,
                        -5859.323
                    )

            end)

        end

    end

end)

--==================================================
-- ANTI AFK
--==================================================

AFKBtn.Activated:Connect(function()

    AntiAFK = not AntiAFK

    SetBtn(
        AFKBtn,
        L("afk"),
        AntiAFK
    )

end)

task.spawn(function()

    while task.wait(900) do

        if AntiAFK then

            pcall(function()

                VirtualUser:CaptureController()

                VirtualUser:ClickButton2(
                    Vector2.new(0,0)
                )

            end)

        end

    end

end)

--==================================================
-- AUTO BOSS NOCLIP
--==================================================

local function StartBossNoclip()

    if BossNoclipConnection then

        BossNoclipConnection:Disconnect()

    end

    BossSavedCollision = {}

    local Character =
        Player.Character

    if Character then

        for _,Object in
            ipairs(
                Character:GetDescendants()
            ) do

            if Object:IsA("BasePart") then

                BossSavedCollision[Object] =
                    Object.CanCollide

                Object.CanCollide = false

            end

        end

    end

    BossNoclipConnection =
        RunService.Stepped:Connect(
            function()

                if not AutoBoss then
                    return
                end

                local Character =
                    Player.Character

                if not Character then
                    return
                end

                for _,Object in
                    ipairs(
                        Character:GetDescendants()
                    ) do

                    if Object:IsA("BasePart") then

                        Object.CanCollide =
                            false

                    end

                end

            end
        )

end

--==================================================
-- STOP NOCLIP
--==================================================

local function StopBossNoclip()

    if BossNoclipConnection then

        BossNoclipConnection:Disconnect()

        BossNoclipConnection = nil

    end

    local Character =
        Player.Character

    if Character then

        for _,Object in
            ipairs(
                Character:GetDescendants()
            ) do

            if Object:IsA("BasePart") then

                if BossSavedCollision[Object]
                ~= nil then

                    Object.CanCollide =
                        BossSavedCollision[Object]

                end

            end

        end

    end

    BossSavedCollision = {}

end

--==================================================
-- AUTO BOSS FLY
--==================================================

local function StartBossFly()

    if BossFlyConnection then

        BossFlyConnection:Disconnect()

    end

    BossFlyConnection =
        RunService.Heartbeat:Connect(
            function()

                if not AutoBoss then
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
                        BossX,
                        BossY,
                        BossZ
                    ) *
                    CFrame.Angles(
                        0,
                        math.rad(180),
                        0
                    )

                Root.AssemblyLinearVelocity =
                    Vector3.new(0,0,0)

                Root.AssemblyAngularVelocity =
                    Vector3.new(0,0,0)

            end
        )

end

--==================================================
-- STOP FLY
--==================================================

local function StopBossFly()

    if BossFlyConnection then

        BossFlyConnection:Disconnect()

        BossFlyConnection = nil

    end

end

--==================================================
-- AUTO BOSS
--==================================================

BossBtn.Activated:Connect(function()

    AutoBoss = not AutoBoss

    SetBtn(
        BossBtn,
        L("boss"),
        AutoBoss
    )

    --==============================================
    -- ВКЛЮЧЕНИЕ
    --==============================================

    if AutoBoss then

        local Character =
            Player.Character

        -- СОХРАНЯЕМ КООРДИНАТЫ
        if Character then

            local Root =
                Character:FindFirstChild(
                    "HumanoidRootPart"
                )

            if Root then

                BossSavedCFrame =
                    Root.CFrame

            end

        end

        -- Начальная высота
        BossY = BossNormalY

        -- Запоминаем HP
        local Humanoid =
            Character
            and Character:FindFirstChildOfClass(
                "Humanoid"
            )

        if Humanoid then

            LastBossHealth =
                Humanoid.Health

        else

            LastBossHealth = nil

        end

        -- Включаем Noclip
        StartBossNoclip()

        -- Включаем Fly
        StartBossFly()

        -- ТП к боссу
        pcall(function()

            if Character then

                local Root =
                    Character:FindFirstChild(
                        "HumanoidRootPart"
                    )

                if Root then

                    Root.CFrame =
                        CFrame.new(
                            BossX,
                            BossNormalY,
                            BossZ
                        ) *
                        CFrame.Angles(
                            0,
                            math.rad(180),
                            0
                        )

                end

            end

        end)

    --==============================================
    -- ВЫКЛЮЧЕНИЕ
    --==============================================

    else

        -- Выключаем Fly
        StopBossFly()

        -- Выключаем Noclip
        StopBossNoclip()

        -- Возвращаем сохранённые координаты
        if BossSavedCFrame then

            pcall(function()

                local Character =
                    Player.Character

                if Character then

                    local Root =
                        Character:FindFirstChild(
                            "HumanoidRootPart"
                        )

                    if Root then

                        Root.CFrame =
                            BossSavedCFrame

                    end

                end

            end)

        end

        BossSavedCFrame = nil

        BossY = BossNormalY

        LastBossHealth = nil

    end

end)

--==================================================
-- AUTO BOSS LOOP
--==================================================

task.spawn(function()

    while task.wait(0.01) do

        if AutoBoss then

            pcall(function()

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
                or not Root then

                    return

                end

                --==================================
                -- ПРОВЕРКА УРОНА
                --==================================

                local Health =
                    Humanoid.Health

                if LastBossHealth
                and Health < LastBossHealth then

                    -- Сначала опускаемся
                    Root.AssemblyLinearVelocity =
                        Vector3.new(
                            0,
                            -100,
                            0
                        )

                    task.wait(0.05)

                    -- Потом Y=4
                    BossY =
                        BossDamageY

                    Root.CFrame =
                        CFrame.new(
                            BossX,
                            BossDamageY,
                            BossZ
                        ) *
                        CFrame.Angles(
                            0,
                            math.rad(180),
                            0
                        )

                end

                LastBossHealth =
                    Health

                --==================================
                -- АТАКА
                --==================================

                DoPunch()

            end)

        end

    end

end)

--==================================================
-- AUTO DURABILITY
--==================================================

DurBtn.Activated:Connect(function()

    AutoDurability = not AutoDurability

    SetBtn(
        DurBtn,
        L("durability"),
        AutoDurability
    )

end)

task.spawn(function()

    while task.wait(0.12) do

        if AutoDurability then

            pcall(function()

                local Character =
                    Player.Character

                if not Character then
                    return
                end

                local Humanoid =
                    Character:FindFirstChildOfClass(
                        "Humanoid"
                    )

                local Backpack =
                    Player:FindFirstChild(
                        "Backpack"
                    )

                local Punch = nil

                if Backpack then

                    Punch =
                        Backpack:FindFirstChild(
                            "Punch"
                        )

                end

                if not Punch then

                    Punch =
                        Character:FindFirstChild(
                            "Punch"
                        )

                end

                if Punch and Humanoid then

                    if Punch.Parent ~= Character then

                        Humanoid:EquipTool(
                            Punch
                        )

                        task.wait(0.1)

                    end

                    local Durability =
                        Player:FindFirstChild(
                            "Durability"
                        )

                    if not Durability then
                        return
                    end

                    local CurrentDurability =
                        tonumber(
                            Durability.Value
                        ) or 0

                    local MachinesFolder =
                        workspace:FindFirstChild(
                            "machinesFolder"
                        )

                    if MachinesFolder then

                        local BestRock = nil
                        local BestRequired = -1

                        for _,Machine in
                            ipairs(
                                MachinesFolder:GetChildren()
                            ) do

                            local Rock =
                                Machine:FindFirstChild(
                                    "Rock"
                                )

                            if Rock
                            and Rock:IsA("BasePart") then

                                local Needed =
                                    Machine:FindFirstChild(
                                        "neededDurability"
                                    )

                                local Required = nil

                                if Needed then

                                    Required =
                                        tonumber(
                                            Needed.Value
                                        )

                                end

                                if not Required then

                                    Needed =
                                        Rock:FindFirstChild(
                                            "neededDurability"
                                        )

                                    if Needed then

                                        Required =
                                            tonumber(
                                                Needed.Value
                                            )

                                    end

                                end

                                if Required
                                and Required <= CurrentDurability
                                and Required > BestRequired then

                                    BestRequired =
                                        Required

                                    BestRock =
                                        Rock

                                end

                            end

                        end

                        if BestRock then

                            local Root =
                                Character:FindFirstChild(
                                    "HumanoidRootPart"
                                )

                            if Root then

                                local Distance =
                                    math.max(
                                        BestRock.Size.Z / 2 + 2,
                                        4
                                    )

                                local Position =
                                    BestRock.Position
                                    -
                                    BestRock.CFrame.LookVector
                                    *
                                    Distance

                                Root.CFrame =
                                    CFrame.lookAt(
                                        Position,
                                        BestRock.Position
                                    )

                            end

                            Punch:Activate()

                            local MuscleEvent =
                                GetMuscleEvent()

                            if MuscleEvent then

                                MuscleEvent:FireServer(
                                    "punch",
                                    "leftHand"
                                )

                                task.wait(0.06)

                                MuscleEvent:FireServer(
                                    "punch",
                                    "rightHand"
                                )

                            end

                        end

                    end

                end

            end)

        end

    end

end)

--==================================================
-- AUTO PUNCH
--==================================================

PunchBtn.Activated:Connect(function()

    AutoPunch = not AutoPunch

    SetBtn(
        PunchBtn,
        L("punch"),
        AutoPunch
    )

end)

task.spawn(function()

    while task.wait(0.01) do

        if AutoPunch then

            pcall(function()

                DoPunch()

            end)

        end

    end

end)

--==================================================
-- AUTO KING ROCK
--==================================================

KingRockBtn.Activated:Connect(function()

    AutoKingRock = not AutoKingRock

    SetBtn(
        KingRockBtn,
        L("kingrock"),
        AutoKingRock
    )

end)

task.spawn(function()

    while task.wait(0.15) do

        if AutoKingRock then

            pcall(function()

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
                        -8928.078,
                        13.199,
                        -6004.433
                    )

                task.wait(0.1)

                DoPunch()

            end)

        end

    end

end)

--==================================================
-- ГОТОВО
--==================================================

print(
    "⚡ KIRILL_PANEL NO KEY V1.55 LOADED - NO AUTO CHEST"
)
