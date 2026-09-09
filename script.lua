--// KIRILL_PANEL NO KEY V1.55

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

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
local RebirthTarget = 0
local RebirthStart = 0

--// AUTO BOSS
local BossX = 7
local BossYNormal = 28
local BossYDamage = 4
local BossZ = -1300

local BossFlyConnection = nil
local BossNoclipConnection = nil
local BossPositionConnection = nil

local OldCollision = {}
local OldHumanoidStates = {}

--// УДАЛЯЕМ СТАРУЮ ПАНЕЛЬ

if PlayerGui:FindFirstChild("KIRILL_PANEL_NO_KEY") then
    PlayerGui.KIRILL_PANEL_NO_KEY:Destroy()
end

if PlayerGui:FindFirstChild("KIRILL_LANGUAGE_SELECT") then
    PlayerGui.KIRILL_LANGUAGE_SELECT:Destroy()
end

--// ВЫБОР ЯЗЫКА

local Language = nil

local LanguageGui = Instance.new("ScreenGui")
LanguageGui.Name = "KIRILL_LANGUAGE_SELECT"
LanguageGui.ResetOnSpawn = false
LanguageGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
LanguageGui.Parent = PlayerGui

local LanguageFrame = Instance.new("Frame")
LanguageFrame.Size = UDim2.new(0,300,0,190)
LanguageFrame.Position = UDim2.new(0.5,-150,0.5,-95)
LanguageFrame.BackgroundColor3 = Color3.fromRGB(25,25,25)
LanguageFrame.BorderSizePixel = 0
LanguageFrame.Parent = LanguageGui

Instance.new("UICorner", LanguageFrame).CornerRadius = UDim.new(0,10)

local LanguageTitle = Instance.new("TextLabel")
LanguageTitle.Size = UDim2.new(1,0,0,50)
LanguageTitle.BackgroundTransparency = 1
LanguageTitle.Text = "Select language / Выберите язык"
LanguageTitle.TextColor3 = Color3.new(1,1,1)
LanguageTitle.TextSize = 15
LanguageTitle.Font = Enum.Font.GothamBlack
LanguageTitle.Parent = LanguageFrame

local EnglishButton = Instance.new("TextButton")
EnglishButton.Size = UDim2.new(1,-30,0,45)
EnglishButton.Position = UDim2.new(0,15,0,60)
EnglishButton.BackgroundColor3 = Color3.fromRGB(50,110,180)
EnglishButton.Text = "English"
EnglishButton.TextColor3 = Color3.new(1,1,1)
EnglishButton.TextSize = 14
EnglishButton.Font = Enum.Font.GothamBlack
EnglishButton.BorderSizePixel = 0
EnglishButton.Parent = LanguageFrame

Instance.new("UICorner", EnglishButton).CornerRadius = UDim.new(0,7)

local RussianButton = Instance.new("TextButton")
RussianButton.Size = UDim2.new(1,-30,0,45)
RussianButton.Position = UDim2.new(0,15,0,120)
RussianButton.BackgroundColor3 = Color3.fromRGB(150,50,50)
RussianButton.Text = "Русский"
RussianButton.TextColor3 = Color3.new(1,1,1)
RussianButton.TextSize = 14
RussianButton.Font = Enum.Font.GothamBlack
RussianButton.BorderSizePixel = 0
RussianButton.Parent = LanguageFrame

Instance.new("UICorner", RussianButton).CornerRadius = UDim.new(0,7)

EnglishButton.Activated:Connect(function()
    Language = "English"
    LanguageGui:Destroy()
end)

RussianButton.Activated:Connect(function()
    Language = "Русский"
    LanguageGui:Destroy()
end)

repeat
    task.wait()
until Language ~= nil

--// ПЕРЕВОД

local T = {}

if Language == "English" then

    T.Train = "💪 Auto-Train"
    T.Weight = "🏋️ Auto-Weight"
    T.Rebirth = "🔄 Auto-Rebirths"
    T.King = "👑 TP-King"
    T.AFK = "🛡️ Anti-AFK"
    T.Boss = "👹 Auto-Bosses"
    T.Durability = "🥊 Auto-Durability"
    T.Punch = "⚡ Auto-Punch"
    T.KingRock = "🗿 King-Rock"

    T.On = "ON"
    T.Off = "OFF"

    T.RebirthQuestion = "How many rebirths do you want to make?"
    T.RebirthInfinite = "Number 0 means infinite"
    T.OK = "OK"
    T.Cancel = "Cancel"

else

    T.Train = "💪 Авто-Прокачка"
    T.Weight = "🏋️ Авто-Гантеля"
    T.Rebirth = "🔄 Авто-Ребитхи"
    T.King = "👑 Тп-Кинг"
    T.AFK = "🛡️ Анти-Афк"
    T.Boss = "👹 Авто-Боссы"
    T.Durability = "🥊 Авто-Дурабилити"
    T.Punch = "⚡ Авто-Удары"
    T.KingRock = "🗿 Кинг-Камень"

    T.On = "ВКЛ"
    T.Off = "ВЫКЛ"

    T.RebirthQuestion = "Сколько ты хочешь сделать ребитхов?"
    T.RebirthInfinite = "Цифра 0 это бесконечно"
    T.OK = "OK"
    T.Cancel = "Отмена"

end

--// GUI

local Gui = Instance.new("ScreenGui")
Gui.Name = "KIRILL_PANEL_NO_KEY"
Gui.ResetOnSpawn = false
Gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Gui.Parent = PlayerGui

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
Title.Text = "KIRILL_PANEL NO KEY V1.55"
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

--// DRAG

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

        local Delta = Input.Position - DragStart

        Panel.Position = UDim2.new(
            StartPos.X.Scale,
            StartPos.X.Offset + Delta.X,
            StartPos.Y.Scale,
            StartPos.Y.Offset + Delta.Y
        )

    end

end)

--// SCROLL

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
    Btn.Text = Text .. ": " .. T.Off
    Btn.TextSize = 12
    Btn.Font = Enum.Font.GothamBlack
    Btn.BorderSizePixel = 0
    Btn.Parent = Scroll

    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0,6)

    return Btn

end

local TrainBtn = CreateButton(T.Train,2)
local WeightBtn = CreateButton(T.Weight,46)
local RebirthBtn = CreateButton(T.Rebirth,90)
local KingBtn = CreateButton(T.King,134)
local AFKBtn = CreateButton(T.AFK,178)

--// AUTO BOSS BUTTON
local BossBtn = Instance.new("TextButton")
BossBtn.Size = UDim2.new(1,-10,0,40)
BossBtn.Position = UDim2.new(0,5,0,222)
BossBtn.BackgroundColor3 = Color3.fromRGB(150,50,50)
BossBtn.TextColor3 = Color3.new(1,1,1)
BossBtn.Text = T.Boss .. ": " .. T.Off
BossBtn.TextSize = 12
BossBtn.Font = Enum.Font.GothamBlack
BossBtn.BorderSizePixel = 0
BossBtn.Parent = Scroll

Instance.new("UICorner", BossBtn).CornerRadius = UDim.new(0,6)

local BossSmallText = Instance.new("TextLabel")
BossSmallText.Size = UDim2.new(1,0,0,12)
BossSmallText.Position = UDim2.new(0,0,1,-14)
BossSmallText.BackgroundTransparency = 1
BossSmallText.Text = "[ТОЛЬКО РАЗМЕР 12]"
BossSmallText.TextColor3 = Color3.fromRGB(190,190,190)
BossSmallText.TextSize = 7
BossSmallText.Font = Enum.Font.Gotham
BossSmallText.Parent = BossBtn

local DurBtn = CreateButton(T.Durability,266)
local AutoPunchBtn = CreateButton(T.Punch,310)
local KingRockBtn = CreateButton(T.KingRock,354)

local function SetBtn(Btn, Text, On)

    if On then

        Btn.Text = Text .. ": " .. T.On
        Btn.BackgroundColor3 = Color3.fromRGB(50,160,70)

    else

        Btn.Text = Text .. ": " .. T.Off
        Btn.BackgroundColor3 = Color3.fromRGB(150,50,50)

    end

end

local function SetBossBtn(On)

    if On then

        BossBtn.Text = T.Boss .. ": " .. T.On

        BossBtn.BackgroundColor3 =
            Color3.fromRGB(50,160,70)

    else

        BossBtn.Text = T.Boss .. ": " .. T.Off

        BossBtn.BackgroundColor3 =
            Color3.fromRGB(150,50,50)

    end

end

SetBossBtn(false)

Open.Activated:Connect(function()

    Panel.Visible = true
    Open.Visible = false

end)

Close.Activated:Connect(function()

    Panel.Visible = false
    Open.Visible = true

end)

--// PUNCH

local function GetPunch()

    local Character = Player.Character

    if Character then

        local Punch = Character:FindFirstChild("Punch")

        if Punch then
            return Punch
        end

    end

    local Backpack = Player:FindFirstChild("Backpack")

    if Backpack then

        local Punch = Backpack:FindFirstChild("Punch")

        if Punch then
            return Punch
        end

    end

    return nil

end

local function GetMuscleEvent()

    local Event = Player:FindFirstChild("muscleEvent")

    if Event then
        return Event
    end

    Event = ReplicatedStorage:FindFirstChild("muscleEvent")

    if Event then
        return Event
    end

    local Events = ReplicatedStorage:FindFirstChild("events")

    if Events then

        Event = Events:FindFirstChild("muscleEvent")

        if Event then
            return Event
        end

    end

    return nil

end

local function DoPunch()

    local Character = Player.Character

    if not Character then
        return
    end

    local Humanoid =
        Character:FindFirstChildOfClass("Humanoid")

    local Punch = GetPunch()

    if not Punch or not Humanoid then
        return
    end

    if Punch.Parent ~= Character then

        pcall(function()
            Humanoid:EquipTool(Punch)
        end)

        task.wait(0.001)

    end

    pcall(function()
        Punch:Activate()
    end)

    local MuscleEvent = GetMuscleEvent()

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

--// АВТО-ПРОКАЧКА
--// НЕ МЕНЯЛАСЬ

TrainBtn.Activated:Connect(function()

    AutoTrain = not AutoTrain

    SetBtn(
        TrainBtn,
        T.Train,
        AutoTrain
    )

end)

task.spawn(function()

    while task.wait(0.1) do

        if AutoTrain then

            pcall(function()

                local MuscleEvent = GetMuscleEvent()

                if MuscleEvent then
                    MuscleEvent:FireServer("rep")
                end

            end)

        end

    end

end)

--// АВТО-ГАНТЕЛЯ
--// 0.001

WeightBtn.Activated:Connect(function()

    AutoWeight = not AutoWeight

    SetBtn(
        WeightBtn,
        T.Weight,
        AutoWeight
    )

end)

task.spawn(function()

    while task.wait(0.001) do

        if AutoWeight then

            pcall(function()

                local Character = Player.Character

                if not Character then
                    return
                end

                local Humanoid =
                    Character:FindFirstChildOfClass("Humanoid")

                local Backpack =
                    Player:FindFirstChild("Backpack")

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

                    end

                    Weight:Activate()

                    local MuscleEvent =
                        GetMuscleEvent()

                    if MuscleEvent then

                        MuscleEvent:FireServer("rep")

                    end

                end

            end)

        end

    end

end)

--// РЕБИТХИ

local RebirthFrame = Instance.new("Frame")
RebirthFrame.Size = UDim2.new(0,300,0,230)
RebirthFrame.Position = UDim2.new(0.5,-150,0.5,-115)
RebirthFrame.BackgroundColor3 = Color3.fromRGB(25,25,25)
RebirthFrame.BorderSizePixel = 0
RebirthFrame.Visible = false
RebirthFrame.ZIndex = 20
RebirthFrame.Parent = Gui

Instance.new("UICorner", RebirthFrame).CornerRadius = UDim.new(0,10)

local RebirthTitle = Instance.new("TextLabel")
RebirthTitle.Size = UDim2.new(1,-20,0,55)
RebirthTitle.Position = UDim2.new(0,10,0,10)
RebirthTitle.BackgroundTransparency = 1
RebirthTitle.Text = T.RebirthQuestion
RebirthTitle.TextColor3 = Color3.new(1,1,1)
RebirthTitle.TextSize = 15
RebirthTitle.Font = Enum.Font.GothamBlack
RebirthTitle.TextWrapped = true
RebirthTitle.ZIndex = 21
RebirthTitle.Parent = RebirthFrame

local RebirthInfo = Instance.new("TextLabel")
RebirthInfo.Size = UDim2.new(1,-20,0,30)
RebirthInfo.Position = UDim2.new(0,10,0,65)
RebirthInfo.BackgroundTransparency = 1
RebirthInfo.Text = T.RebirthInfinite
RebirthInfo.TextColor3 = Color3.fromRGB(190,190,190)
RebirthInfo.TextSize = 12
RebirthInfo.Font = Enum.Font.Gotham
RebirthInfo.ZIndex = 21
RebirthInfo.Parent = RebirthFrame

local RebirthInput = Instance.new("TextBox")
RebirthInput.Size = UDim2.new(1,-30,0,40)
RebirthInput.Position = UDim2.new(0,15,0,100)
RebirthInput.BackgroundColor3 = Color3.fromRGB(40,40,40)
RebirthInput.TextColor3 = Color3.new(1,1,1)
RebirthInput.PlaceholderText = "0"
RebirthInput.Text = ""
RebirthInput.TextSize = 15
RebirthInput.Font = Enum.Font.GothamBlack
RebirthInput.ClearTextOnFocus = false
RebirthInput.BorderSizePixel = 0
RebirthInput.ZIndex = 21
RebirthInput.Parent = RebirthFrame

Instance.new("UICorner", RebirthInput).CornerRadius = UDim.new(0,6)

local RebirthOK = Instance.new("TextButton")
RebirthOK.Size = UDim2.new(0,125,0,38)
RebirthOK.Position = UDim2.new(0,15,0,155)
RebirthOK.BackgroundColor3 = Color3.fromRGB(50,160,70)
RebirthOK.Text = T.OK
RebirthOK.TextColor3 = Color3.new(1,1,1)
RebirthOK.TextSize = 13
RebirthOK.Font = Enum.Font.GothamBlack
RebirthOK.BorderSizePixel = 0
RebirthOK.ZIndex = 21
RebirthOK.Parent = RebirthFrame

Instance.new("UICorner", RebirthOK).CornerRadius = UDim.new(0,6)

local RebirthCancel = Instance.new("TextButton")
RebirthCancel.Size = UDim2.new(0,125,0,38)
RebirthCancel.Position = UDim2.new(0,160,0,155)
RebirthCancel.BackgroundColor3 = Color3.fromRGB(150,50,50)
RebirthCancel.Text = T.Cancel
RebirthCancel.TextColor3 = Color3.new(1,1,1)
RebirthCancel.TextSize = 13
RebirthCancel.Font = Enum.Font.GothamBlack
RebirthCancel.BorderSizePixel = 0
RebirthCancel.ZIndex = 21
RebirthCancel.Parent = RebirthFrame

Instance.new("UICorner", RebirthCancel).CornerRadius = UDim.new(0,6)

local function GetCurrentRebirths()

    local Names = {
        "Rebirths",
        "Rebirth",
        "rebirths",
        "rebirth"
    }

    local Leaderstats =
        Player:FindFirstChild("leaderstats")

    if Leaderstats then

        for _,Name in ipairs(Names) do

            local Value =
                Leaderstats:FindFirstChild(Name)

            if Value and Value:IsA("ValueBase") then

                return tonumber(Value.Value) or 0

            end

        end

    end

    for _,Name in ipairs(Names) do

        local Value =
            Player:FindFirstChild(Name)

        if Value and Value:IsA("ValueBase") then

            return tonumber(Value.Value) or 0

        end

    end

    return nil

end

RebirthBtn.Activated:Connect(function()

    if AutoRebirth then

        AutoRebirth = false

        SetBtn(
            RebirthBtn,
            T.Rebirth,
            false
        )

        RebirthTarget = 0

        return

    end

    RebirthFrame.Visible = true

    RebirthInput:CaptureFocus()

end)

RebirthCancel.Activated:Connect(function()

    RebirthFrame.Visible = false

end)

RebirthOK.Activated:Connect(function()

    local Number =
        tonumber(RebirthInput.Text)

    if Number == nil then
        Number = 0
    end

    Number = math.floor(Number)

    if Number < 0 then
        Number = 0
    end

    RebirthTarget = Number

    local Current =
        GetCurrentRebirths()

    if Current ~= nil then
        RebirthStart = Current
    else
        RebirthStart = 0
    end

    AutoRebirth = true

    SetBtn(
        RebirthBtn,
        T.Rebirth,
        true
    )

    RebirthFrame.Visible = false
    RebirthInput.Text = ""

end)

task.spawn(function()

    while task.wait(0.08) do

        if AutoRebirth then

            pcall(function()

                if RebirthTarget > 0 then

                    local Current =
                        GetCurrentRebirths()

                    if Current ~= nil then

                        if Current >=
                            RebirthStart + RebirthTarget then

                            AutoRebirth = false

                            SetBtn(
                                RebirthBtn,
                                T.Rebirth,
                                false
                            )

                            return

                        end

                    end

                end

                local rEvents =
                    ReplicatedStorage:FindFirstChild(
                        "rEvents"
                    )

                local Remote =
                    rEvents and
                    rEvents:FindFirstChild(
                        "rebirthRemote"
                    )

                if Remote then

                    Remote:InvokeServer(
                        "rebirthRequest"
                    )

                end

            end)

        end

    end

end)

--// АВТО-КИНГ

KingBtn.Activated:Connect(function()

    AutoKing = not AutoKing

    SetBtn(
        KingBtn,
        T.King,
        AutoKing
    )

end)

task.spawn(function()

    while task.wait(0.001) do

        if AutoKing then

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
                            CFrame.new(
                                -8744.821,
                                121.183,
                                -5859.323
                            )

                    end

                end

            end)

        end

    end

end)

--// АНТИ-АФК

AFKBtn.Activated:Connect(function()

    AntiAFK = not AntiAFK

    SetBtn(
        AFKBtn,
        T.AFK,
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

--// ПОИСК И ПОДБОР СУНДУКА

local function ClickChest()

    local Found = false

    for _,Object in ipairs(
        workspace:GetDescendants()
    ) do

        if Object:IsA("ProximityPrompt") then

            local Name =
                string.lower(
                    Object.Parent.Name or ""
                )

            if string.find(Name,"chest")
            or string.find(Name,"reward")
            or string.find(Name,"crate")
            or string.find(Name,"сундук")
            or string.find(Name,"награ") then

                pcall(function()

                    fireproximityprompt(Object)

                end)

                Found = true

            end

        end

    end

    --// GUI НАГРАДА

    for _,Object in ipairs(
        PlayerGui:GetDescendants()
    ) do

        if Object:IsA("TextButton")
        or Object:IsA("ImageButton") then

            if Object.Visible then

                local Text = ""

                pcall(function()
                    Text =
                        string.lower(
                            Object.Text or ""
                        )
                end)

                local Name =
                    string.lower(
                        Object.Name or ""
                    )

                if string.find(Text,"claim")
                or string.find(Text,"reward")
                or string.find(Text,"chest")
                or string.find(Text,"забрать")
                or string.find(Text,"награ")
                or string.find(Name,"claim")
                or string.find(Name,"reward")
                or string.find(Name,"chest") then

                    pcall(function()
                        Object:Activate()
                    end)

                    Found = true

                end

            end

        end

    end

    return Found

end

--// ВКЛЮЧЕНИЕ NOCLIP

local function StartBossNoclip()

    local Character =
        Player.Character

    if not Character then
        return
    end

    OldCollision = {}

    for _,Part in ipairs(
        Character:GetDescendants()
    ) do

        if Part:IsA("BasePart") then

            OldCollision[Part] =
                Part.CanCollide

            Part.CanCollide = false

        end

    end

    BossNoclipConnection =
        RunService.Stepped:Connect(function()

            if not AutoBoss then
                return
            end

            local Char =
                Player.Character

            if not Char then
                return
            end

            for _,Part in ipairs(
                Char:GetDescendants()
            ) do

                if Part:IsA("BasePart") then
                    Part.CanCollide = false
                end

            end

        end)

end

--// ВЫКЛЮЧЕНИЕ NOCLIP

local function StopBossNoclip()

    if BossNoclipConnection then

        BossNoclipConnection:Disconnect()
        BossNoclipConnection = nil

    end

    local Character =
        Player.Character

    if Character then

        for Part,Value in pairs(
            OldCollision
        ) do

            if Part and Part.Parent then
                Part.CanCollide = Value
            end

        end

    end

    OldCollision = {}

end

--// FLY

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

            Root.AssemblyLinearVelocity =
                Vector3.zero

            Root.AssemblyAngularVelocity =
                Vector3.zero

        end)

end

local function StopBossFly()

    if BossFlyConnection then

        BossFlyConnection:Disconnect()
        BossFlyConnection = nil

    end

end

--// АВТО-БОССЫ
--// НОВАЯ ЛОГИКА:
--// Y=28 -> получил урон -> Y=4
--// сундук -> Y=28

BossBtn.Activated:Connect(function()

    AutoBoss = not AutoBoss

    SetBossBtn(AutoBoss)

    if AutoBoss then

        local Character =
            Player.Character

        if Character then

            local Root =
                Character:FindFirstChild(
                    "HumanoidRootPart"
                )

            if Root then

                LastPosition =
                    Root.CFrame

            end

        end

        StartBossNoclip()
        StartBossFly()

    else

        StopBossFly()
        StopBossNoclip()

        if LastPosition then

            local Character =
                Player.Character

            if Character then

                local Root =
                    Character:FindFirstChild(
                        "HumanoidRootPart"
                    )

                if Root then

                    Root.AssemblyLinearVelocity =
                        Vector3.zero

                    Root.AssemblyAngularVelocity =
                        Vector3.zero

                    Root.CFrame =
                        LastPosition

                end

            end

        end

        LastPosition = nil

    end

end)

task.spawn(function()

    local PreviousHealth = nil
    local BossY = BossYNormal
    local WaitingForChest = false

    while task.wait(0.05) do

        if AutoBoss then

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

                local Humanoid =
                    Character:FindFirstChildOfClass(
                        "Humanoid"
                    )

                if not Root or not Humanoid then
                    return
                end

                --// СОХРАНЯЕМ HP

                if PreviousHealth == nil then

                    PreviousHealth =
                        Humanoid.Health

                end

                --// ПРОВЕРКА УРОНА

                if Humanoid.Health <
                    PreviousHealth then

                    BossY = BossYDamage
                    WaitingForChest = true

                end

                PreviousHealth =
                    Humanoid.Health

                --// ПОЛОЖЕНИЕ БОССА

                Root.AssemblyLinearVelocity =
                    Vector3.zero

                Root.AssemblyAngularVelocity =
                    Vector3.zero

                Root.CFrame =
                    CFrame.new(
                        BossX,
                        BossY,
                        BossZ
                    ) *
                    CFrame.Angles(
                        0,
                        math.pi,
                        0
                    )

                --// ЕСЛИ ПОЛУЧИЛИ УРОН
                --// ПЫТАЕМСЯ ПОДОБРАТЬ СУНДУК

                if WaitingForChest then

                    local ChestTaken =
                        ClickChest()

                    if ChestTaken then

                        BossY =
                            BossYNormal

                        WaitingForChest =
                            false

                        task.wait(0.05)

                    end

                end

                --// БЬЁМ БОССА

                DoPunch()

            end)

        end

    end

end)

--// СБРОС ПЕРЕМЕННЫХ ПОСЛЕ ВЫКЛЮЧЕНИЯ

BossBtn.Activated:Connect(function()

    if not AutoBoss then

        -- следующий запуск снова начинается с Y=28

        -- ничего больше не меняем

    end

end)

--// АВТО-ДУРАБИЛИТИ

DurBtn.Activated:Connect(function()

    AutoDurability = not AutoDurability

    SetBtn(
        DurBtn,
        T.Durability,
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

                local Punch =
                    GetPunch()

                if not Punch or not Humanoid then
                    return
                end

                if Punch.Parent ~= Character then

                    Humanoid:EquipTool(Punch)

                    task.wait(0.1)

                end

                local Root =
                    Character:FindFirstChild(
                        "HumanoidRootPart"
                    )

                local Durability =
                    Player:FindFirstChild(
                        "Durability"
                    )

                local MachinesFolder =
                    workspace:FindFirstChild(
                        "machinesFolder"
                    )

                if not Root
                or not Durability
                or not MachinesFolder then
                    return
                end

                local CurrentDurability =
                    tonumber(
                        Durability.Value
                    ) or 0

                local BestRock = nil
                local BestRequired = -1

                for _,Machine in ipairs(
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

                    Root.CFrame =
                        CFrame.new(
                            BestRock.Position
                            + Vector3.new(
                                0,
                                3,
                                2
                            )
                        )

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

            end)

        end

    end

end)

--// АВТО-УДАРЫ

AutoPunchBtn.Activated:Connect(function()

    AutoPunch = not AutoPunch

    SetBtn(
        AutoPunchBtn,
        T.Punch,
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

--// АВТО-КИНГ-КАМЕНЬ

KingRockBtn.Activated:Connect(function()

    AutoKingRock = not AutoKingRock

    SetBtn(
        KingRockBtn,
        T.KingRock,
        AutoKingRock
    )

end)

task.spawn(function()

    while task.wait(0.15) do

        if AutoKingRock then

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
                            CFrame.new(
                                -8928.078,
                                13.199,
                                -6004.433
                            )

                        DoPunch()

                    end

                end

            end)

        end

    end

end)

print(
    "KIRILL PANEL NO KEY V1.55 LOADED"
)
