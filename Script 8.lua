   -- Services -- 
    local Players = game:GetService("Players")
    local RS = game:GetService("ReplicatedStorage")
    local RunService = game:GetService("RunService")
    local UIS = game:GetService("UserInputService")
    local Debris = game:GetService("Debris")
    local TextChatService = game:GetService("TextChatService")
    local Lighting = game:GetService("Lighting")
    -- LocalPlayer Locals -- 
    local plr = Players.LocalPlayer
    local mouse = plr:GetMouse()
    local char = plr.Character
    local hum = char:FindFirstChild("Humanoid") or char:WaitForChild("Humanoid")
    local hrp = char:FindFirstChild("HumanoidRootPart") or char:WaitForChild("HumanoidRootPart")
    local head = char:FindFirstChild("Head") or char:WaitForChild("Head")
    local IsHeld = plr.IsHeld
    local CanSpawnToy = plr.CanSpawnToy
    local InPlot = plr.InPlot
    local InOwnedPlot = plr.InOwnedPlot
    local AntiLineLag = plr.PlayerScripts.CharacterAndBeamMove
    local AntiShuriLag = plr.PlayerScripts.StickyPartsTouchDetection
    local inv = workspace:FindFirstChild(plr.Name.."SpawnedInToys") or workspace:WaitForChild(plr.Name.."SpawnedInToys")
    -- Remotes --
    local SetNetworkOwner = RS.GrabEvents:FindFirstChild("SetNetworkOwner") or RS.GrabEvents:WaitForChild("SetNetworkOwner")
    local StickyEvent = RS.PlayerEvents:FindFirstChild("StickyPartEvent") or RS.PlayerEvents:WaitForChild("StickyPartEvent")
    local DestroyToy = RS.MenuToys:FindFirstChild("DestroyToy") or RS.MenuToys:WaitForChild("DestroyToy")
    local Struggle = RS.CharacterEvents:FindFirstChild("Struggle") or RS.CharacterEvents:WaitForChild("Struggle")
    local CreateGrabLine = RS.GrabEvents:FindFirstChild("CreateGrabLine") or RS.GrabEvents:WaitForChild("CreateGrabLine")
    local SetLineColor = RS.DataEvents:FindFirstChild("UpdateLineColorsEvent") or RS.DataEvents:WaitForChild("UpdateLineColorsEvent")
    local SpawnToyRemote = RS.MenuToys:FindFirstChild("SpawnToyRemoteFunction") or RS.MenuToys:WaitForChild("SpawnToyRemoteFunction")
    local DestroyGrabLine = RS.GrabEvents:FindFirstChild("DestroyGrabLine") or RS.GrabEvents:WaitForChild("DestroyGrabLine")
    local RagdollRemote = RS.CharacterEvents:FindFirstChild("RagdollRemote") or RS.CharacterEvents:WaitForChild("RagdollRemote")
   
             
game.Players.LocalPlayer.PlayerScripts.CharacterAndBeamMove.Enabled = false
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")
loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
local BetterOrion = loadstring(game:HttpGet("https://gitlab.com/m1kp0/BetterOrion/raw/main/Library.lua"))()
local Window = BetterOrion:MakeWindow({
    Name = "kirpich hub",
    SubName = "by cimkarta", 
    IntroEnabled = true, 
    IntroIcon = "hand", 
    IntroText = "Welcome!", 
    Size = UDim2.new(0, 500, 0, 350),
    MinSize = UDim2.new(0, 500, 0, 200),
    MaxSize = UDim2.new(0, 9999, 0, 9999),
    Transparency = 0.35,
    ToggleUIKey = Enum.KeyCode.Tab,
    SearchBar = true,
    WatermarkConfig = {
        Enabled = true,
        Visible = true,
        ShowFPS = true,
        ShowPing = true,
        ShowName = true,
        ShowClockTime = true,
        Icon = "activity"
    }
})
Window:SetBackground("rbxassetid://86870310824805")
Window:SetBackgroundVisibility(true)
Window:SetBackgroundTransparency(0.2)

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterGui = game:GetService("StarterGui")
local PS = game:GetService("Players")
local RS = game:GetService("ReplicatedStorage")
local R = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = workspace
local Player = PS.LocalPlayer
local Camera = Workspace.CurrentCamera
local CE = RS:WaitForChild("CharacterEvents", 10)
local BeingHeld = Player:WaitForChild("IsHeld", 10)
local StruggleEvent = CE and CE:WaitForChild("Struggle")
function notify(title, content, duration)
	Library:Notify({ Title = title or "Notification", Content = content or "", Duration = duration or 5,
	 })
end



local Tab = Window:MakeTab({Name = "Player", Icon = "person"})





local Section = Tab:AddSection({Name = "Main", Side = "Left"})






local PL_SpeedEnabled = false
local PL_SpeedValue = 16
local PL_SpeedConn = nil

-- Секция


-- Слайдер скорости
Section:AddSlider({
    Name = "Walk Speed",
    Min = 1,
    Max = 200,
    Default = 16,
    Increment = 1,
    ValueName = "",
    Callback = function(value)
        PL_SpeedValue = value
        if PL_SpeedEnabled then
            local char = game.Players.LocalPlayer.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            local hum = char and char:FindFirstChild("Humanoid")
            if hrp and hum then
                hrp.CFrame = hrp.CFrame + hum.MoveDirection * (PL_SpeedValue * 0.1)
            end
        end
    end
})

-- Toggle для включения
Section:AddToggle({
    Name = "Enable Speed",
    Default = false,
    Callback = function(state)
        PL_SpeedEnabled = state
        if state then
            if PL_SpeedConn then PL_SpeedConn:Disconnect() end
            PL_SpeedConn = game:GetService("RunService").RenderStepped:Connect(function()
                if not PL_SpeedEnabled then return end
                local char = game.Players.LocalPlayer.Character
                local hrp = char and char:FindFirstChild("HumanoidRootPart")
                local hum = char and char:FindFirstChild("Humanoid")
                if hrp and hum then
                    hrp.CFrame = hrp.CFrame + hum.MoveDirection * (PL_SpeedValue * 0.1)
                end
            end)
        else
            if PL_SpeedConn then
                PL_SpeedConn:Disconnect()
                PL_SpeedConn = nil
            end
        end
    end
})


Section:AddSlider({
    Name = "Jump Power",
    Min = 0,
    Max = 200,
    Default = 50,
    Increment = 1,
    ValueName = "",
    Callback = function(value)
        PL_JumpPower = value
        if PL_JumpEnabled then
            local char = game.Players.LocalPlayer.Character
            local hum = char and char:FindFirstChild("Humanoid")
            if hum then
                hum.JumpPower = PL_JumpPower
            end
        end
    end
})

-- Toggle для прыжка
Section:AddToggle({
    Name = "Enable Jump Power",
    Default = false,
    Callback = function(state)
        PL_JumpEnabled = state
        local char = game.Players.LocalPlayer.Character
        local hum = char and char:FindFirstChild("Humanoid")
        if hum then
            if state then
                hum.JumpPower = PL_JumpPower
            else
                hum.JumpPower = 50
            end
        end
    end
})



Section:AddToggle({
    Name = "Third Person",
    Default = false,
    Flag = "ThirdP",
    Callback = function(Value)
        local plr = game.Players.LocalPlayer
        plr.CameraMaxZoomDistance = 1e9
        if Value then
            plr.CameraMode = Enum.CameraMode.Classic
        else    
            plr.CameraMode = Enum.CameraMode.LockFirstPerson
        end
    end
})




local Tab = Window:MakeTab({Name = "Defense", Icon = "person"})

local Section = Tab:AddSection({Name = "Main", Side = "Left"})

--анти граб фушраншгщш э
local antiGrabExplosionConn, antiGrabHeldConn, antiGrabStruggleConn, antiGrabHumConn, antiGrabAnchorConn
local antiGrabRootCF, antiGrabRootPos, antiGrabHardFreeze = nil, nil, false
local function antiGrabUnfreeze(char)
	local hrp = char and char:FindFirstChild("HumanoidRootPart")
	if hrp then
		hrp.Anchored = false
		if hrp:FindFirstChild("FreezeJoint") then
			hrp.FreezeJoint:Destroy()
		end
	end
	antiGrabHardFreeze = false
	if antiGrabAnchorConn then
		antiGrabAnchorConn:Disconnect()
		antiGrabAnchorConn = nil
	end
end
local function antiGrabFreezeInPlace(char)
	local hrp = char and char:FindFirstChild("HumanoidRootPart")
	if not hrp then
		return
	end
	antiGrabRootCF = hrp.CFrame
	antiGrabRootPos = hrp.Position
	antiGrabHardFreeze = true
	if not hrp:FindFirstChild("FreezeJoint") then
		local align = Instance.new("AlignPosition")
		align.Name = "FreezeJoint"
		align.Mode = Enum.PositionAlignmentMode.OneAttachment
		align.MaxForce = 1e6
		align.MaxVelocity = 0
		align.Responsiveness = 200
		local att = Instance.new("Attachment", hrp)
		align.Attachment0 = att
		align.Position = antiGrabRootPos
		align.Parent = hrp
	end
	antiGrabAnchorConn = R.Heartbeat:Connect(function()
		if antiGrabHardFreeze and hrp then
			hrp.AssemblyLinearVelocity = Vector3.zero
			hrp.AssemblyAngularVelocity = Vector3.zero
			hrp.CFrame = antiGrabRootCF
		end
	end)
end
local function antiGrabReconnect()
	local char = Player.Character or Player.CharacterAdded:Wait()
	local hum = char:WaitForChild("Humanoid")
	local hrp = char:WaitForChild("HumanoidRootPart")
	local fp = hrp:FindFirstChild("FirePlayerPart")
	if fp then
		fp:Destroy()
	end
	if antiGrabHumConn then
		antiGrabHumConn:Disconnect()
	end
	antiGrabHumConn = hum.Changed:Connect(function(p)
		if p == "Sit" and hum.Sit then
			if not (hum.SeatPart and tostring(hum.SeatPart.Parent) == "CreatureBlobman") then
				hum:SetStateEnabled(Enum.HumanoidStateType.Jumping, true)
				hum.Sit = false
			end
		end
	end)
end
local autoStruggleConn = nil
Section:AddToggle({
    Name = "Anti kick",
    Default = false,  
    Color = Color3.fromRGB(40, 40, 40), 
    Flag = "antki",
    Binded = false,
    Settings = false,
	Callback = function(Value)
		_G.ShurikenAntiKick = Value
		local function ClearKunai()
			local plr = game.Players.LocalPlayer
			local inv = workspace:FindFirstChild(plr.Name .. "SpawnedInToys")
			local destroyrem = game.ReplicatedStorage:FindFirstChild("MenuToys") and game.ReplicatedStorage.MenuToys:FindFirstChild("DestroyToy")
			if inv and destroyrem then
				for _, v in pairs(inv:GetChildren()) do
					if v.Name == "AntiKick" or v.Name == "NinjaShuriken" then
						pcall(function()
							destroyrem:FireServer(v)
						end)
					end
				end
			end
		end
		if Value then
			task.spawn(function()
				local plr = game.Players.LocalPlayer
				local ReplicatedStorage = game:GetService("ReplicatedStorage")
				local setOwner = ReplicatedStorage:WaitForChild("GrabEvents"):WaitForChild("SetNetworkOwner")
				local stickyEvent = ReplicatedStorage:WaitForChild("PlayerEvents"):WaitForChild("StickyPartEvent")
				local spawnRemote = ReplicatedStorage.MenuToys.SpawnToyRemoteFunction
				local destroyrem = ReplicatedStorage:WaitForChild("MenuToys"):WaitForChild("DestroyToy")
				local canSpawn = plr:WaitForChild("CanSpawnToy")
				local function getHRP()
					if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
						return plr.Character.HumanoidRootPart
					else
						local character = plr.CharacterAdded:Wait()
						return character:WaitForChild("HumanoidRootPart")
					end
				end
				local function CheckForHome()
					if not workspace.PlotItems.PlayersInPlots:FindFirstChild(plr.Name) then
						return false
					end
					for _, v in pairs(workspace.Plots:GetChildren()) do
						local sign = v:FindFirstChild("PlotSign")
						local owners = sign and sign:FindFirstChild("ThisPlotsOwners")
						if owners then
							for _, b in pairs(owners:GetChildren()) do
								if b.Value == plr.Name then
									local folder = workspace.PlotItems:FindFirstChild(v.Name)
									if folder then
										return true, folder
									end
								end
							end
						end
					end
					return false
				end
				local function StickKunai(kunai)
					if not kunai or not kunai:FindFirstChild("StickyPart") then
						return
					end
					local currentHRP = getHRP()
					if not currentHRP then
						return
					end
					if kunai:FindFirstChild("SoundPart") then
						if not kunai.SoundPart:FindFirstChild("PartOwner") or kunai.SoundPart.PartOwner.Value ~= plr.Name then
							setOwner:FireServer(kunai.SoundPart, kunai.SoundPart.CFrame)
						end
					end
					local firePart = currentHRP:FindFirstChild("FirePlayerPart") or currentHRP:WaitForChild("FirePlayerPart", 5)
					if firePart then
						stickyEvent:FireServer(
								kunai.StickyPart,
								firePart,
								CFrame.new(0, 0, 0) * CFrame.Angles(0, math.rad(90), math.rad(90))
							)
					end
					for _, obj in pairs(kunai:GetChildren()) do
						if obj.Name == "Pyramid" then
							obj.CanTouch = false;
							obj.CanCollide = false;
							obj.CanQuery = false;
							obj.Transparency = 0
							if not obj:FindFirstChild("Highlight") then
								local high = Instance.new("Highlight", obj)
								high.FillColor = Color3.fromRGB(0, 0, 0)
							end
						elseif obj.Name == "Main" then
							obj.CanTouch = false;
							obj.CanCollide = false;
							obj.CanQuery = false;
							obj.Transparency = 0
							if not obj:FindFirstChild("Highlight") then
								local high = Instance.new("Highlight", obj)
								high.FillColor = Color3.fromRGB(255, 255, 255)
							end
						elseif obj:IsA("BasePart") then
							obj.CanTouch = false;
							obj.CanCollide = false;
							obj.CanQuery = false;
							obj.Transparency = 1
						end
					end
				end
				local function SpawnToy(name)
					local t = tick()
					while not canSpawn.Value do
						if not _G.ShurikenAntiKick or tick() - t > 5 then
							return nil
						end
						task.wait(0.1)
					end
					local currentHRP = getHRP()
					if currentHRP then
						task.spawn(function()
							pcall(function()
								spawnRemote:InvokeServer(name, currentHRP.CFrame * CFrame.new(0, 12, 20), Vector3.new(0, 0, 0))
							end)
						end)
					end
					local boolik, house = CheckForHome()
					local inv = workspace:FindFirstChild(plr.Name .. "SpawnedInToys")
					if boolik and house then
						return house:WaitForChild(name, 2)
					elseif not workspace.PlotItems.PlayersInPlots:FindFirstChild(plr.Name) and inv then
						return inv:WaitForChild(name, 2)
					end
					return nil
				end
				while _G.ShurikenAntiKick do
					task.wait(0.005)
					if not plr.Character or not plr.Character:FindFirstChild("Humanoid") or plr.Character.Humanoid.Health <= 0 then
						continue
					end
					local inv = workspace:FindFirstChild(plr.Name .. "SpawnedInToys")
					local kunai = inv and inv:FindFirstChild("NinjaShuriken")
					if workspace.PlotItems.PlayersInPlots:FindFirstChild(plr.Name) then
						local boolik, house = CheckForHome()
						if boolik and house and workspace.Plots:FindFirstChild(house.Name) then
							local sign = workspace.Plots[house.Name]:FindFirstChild("PlotSign")
							if sign and sign.ThisPlotsOwners.Value.TimeRemainingNum.Value > 89 then
								kunai = SpawnToy("NinjaShuriken")
								if kunai == nil then
									continue
								end
								kunai.Name = "AntiKick"
								StickKunai(kunai)
							end
						end
					end
					if not kunai then
						if workspace.PlotItems.PlayersInPlots:FindFirstChild(plr.Name) then
							continue
						end
						kunai = SpawnToy("NinjaShuriken")
						if kunai == nil then
							continue
						end
						kunai.Name = "AntiKick"
						if not kunai then
							continue
						end
					end
					repeat
						if kunai and kunai:FindFirstChild("StickyPart") and kunai.StickyPart.CanTouch == true then
							StickKunai(kunai)
							kunai.Name = "AntiKick"
						end
						task.wait(0.3)
					until not kunai or not _G.ShurikenAntiKick
							or not kunai:FindFirstChild("StickyPart")
							or kunai.StickyPart.CanTouch == false 
							or not plr.Character or not plr.Character:FindFirstChild("HumanoidRootPart") 
							or not kunai:FindFirstChild("StickyPart") 
							or (plr.Character.HumanoidRootPart.Position - kunai.StickyPart.Position).Magnitude >= 20
					if not kunai or not kunai:FindFirstChild("StickyPart") or not plr.Character or not plr.Character:FindFirstChild("HumanoidRootPart") or (plr.Character.HumanoidRootPart.Position - kunai.StickyPart.Position).Magnitude >= 20 then
						ClearKunai()
					end
					pcall(function()
						repeat
							task.wait(0.05)
						until not _G.ShurikenAntiKick or not plr.Character or not plr.Character:FindFirstChild("Humanoid") or not kunai or not kunai:FindFirstChild("StickyPart") or not kunai.StickyPart:FindFirstChild("StickyWeld") or not kunai.StickyPart.StickyWeld.Part1
						if not kunai or not kunai:FindFirstChild("StickyPart") or (plr.Character and plr.Character:FindFirstChild("Humanoid") and plr.Character.Humanoid.Health <= 0) or not kunai["StickyPart"]:FindFirstChild("StickyWeld").Part1 then
							ClearKunai()
						end
					end)
				end
			end)
		else
			_G.ShurikenAntiKick = false
			ClearKunai()
		end
	end
})







--// TOY LIST (Short name -> Real name)
local ToyList = {
	["SparklePoop"] = "PoopPileSparkle",
	["Burger"]      = "FoodHamburger",
	["Coconut"]     = "FoodCoconut",
	["Banana"]      = "FoodBanana",
	["Fries"]       = "FoodFrenchFries",
	["MeatStick"]   = "FoodMeatStick",
	["Poop"]        = "PoopPile",
	["Donut"]       = "FoodDonut",
	["Cake"]        = "FoodCakePink",
	["Pizza"]       = "FoodPizzaCheese",
	["Hotdog"]      = "FoodHotdog",
	["Mushroom"]    = "FoodMushroomPoison",
	["Banjo"]       = "InstrumentGuitarBanjo",
	["Violin"]      = "InstrumentGuitarViolin",
	["Ukulele"]     = "InstrumentGuitarUkulele",
	["Sax"]         = "InstrumentWoodwindSaxophone",
	["Vuvuzela"]    = "InstrumentBrassVuvuzela",
	["Bongos"]      = "InstrumentDrumBongos",
	["Mic"]         = "InstrumentVoiceMicrophone",
	["Pepperoni"]   = "FoodPizzaPepperoni",
	["Piano"]       = "InstrumentPianoMelodica",
	["Bread"]       = "FoodBread",
	["Egg"]         = "FoodDippyEgg",
	["Mayo"]        = "FoodMayonnaise",
	["WhiteMug"]    = "CupMugWhite",
	["Ocarina"]     = "InstrumentWoodwindOcarina",
	["BrownMug"]    = "CupMugBrown",
	["Trumpet"]     = "InstrumentBrassTrumpet",
	["Snare"]       = "InstrumentDrumSnare",
}

--// DROPDOWN VALUES
local DropdownValues = {}
for shortName, _ in pairs(ToyList) do
	table.insert(DropdownValues, shortName)
end
table.sort(DropdownValues)

--// DEFAULT TOY
local SelectedToy = ToyList[DropdownValues]

--// DROPDOWN
Section:AddDropdown({
	Name = "Input Lag Item",
	Default = DropdownValues,
	Options = DropdownValues,
	Callback = function(Value)
		SelectedToy = ToyList[Value]
	end
})

--// TOGGLE
Section:AddToggle({
	Name = "Anti Input Lag",
	Default = false,
	Callback = function(Value)
		_G.AntiInputLag = Value
		if Value then
			task.spawn(function()
				local Players = game:GetService("Players")
				local ReplicatedStorage = game:GetService("ReplicatedStorage")
				local Workspace = game:GetService("Workspace")
				local RunService = game:GetService("RunService")
				local plr = Players.LocalPlayer
				local char = plr.Character or plr.CharacterAdded:Wait()
				local hrp = char:WaitForChild("HumanoidRootPart")
				local SpawnRemote =
                    ReplicatedStorage:WaitForChild("MenuToys"):WaitForChild("SpawnToyRemoteFunction")
				while _G.AntiInputLag do
                    -- Проверяем папку с игрушками игрока
					local toysFolder = Workspace:FindFirstChild(plr.Name .. "SpawnedInToys")
					if not toysFolder then
						task.wait(0.1)
						continue
					end
					local toy = toysFolder:FindFirstChild(SelectedToy)

                    -- Спавним игрушку если её нет
					if not toy then
						pcall(function()
							SpawnRemote:InvokeServer(
                                SelectedToy,
                                hrp.CFrame * CFrame.new(0, 5, 0),
                                Vector3.zero
                            )
						end)

                        -- Ждём пока игрушка появится
						local t0 = tick()
						repeat
							RunService.Heartbeat:Wait()
							toysFolder = Workspace:FindFirstChild(plr.Name .. "SpawnedInToys")
							toy = toysFolder and toysFolder:FindFirstChild(SelectedToy)
						until toy or tick() - t0 > 1 or not _G.AntiInputLag
					end-- Работа с HoldPart
					if toy and toy.Parent then
						local holdPart = toy:FindFirstChild("HoldPart")
						if holdPart then
							local holdingPlayer = holdPart:FindFirstChild("HoldingPlayer")
							holdingPlayer = holdingPlayer and holdingPlayer.Value
							if holdingPlayer and holdingPlayer ~= plr then
                                -- Другой игрок держит – дропаем
								pcall(function()
									holdPart.DropItemRemoteFunction:InvokeServer(
                                        toy,
                                        hrp.CFrame * CFrame.new(0, 2000, 0),
                                        Vector3.zero
                                    )
								end)
								toy:Destroy()
							else
                                -- Держим игрушку
								pcall(function()
									holdPart.HoldItemRemoteFunction:InvokeServer(toy, char)
								end)
								task.wait(0.05)
                                -- Дропаем для ресета
								pcall(function()
									holdPart.DropItemRemoteFunction:InvokeServer(
                                        toy,
                                        hrp.CFrame * CFrame.new(0, 2000, 0),
                                        Vector3.zero
                                    )
								end)
								task.wait(0.01)
							end
						end
					end
					RunService.Heartbeat:Wait()
				end
			end)
		end
	end
})
Section:AddToggle({
	Name = "Anti Blobman",
	Default = false,
	callback = function(v)
        if v then
            for i,v in pairs(workspace:GetDescendants()) do
                if v.Name == "CreatureBlobman" and not v:IsDescendantOf(inv) then 
                    local rd, ld = v:FindFirstChild("RightDetector") or v:WaitForChild("RightDetector", 3), v:FindFirstChild("LeftDetector") or v:WaitForChild("LeftDetector", 3)
                    if rd and ld then 
                        rd.RightAlignOrientation.Enabled = false
                        rd.RightWeld.Enabled = false
                        ld.LeftAlignOrientation.Enabled = false
                        ld.LeftWeld.Enabled = false
                    end
                end
            end
            cons["antiblob"] = workspace.DescendantAdded:Connect(function(d)
                if d.Name == "CreatureBlobman" and (not inv or not d:IsDescendantOf(inv)) then 
                    local rd = d:FindFirstChild("RightDetector") or d:WaitForChild("RightDetector", 3)
                    local ld = d:FindFirstChild("LeftDetector") or d:WaitForChild("LeftDetector", 3)

                    if rd and ld then
                        local rao = rd:WaitForChild("RightAlignOrientation", 1)
                        local rw  = rd:WaitForChild("RightWeld", 1)
                        local lao = ld:WaitForChild("LeftAlignOrientation", 1)
                        local lw  = ld:WaitForChild("LeftWeld", 1)

                        if rao then rao.Enabled = false end
                        if rw  then rw.Enabled  = false end
                        if lao then lao.Enabled = false end
                        if lw  then lw.Enabled  = false end
                    end
                end
            end)
        else
            if cons["antiblob"] then cons["antiblob"]:Disconnect() end
        end
    end
})
Section:AddToggle({
    Name = "Water Walk",
    Default = false,
    Callback = function(v)
        for i,vv in pairs(workspace.Map.AlwaysHereTweenedObjects.Ocean.Object.ObjectModel:GetChildren()) do
            if vv.Name == "Ocean" then
                vv.CanCollide = v
            end
        end
    end
})  
local Player = game:GetService("Players").LocalPlayer
local antiExplodeT = false

local function antiExplodeF()
	antiExplodeT = true
	local char = Player.Character
	if not char then
		return
	end
	local hrp = char:WaitForChild("HumanoidRootPart")
	workspace.ChildAdded:Connect(function(model)
		-- Добавлена проверка IsA("BasePart"), чтобы убедиться, что у объекта есть свойство Position
		if model:IsA("BasePart") and model.Name == "Part" and antiExplodeT then
			local mag = (model.Position - hrp.Position).Magnitude
			if mag <= 20 then
				hrp.Anchored = true
				task.wait(0.01) -- Стандартный wait заменен на более быстрый task.wait
				
				-- Защита от бесконечного цикла, если Right Arm или RagdollLimbPart отсутствует в персонаже
				while antiExplodeT and char:FindFirstChild("Right Arm") and char["Right Arm"]:FindFirstChild("RagdollLimbPart") and char["Right Arm"].RagdollLimbPart.CanCollide do
					task.wait() -- Минимальная безопасная задержка движка, предотвращающая зависание игры
				end
				
				hrp.Anchored = false
			end
		end
	end)
end

--// TOGGLE (Синтаксис BetterOrion)
Section:AddToggle({
	Name = "Anti Explosion",
	Flag = "Anti Explosion", 
	Default = false,
	Callback = function(on)
		-- Если функция SetToggleState определена в вашем скрипте выше, она выполнится без ошибок
		if typeof(SetToggleState) == "function" then
			SetToggleState("Anti Explosion", on)
		end
		
		if on then
			antiExplodeF()
		else
			antiExplodeT = false
		end
	end
})

do
    local destroyToy = RS:FindFirstChild("MenuToys") and RS.MenuToys:FindFirstChild("DestroyToy")
    -- Services & Local Variables
    local Players = game:GetService("Players")
    local RS = game:GetService("ReplicatedStorage")
    local RunService = game:GetService("RunService")
    local plr = Players.LocalPlayer

    -- State
    local AntiKickItemActive = false
    local MyPCLD = nil
    local pcldConn = nil
    local ToyList = {
        ["Japanese Lantern"] = "JapaneseLantern",
        ["Spray Can"]        = "SprayCanWD",
        ["Spooky Candle"]    = "SpookyCandle1",
    }

    local DropdownValues = {}
    for shortName, _ in pairs(ToyList) do
        table.insert(DropdownValues, shortName)
    end
    table.sort(DropdownValues)

    local SelectedToy = ToyList["Spooky Candle"] or ToyList[DropdownValues[1]]

    

    -- =========================================================================
    -- HELPER FUNCTIONS FOR ANTI-KICK ITEM
    -- =========================================================================
    local function GetMagnitude(Part1, Part2)
        return (Part1.Position - Part2.Position).Magnitude
    end

    local function FWD(parent, part, timeOffset)
        return parent:FindFirstChild(part) or parent:WaitForChild(part, timeOffset or 1)
    end

    local function CFP(parent, part)
        return parent:FindFirstChild(part) ~= nil  
    end

    local function CheckNetworkOwnerOnPart(Part) 
        local po = Part:FindFirstChild("PartOwner")
        return po and po.Value == plr.Name
    end

    local function sno(part)
        pcall(function()
            local grabEvents = RS:FindFirstChild("GrabEvents")
            local setNetOwner = grabEvents and grabEvents:FindFirstChild("SetNetworkOwner")
            if setNetOwner then
                setNetOwner:FireServer(part, part.CFrame)
            end
        end)
    end

    local function CheckForHome()
        local plotItems = workspace:FindFirstChild("PlotItems")
        local plots = workspace:FindFirstChild("Plots")
        
        if plots and plotItems then
            for i = 1, 5 do 
                local Plot = plots:FindFirstChild("Plot"..i)
                if Plot then
                    local sign = Plot:FindFirstChild("PlotSign")
                    local owners = sign and sign:FindFirstChild("ThisPlotsOwners")
                    if owners then
                        for _,v in pairs(owners:GetChildren()) do 
                            if v.Value == plr.Name then 
                                return plotItems:FindFirstChild("Plot"..i)
                            end
                        end
                    end
                end
            end
        end
        return nil
    end

    local function SpawnToy(ToyName)
        local InPlot = plr:FindFirstChild("InPlot")
        local InOwnedPlot = plr:FindFirstChild("InOwnedPlot")
        local CanSpawnToy = plr:FindFirstChild("CanSpawnToy")
        local inv = workspace:FindFirstChild(plr.Name.."SpawnedInToys")

        if InPlot and InPlot.Value and InOwnedPlot and not InOwnedPlot.Value then 
            InPlot:GetPropertyChangedSignal("Value"):Wait()
        end 
        if CanSpawnToy and not CanSpawnToy.Value then 
            CanSpawnToy:GetPropertyChangedSignal("Value"):Wait()
        end

        local hrp = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
        if not hrp then return nil end

        local SpawnCF = hrp.CFrame
        local Container = (InOwnedPlot and InOwnedPlot.Value) and CheckForHome() or inv
        if not Container then return nil end

        local spawnedObject = nil
        local connection
        connection = Container.ChildAdded:Connect(function(child)
            if child.Name == ToyName then
                spawnedObject = child
            end
        end)

        task.spawn(function()
            pcall(function()
                local menuToys = RS:FindFirstChild("MenuToys")
                local spawnRemote = menuToys and menuToys:FindFirstChild("SpawnToyRemoteFunction")
                if spawnRemote then
                    spawnRemote:InvokeServer(ToyName, SpawnCF, Vector3.zero)
                end
            end)
        end)

        local start = tick()
        repeat task.wait() until spawnedObject or (tick() - start) > 2.5

        if connection then connection:Disconnect() end
        return spawnedObject
    end

    local function FindPCLD(hrp)
        if pcldConn then pcldConn:Disconnect() end
        MyPCLD = nil
        pcldConn = RunService.Heartbeat:Connect(function()
            if MyPCLD or not hrp or not hrp.Parent then 
                if pcldConn then pcldConn:Disconnect() pcldConn = nil end
                return
            end
            for _, v in pairs(workspace:GetChildren()) do 
                if v.Name == "PlayerCharacterLocationDetector" and v:IsA("BasePart") then
                    if GetMagnitude(v, hrp) <= 2 then 
                        MyPCLD = v
                        break
                    end
                end
            end
        end)
    end

    -- =========================================================================
    -- ANTI-KICK ITEM TOGGLE
    -- =========================================================================
    Section:AddToggle({
        Name = "Anti Kick-item",
        Flag = "AntiKickItemFlag",
		Default = false,
        Callback = function(Val)
            if SetToggleState then SetToggleState("AntiKickItemFlag", Val) end
            AntiKickItemActive = Val 
            
            if Val then
                task.spawn(function()
                    local Item, SoundPart
                    while AntiKickItemActive and task.wait() do 
                        local char = plr.Character
                        local hrp = char and char:FindFirstChild("HumanoidRootPart")
                        local hum = char and char:FindFirstChild("Humanoid")
                        local inPlot = plr:FindFirstChild("InPlot")
                        local inv = workspace:FindFirstChild(plr.Name.."SpawnedInToys")
                        local destroyToy = RS:FindFirstChild("MenuToys") and RS.MenuToys:FindFirstChild("DestroyToy")
                        
                        -- Safety Checks
                        if not hrp or not hum or hum.Health <= 0 or not inv then continue end  
                        if inPlot and inPlot.Value then continue end 
                        
                        -- Initiate PCLD Tracking if needed
                        if not MyPCLD and not pcldConn then
                            FindPCLD(hrp)
                        end

                        -- ИСПРАВЛЕНО: Ищем по реальному названию выбранной игрушки (SelectedToy)
                        Item = inv:FindFirstChild(SelectedToy) 
                        SoundPart = Item and Item:FindFirstChild("Hitbox")
                        
                        -- Spawning Logic
                        if not Item or not SoundPart then
                            for _,v in pairs(inv:GetChildren()) do 
                                if v.Name == SelectedToy then 
                                    pcall(function() destroyToy:FireServer(v) end)
                                end
                            end
                            
                            Item = SpawnToy(SelectedToy)
                            if not Item then continue end 
                            
                            SoundPart = Item and FWD(Item, "Hitbox", 0.5)
                            if SoundPart then sno(SoundPart) end
                            
                            for _,v in pairs(Item:GetChildren()) do 
                                if v:IsA("BasePart") then 
                                    v.CanCollide = false 
                                    v.Transparency = 0.8
                                end
                            end
                        else
                            -- ИСПРАВЛЕНО: Если предмет уже существует, удерживаем его жестко внутри игрока
                            if Item:IsA("Model") then
                                Item:PivotTo(hrp.CFrame)
                            elseif Item:IsA("BasePart") then
                                Item.CFrame = hrp.CFrame
                            end
                        end
                    end
                end)
            end
        end
    })
end
local Section = Tab:AddSection({Name = "кирпич хаб ыы", Side = "Right"})

--// ИНИЦИАЛИЗАЦИЯ ТАБЛИЦ И СОСТОЯНИЙ ДЛЯ ДАННОГО ТОГГЛА
local AGConnections = AGConnections or {}
local antiGrabProc = antiGrabProc or false
local AGWalk = AGWalk or false

-- Хелпер быстрого ожидания (если его нет выше в вашем скрипте)
local function FWC(parent, childName, timeout)
    return parent:WaitForChild(childName, timeout or 5)
end

-- Хелпер безопасного отключения (если его нет выше в вашем скрипте)
local function Disc(key)
    if AGConnections[key] then
        pcall(function() AGConnections[key]:Disconnect() end)
        AGConnections[key] = nil
    end
end

--// TOGGLE (BETTERORION SYNTAX)
Section:AddToggle({
    Name = "anti grab",
    Flag = "AntiKickItemFlag",
    Default = false,
    Callback = function(Value)
        if Value then
            local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
            local hrp, hum, head = FWC(char, "HumanoidRootPart"), FWC(char, "Humanoid"), FWC(char, "Head")
            
            AGConnections["AGHead"] = head.ChildAdded:Connect(function(PartOwner)
                if PartOwner.Name == "PartOwner" then
                    if not antiGrabProc then
                        antiGrabProc = true
                        hum.Sit = false
                        ReplicatedStorage.CharacterEvents.Struggle:FireServer(LocalPlayer)
                        task.spawn(function() 
                            while (head and head:FindFirstChild("PartOwner")) or LocalPlayer.IsHeld.Value do
                                ReplicatedStorage.CharacterEvents.Struggle:FireServer(LocalPlayer)
                                ReplicatedStorage.CharacterEvents.RagdollRemote:FireServer(hrp, 0)
                                task.wait()
                            end
                        end)
                        hrp.Anchored = true
                        if not AGWalk then
                            AGWalk = true
                            while LocalPlayer.IsHeld.Value and task.wait() do 
                                hrp.CFrame = hrp.CFrame + hum.MoveDirection * 0.43 
                            end
                        end
                        hrp.Anchored = false
                        antiGrabProc = false
                        AGWalk = false
                    end
                end
            end)
            
            AGConnections["AGRagdoll"] = FWC(hum, "Ragdolled").Changed:Connect(function()
                if hum.Ragdolled.Value then
                    for _, v in pairs(char:GetChildren()) do
                        if v:IsA("BasePart") and v:FindFirstChild("BallSocketConstraint") and v.Name ~= "Head" then
                            v.BallSocketConstraint.Enabled = false
                            if v:FindFirstChild("RagdollLimbPart") then
                                v.RagdollLimbPart.WeldConstraint.Enabled = false
                            end
                        end
                    end
                end
            end)
            
            AGConnections["AGWeld"] = FWC(hrp, "WeldHRP").Changed:Connect(function()
                if hrp.WeldHRP.Enabled then
                    while not hum.Sit do task.wait() end
                    hum.Sit = false
                    hum.AutoRotate = true
                    hum.HipHeight = 1
                    while hrp.WeldHRP.Enabled and task.wait() do 
                        head.CFrame = hrp.CFrame + Vector3.new(0, 1.35, 0) 
                    end
                    hum.HipHeight = 0
                end
            end)
            
            for _, v in pairs(char:GetChildren()) do
                if v:IsA("BasePart") and v:FindFirstChild("BallSocketConstraint") and v.Name ~= "Head" then
                    v.BallSocketConstraint.Enabled = false
                    if v:FindFirstChild("RagdollLimbPart") then
                        v.RagdollLimbPart.WeldConstraint.Enabled = false
                    end
                end
            end
            
            AGConnections["AGChar"] = LocalPlayer.CharacterAdded:Connect(function(newChar)
                local newHrp, newHum, newHead = FWC(newChar, "HumanoidRootPart"), FWC(newChar, "Humanoid"), FWC(newChar, "Head")
                AGConnections["AGHeadNew"] = newHead.ChildAdded:Connect(function(PartOwner)
                    if PartOwner.Name == "PartOwner" then
                        if not antiGrabProc then
                            antiGrabProc = true
                            newHum.Sit = false
                            ReplicatedStorage.CharacterEvents.Struggle:FireServer(LocalPlayer)
                            task.spawn(function() 
                                while (newHead and newHead:FindFirstChild("PartOwner")) or LocalPlayer.IsHeld.Value do
                                    ReplicatedStorage.CharacterEvents.Struggle:FireServer(LocalPlayer)
                                    ReplicatedStorage.CharacterEvents.RagdollRemote:FireServer(newHrp, 0)
                                    task.wait()
                                end
                            end)
                            newHrp.Anchored = true
                            if not AGWalk then
                                AGWalk = true
                                while LocalPlayer.IsHeld.Value and task.wait() do 
                                    newHrp.CFrame = newHrp.CFrame + newHum.MoveDirection * 0.43 
                                end
                            end
                            newHrp.Anchored = false
                            antiGrabProc = false
                            AGWalk = false
                        end
                    end
                end)
                
                AGConnections["AGRagdollNew"] = FWC(newHum, "Ragdolled").Changed:Connect(function()
                    if newHum.Ragdolled.Value then
                        for _, v in pairs(newChar:GetChildren()) do
                            if v:IsA("BasePart") and v:FindFirstChild("BallSocketConstraint") and v.Name ~= "Head" then
                                v.BallSocketConstraint.Enabled = false
                                if v:FindFirstChild("RagdollLimbPart") then
                                    v.RagdollLimbPart.WeldConstraint.Enabled = false
                                end
                            end
                        end
                    end
                end)
                
                AGConnections["AGWeldNew"] = FWC(newHrp, "WeldHRP").Changed:Connect(function()
                    if newHrp.WeldHRP.Enabled then
                        while not newHum.Sit do task.wait() end
                        newHum.Sit = false
                        newHum.AutoRotate = true
                        newHum.HipHeight = 1
                        while newHrp.WeldHRP.Enabled and task.wait() do 
                            newHead.CFrame = newHrp.CFrame + Vector3.new(0, 1.35, 0) 
                        end
                        newHum.HipHeight = 0
                    end
                end)
                
                for _, v in pairs(newChar:GetChildren()) do
                    if v:IsA("BasePart") and v:FindFirstChild("BallSocketConstraint") and v.Name ~= "Head" then
                        v.BallSocketConstraint.Enabled = false
                        if v:FindFirstChild("RagdollLimbPart") then
                            v.RagdollLimbPart.WeldConstraint.Enabled = false
                        end
                    end
                end
            end)
        else
            local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
            for _, v in pairs(char:GetChildren()) do
                if v:IsA("BasePart") and v:FindFirstChild("BallSocketConstraint") and v.Name ~= "Head" then
                    v.BallSocketConstraint.Enabled = false
                    if v:FindFirstChild("RagdollLimbPart") then
                        v.RagdollLimbPart.WeldConstraint.Enabled = true
                    end
                end
            end
            
            -- ИСПРАВЛЕНО: Правильный синтаксис отключения коннектов без склеивания в одну строку
            Disc("AGHead")
            Disc("AGRagdoll")
            Disc("AGWeld")
            Disc("AGChar")
            Disc("AGHeadNew")
            Disc("AGRagdollNew")
            Disc("AGWeldNew")
        end
    end 
})

--// ОБЪЯВЛЕНИЕ ПЕРЕМЕННОЙ ДЛЯ ПОДКЛЮЧЕНИЯ (чтобы не было ошибок в области видимости)
local antipcon = antipcon

Section:AddToggle({
    Name = "Anti Paint",
    Flag = "AntiPaintUniqueFlag", -- ИСПРАВЛЕНО: Добавлен уникальный флаг, чтобы кнопка нажималась
    Default = false,
    Callback = function(v)
        if v then
            -- Отслеживание появления новых объектов краски
            antipcon = workspace.DescendantAdded:Connect(function(d)
                if d.Name == "PaintPlayerPart" then
                    task.wait(0.1)
                    if d and d.Parent then
                        pcall(function() d:Destroy() end)
                    end
                end
            end)
            
            -- Удаление уже существующей краски на карте
            for i, part in pairs(workspace:GetDescendants()) do
                -- ИСПРАВЛЕНО: Исправлена опечатка с PainPlayerPart на PaintPlayerPart
                if part.Name == "PaintPlayerPart" then
                    pcall(function() part:Destroy() end)
                end
            end
        else
            -- Безопасное отключение при выключении тоггла
            if antipcon then
                antipcon:Disconnect()
                antipcon = nil
            end
        end
    end
})

-- Инициализируем внешние таблицы/объекты, если они не были созданы ранее
local etc = etc or { LastSeat = nil }
local IsHeld = IsHeld or { Value = false } -- Замените на ваш реальный BoolValue, если это объект в игре

Section:AddToggle({
    Name = "Train Gucci",
    Default = false,
    Flag = "TrainExploitToggle",
    Callback = function(v)
        -- Оборачиваем код в поток, чтобы предотвратить визуальное зависание тоггла в UI
        task.spawn(function()
            -- Перепроверяем наличие персонажа при каждом клике
            local char = plr.Character or plr.CharacterAdded:Wait()
            local hrp = char:WaitForChild("HumanoidRootPart", 5)
            local hum = char:WaitForChild("Humanoid", 5)
            
            if not hrp or not hum then return end
            
            if v then
                -- Сохраняем текущую позицию (Pivot) игрока
                local oldCF = char:GetPivot()
                local Train, Seat
                
                -- Ищем модель поезда в Workspace
                local mapObjects = workspace:FindFirstChild("Map")
                    and workspace.Map:FindFirstChild("AlwaysHereTweenedObjects")
                    and workspace.Map.AlwaysHereTweenedObjects:FindFirstChild("Train")
                    and workspace.Map.AlwaysHereTweenedObjects.Train:FindFirstChild("Object")
                
                if mapObjects then
                    Train = mapObjects:FindFirstChild("ObjectModel")
                end
                
                if not Train then 
                    warn("BetterOrion Log: Модель поезда не найдена!")
                    return 
                end 
                
                -- Перебираем доступные свободные сиденья
                for _, SeatRandom in pairs(Train:GetChildren()) do 
                    if SeatRandom:IsA("Seat") and SeatRandom.Name == "Seat" and SeatRandom.Occupant == nil and SeatRandom ~= etc.LastSeat then 
                        etc.LastSeat = SeatRandom 
                        Seat = SeatRandom
                        break 
                    end                 
                end
                
                if not Seat then 
                    warn("BetterOrion Log: Свободных сидений нет!")
                    return 
                end 
                
                -- Сажаем игрока на найденное место
                Seat:Sit(hum)
                
                -- Отправляем спам-запрос на Ragdoll в отдельном потоке
                task.spawn(function()
                    local endTime = tick() + 0.5
                    -- Проверяем, активен ли еще тоггл во время цикла
                    while tick() < endTime and BetterOrion.Flags["TrainExploitToggle"].Value do
                        local ragdollRemote = game:GetService("ReplicatedStorage"):FindFirstChild("CharacterEvents") 
                            and game.ReplicatedStorage.CharacterEvents:FindFirstChild("RagdollRemote")
                        if ragdollRemote then
                            ragdollRemote:FireServer(hrp, 0)
                        end
                        task.wait()
                    end
                end)
                
                task.wait()
                
                -- Безопасное ожидание посадки или удержания (не вешает UI Orion)
                while (not hum.SeatPart or IsHeld.Value) and BetterOrion.Flags["TrainExploitToggle"].Value do 
                    task.wait() 
                end
                
                -- Если во время ожидания тоггл отключили, прерываем логику телепортации назад
                if not BetterOrion.Flags["TrainExploitToggle"].Value then return end
                
                hum.Sit = false
                task.wait()
                
                -- Возвращаем игрока на исходную позицию
                for _ = 1, 3 do 
                    char:PivotTo(oldCF)
                    task.wait() -- Небольшая задержка, чтобы Roblox успел обработать физику PivotTo
                end
            else
                -- Блок деактивации (срабатывает, когда переключатель переводят в false)
                hum.Sit = false
            end
        end)
    end    
})
-- Создаем переменную для хранения потока проверки высоты
local antiVoidLoop = nil

Section:AddToggle({
    Name = "Anti Void",
    Default = false,
    Flag = "AntiVoidToggle",
    Callback = function(v)
        if v then
            -- Отключаем стандартную смерть от пустоты
            workspace.FallenPartsDestroyHeight = 0/0
            
            -- Запускаем цикл отслеживания высоты в отдельном потоке
            antiVoidLoop = task.spawn(function()
                while BetterOrion.Flags["AntiVoidToggle"].Value do
                    local char = plr.Character or plr.CharacterAdded:Wait()
                    local hrp = char:FindFirstChild("HumanoidRootPart")
                    local hum = char:FindFirstChild("Humanoid")
                    
                    -- Если игрок жив и его HRP существует
                    if hrp and hum and hum.Health > 0 then
                        -- Если упали ниже -80 блоков (можно настроить под игру)
                        if hrp.Position.Y < -80 then 
                            -- Сбрасываем скорость падения, чтобы не улететь вниз снова
                            hrp.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                            
                            -- Телепортируем наверх (текущие X и Z, но высота Y = 100)
                            -- Прибавляем Vector3.new(0, 100, 0) к позиции или задаем жестко:
                            hrp.CFrame = CFrame.new(hrp.Position.X, 100, hrp.Position.Z)
                            
                            -- Небольшая задержка, чтобы физика Roblox успела сработать
                            task.wait(0.2)
                        end
                    end
                    task.wait(0.1) -- Оптимальная задержка проверки (10 раз в секунду)
                end
            end)
        else
            -- При выключении возвращаем стандартную высоту смерти
            workspace.FallenPartsDestroyHeight = -100
            
            -- Останавливаем цикл, если он был запущен
            if antiVoidLoop then
                task.cancel(antiVoidLoop)
                antiVoidLoop = nil
            end
        end
    end
})



-- ==========================================================
-- Инициализация таблиц совместимости (если их нет в начале скрипта)
-- ==========================================================
local cons = cons or {}
cons.disc = cons.disc or function(self, name) 
    if cons[name] then 
        if type(cons[name]) == "userdata" or (type(cons[name]) == "table" and cons[name].Disconnect) then
            cons[name]:Disconnect() 
        end
        cons[name] = nil 
    end 
end
cons.cancel = cons.cancel or function(self, name) 
    if cons[name] then 
        if type(cons[name]) == "thread" then
            task.cancel(cons[name]) 
        end
        cons[name] = nil 
    end 
end

-- Добавляем элемент строго в объект Секции (например, Section:AddButton)
Section:AddButton({
    Name = "Delete Legs",
    Callback = function()
        -- Оборачиваем выполнение в отдельный поток, чтобы кнопка Orion нажималась плавно
        task.spawn(function()
            -- Перепроверяем актуальность частей персонажа при нажатии
            local char = plr.Character or plr.CharacterAdded:Wait()
            local hrp = char:WaitForChild("HumanoidRootPart", 5)
            local hum = char:WaitForChild("Humanoid", 5)
            
            local ll, rl = char:FindFirstChild("Left Leg"), char:FindFirstChild("Right Leg")
            if not ll or not rl or not hrp or not hum then return end 
            
            local oldCF = char:GetPivot()
            local oldFal = workspace.FallenPartsDestroyHeight
            
            -- Пример пути к вашему RagdollRemote (если он не объявлен глобально)
            local RagdollRemote = game:GetService("ReplicatedStorage"):FindFirstChild("CharacterEvents") 
                and game.ReplicatedStorage.CharacterEvents:FindFirstChild("RagdollRemote") 
                or _G.RagdollRemote
            
            if not RagdollRemote then 
                warn("BetterOrion Error: RagdollRemote не найден!")
                return 
            end
            
            workspace.FallenPartsDestroyHeight = -50000
            RagdollRemote:FireServer(hrp, 1)
            task.wait(0.5)
            
            -- Сбрасываем ноги под карту
            rl.CFrame = CFrame.new(0, -60000, 0)
            ll.CFrame = CFrame.new(0, -60000, 0)
            task.wait(0.1)
            
            char:PivotTo(CFrame.new(0, -55970, 0))
            task.wait(0.1)
            
            char:PivotTo(oldCF)
            workspace.FallenPartsDestroyHeight = oldFal
            
            -- Цикл динамического изменения HipHeight в зависимости от интерфейса игры
            task.delay(0.3, function()
                while task.wait() do 
                    -- Проверяем, не возродился ли персонаж и не отросли ли ноги заново
                    if not hum or hum.Health == 0 or char:FindFirstChild("Right Leg") then break end
                    
                    local controlsGui = plr.PlayerGui:FindFirstChild("ControlsGui")
                    if controlsGui and controlsGui.PCFrame.Stand.Visible == false then
                        hum.HipHeight = 2
                    else
                        hum.HipHeight = 0
                    end
                end
            end)
        end)
    end    
})

-- Обязательно укажите глобальные переменные для игроков
local Players = game:GetService("Players")
local Player = Players.LocalPlayer

local hookBurnConn = nil
local charAddedConn = nil -- Дополнительное подключение для отслеживания респавна

local function hookBurn(char)
    if not char then return end
    
    local hum = char:WaitForChild("Humanoid", 10)
    local hrp = char:WaitForChild("HumanoidRootPart", 10)
    if not hum or not hrp then return end
    
    char.PrimaryPart = hrp
    
    -- Ищем значение FireDebounce
    local fireDebounce = hum:WaitForChild("FireDebounce", 5)
    if not fireDebounce then return end
    
    -- Очищаем старое событие перед созданием нового
    if hookBurnConn then
        hookBurnConn:Disconnect()
        hookBurnConn = nil
    end
    
    hookBurnConn = fireDebounce.Changed:Connect(function(isBurning)
        if isBurning then
            local oldCF = hrp.CFrame
            local plots = workspace:FindFirstChild("Plots")
            
            -- Проверяем наличие Plot2 динамически, чтобы скрипт не ломался
            if plots and plots:FindFirstChild("Plot2") then
                local plot2 = plots.Plot2
                local barrier = plot2:FindFirstChild("Barrier")
                local pb = barrier and barrier:FindFirstChild("PlotBarrier")
                
                if pb and pb:IsA("BasePart") then
                    -- Телепортация в безопасную зону
                    local safeCF = pb.CFrame * CFrame.new(0, 6, 0)
                    char:SetPrimaryPartCFrame(safeCF)
                    task.wait(0.3)
                    
                    -- Тушение огня и отключение эффектов
                    local firePart = char:FindFirstChild("FirePlayerPart", true)
                    if firePart then
                        for _, obj in ipairs(firePart:GetChildren()) do
                            if obj:IsA("Sound") then
                                obj:Stop()
                            elseif obj:IsA("Light") or obj:IsA("ParticleEmitter") then
                                obj.Enabled = false
                            end
                        end
                        if firePart:FindFirstChild("CanBurn") then
                            firePart.CanBurn.Value = false
                        end
                        if hum:FindFirstChild("FireDebounce") then
                            hum.FireDebounce.Value = false
                        end
                    end
                    
                    task.wait(0.6)
                    -- Возвращение на исходную позицию
                    if char and char.PrimaryPart then
                        char:SetPrimaryPartCFrame(oldCF)
                    end
                end
            end
        end
    end)
end


Section:AddToggle({
    Name = "Anti Burn",
    Default = false,
    Callback = function(on)
        -- Переменную глобального стейта сохраняем, только если функция SetToggleState существует
        if _G.SetToggleState then 
            _G.SetToggleState("Anti Burn", on) 
        end
        
        if on then
            -- Запускаем на текущего персонажа
            if Player.Character then
                hookBurn(Player.Character)
            end
            -- Настраиваем авто-запуск при смерти/возрождении (Респавне)
            charAddedConn = Player.CharacterAdded:Connect(function(newChar)
                hookBurn(newChar)
            end)
        else
            -- Полная очистка всех хуков и соединений при выключении тогла
            if hookBurnConn then
                hookBurnConn:Disconnect()
                hookBurnConn = nil
            end
            if charAddedConn then
                charAddedConn:Disconnect()
                charAddedConn = nil
            end
        end
    end
})

local antiStickyT = false

-- 2. Создание тоггла (используем стандартный для Orion/BetterOrion метод AddToggle)
Section:AddToggle({
	Name = "Anti Sticky",
   
	Default = false,
	Callback = function(Value)
        -- Безопасный вызов внешней функции, чтобы скрипт не ломался, если её нет
        if _G.SetToggleState then
            _G.SetToggleState("Anti Sticky", Value)
        end
        
		antiStickyT = Value
        
		-- Безопасный поиск папки скриптов и переключение лимитера липкости
        local playerScripts = Player:FindFirstChild("PlayerScripts")
		if playerScripts then
            local touchDetection = playerScripts:FindFirstChild("StickyPartsTouchDetection")
            if touchDetection and touchDetection:IsA("LocalScript") then
                touchDetection.Disabled = Value
            end
		end
	end,
})

-- 3. Безопасная работа с GrabEvents (сохраняем прямые ссылки вместо вызова краша через :Clone())
local createGrabLineCopy, extendGrabLineCopy
local grabFolder = ReplicatedStorage:FindFirstChild("GrabEvents")

if grabFolder then
	local originalCreate = grabFolder:FindFirstChild("CreateGrabLine")
	local originalExtend = grabFolder:FindFirstChild("ExtendGrabLine")
    
	if originalCreate then
		createGrabLineCopy = originalCreate
	end
	if originalExtend then
		extendGrabLineCopy = originalExtend
	end
end
Section:AddButton({
    Name = "Destroy Gucci (blob)",
    Callback = function()
        -- Проверка наличия глобальных или локальных функций
        local blob = (typeof(FindBlob) == "function" and FindBlob()) or (typeof(SpawnToy) == "function" and SpawnToy("CreatureBlobman"))
        if not blob then return end 
        
        -- Переменные вашего персонажа (должны быть объявлены глобально или определяем на лету)
        local char = game.Players.LocalPlayer.Character
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        if not char or not hum then return end
        
        local oldCF = char:GetPivot()
        
        -- Проверка цели
        if not selectedPlrName then return end
        etc.TargetPLR = game.Players:FindFirstChild(selectedPlrName)
        if not etc.TargetPLR or not etc.TargetPLR.Character then return end 
        
        etc.Root = etc.TargetPLR.Character:FindFirstChild("HumanoidRootPart")
        etc.Hum = etc.TargetPLR.Character:FindFirstChild("Humanoid")
        if not etc.Root or not etc.Hum then return end
        
        etc["Root"].Massless = false 
        
        -- Безопасный вызов FWD для сиденья
        local vehicleSeat = FWD(blob, "VehicleSeat")
        if vehicleSeat and vehicleSeat:IsA("VehicleSeat") then
            vehicleSeat:Sit(hum)
        else
            return -- Если сиденья нет, выходим во избежание ошибки
        end
        
        -- Безопасный цикл ожидания посадки с предохранителем от вечного зависания
        local timeout = 0
        while not hum.SeatPart and timeout < 100 do 
            task.wait() 
            timeout = timeout + 1
        end 
        if timeout >= 100 then return end -- Не смогли сесть — прекращаем атаку
        
        -- Поиск скриптов и удаленных событий
        local scriptFolder = FWD(blob, "BlobmanSeatAndOwnerScript")
        if not scriptFolder then return end
        
        local CreatureGrab = FWD(scriptFolder, "CreatureGrab")
        local CreatureRelease = FWD(scriptFolder, "CreatureRelease")
        local RightDetector = FWD(blob, "RightDetector")
        local RightWeld = RightDetector and FWD(RightDetector, "RightWeld")
        
        if not CreatureGrab or not CreatureRelease or not RightDetector then return end
        
        -- Телепортация капли к цели
        blob:PivotTo(etc["Root"].CFrame)
        task.wait(0.15)
        
        -- Цикл отправки сетевых запросов (Спам-атака)
        for _ = 1, 15 do 
            CreatureGrab:FireServer(RightDetector, etc.Root, RightWeld)
            CreatureRelease:FireServer(RightWeld, etc["Root"])
            etc["Root"].Massless = false  
            
            for _ = 1, 10 do 
                etc["Hum"].Sit = true
            end
            task.wait()
        end
        
        -- Возвращение на исходную позицию
        if char then
            char:PivotTo(oldCF)
        end
    end    
})


Section:AddToggle({
    Name = "Destroy barrier",
    Default = false,
    Callback = function(Value)
        megaBypassActive = Value
        
        -- Локальная функция отключения/включения барьеров
        local function disablePlotBarriers()
            local plotsFolder = Workspace:FindFirstChild("Plots")
            if not plotsFolder then
                notify("Error", "Plots folder not found!", 3)
                return
            end
            
            local barrierCount = 0
            for _, plot in ipairs(plotsFolder:GetDescendants()) do
                if plot:IsA("BasePart") and plot.Name == "PlotBarrier" then
                    -- Если тоггл включен — коллизия выключается (false), если выключен — включается (true)
                    plot.CanCollide = not megaBypassActive
                    plot.CanTouch = not megaBypassActive
                    plot.CanQuery = not megaBypassActive
                    barrierCount = barrierCount + 1
                end
            end
            
            if megaBypassActive then
                notify("Success", barrierCount .. " plot barriers disabled.", 3)
            else
                notify("Success", "Plot barriers restored.", 3)
            end
        end

        -- Локальная функция выполнения гамбургер-телепорта
        local function hamburgerTeleport()
            local char = Player.Character or Player.CharacterAdded:Wait()
            local hrp = char:FindFirstChild("HumanoidRootPart")
            if not hrp then
                notify("Error", "HumanoidRootPart not found!", 3)
                return
            end

            local originalCFrame = hrp.CFrame
            local MenuToys = RS:FindFirstChild("MenuToys")
            local SpawnToyRemoteFunction = MenuToys and MenuToys:FindFirstChild("SpawnToyRemoteFunction")
            if not SpawnToyRemoteFunction then
                notify("Error", "SpawnToyRemoteFunction not found!", 3)
                return
            end

            -- Спавн гамбургера
            SpawnToyRemoteFunction:InvokeServer("FoodHamburger", hrp.CFrame, Vector3.zero)

            local spawnedToys = Workspace:FindFirstChild(Player.Name .. "SpawnedInToys")
            if not spawnedToys then
                notify("Error", "SpawnedInToys folder not found!", 3)
                return
            end

            local FoodHamburger = spawnedToys:WaitForChild("FoodHamburger", 5)
            if not FoodHamburger then
                notify("Error", "Hamburger object not found!", 3)
                return
            end

            local HoldPart = FoodHamburger:FindFirstChild("HoldPart")
            local HoldItemRemoteFunction = HoldPart and HoldPart:FindFirstChild("HoldItemRemoteFunction")
            if not HoldItemRemoteFunction then
                notify("Error", "HoldItemRemoteFunction not found!", 3)
                return
            end

            -- Экипировка
            HoldItemRemoteFunction:InvokeServer(FoodHamburger, char)

            local plotsFolder = Workspace:FindFirstChild("Plots")
            local plot3 = plotsFolder and plotsFolder:FindFirstChild("Plot3")
            local plotArea = plot3 and plot3:FindFirstChild("PlotArea")
            if not plotArea then
                notify("Error", "Plot area not found!", 3)
                return
            end

            -- Телепортация
            hrp.CFrame = plotArea.CFrame
            task.wait(0.1)
            hrp.CFrame = originalCFrame

            -- Очистка
            local DestroyToy = MenuToys and MenuToys:FindFirstChild("DestroyToy")
            if DestroyToy then
                DestroyToy:FireServer(FoodHamburger)
            end

            notify("Success", "Teleport loop executed!", 3)
        end

        -- Логика переключения
        if Value then
            -- Выполняем отключение барьеров
            pcall(disablePlotBarriers)
            
            -- Запускаем цикл телепортации в отдельном безопасном потоке task
            task.spawn(function()
                while megaBypassActive do
                    pcall(hamburgerTeleport)
                    task.wait(3) -- Задержка цикла телепорта (в секундах)
                end
            end)
        else
            -- Возвращаем барьеры в исходное твердое состояние при выключении кнопки
            pcall(disablePlotBarriers)
        end
    end
    })
     Section:AddToggle({
     Name = "AntiBarrier",
        Default = false,
       
         Default = false,
    Callback = function(val)
        for i,v in pairs(workspace.Plots:GetChildren()) do
            if v:FindFirstChild("Barrier") then
                for i,v in pairs(v.Barrier:GetChildren()) do
                    if v:IsA("Part") then
                        v.CanCollide = not val
                    end
                end
            end
        end
    end
})
Section:AddToggle({
    Name = "Anti Lag",
    Default = false,
    Callback = function(v)
        Lines = 0
        plr.PlayerScripts.CharacterAndBeamMove.Enabled = not v
    end
})
local Tab = Window:MakeTab({Name = "Target", Icon = "person"})
local Section = Tab:AddSection({Name = "Main", Side = "Left"})

local PS = game:GetService("Players")
local Player = PS.LocalPlayer
local selectedKickPlayer = nil -- Ваша переменная для захвата/кика

-- Функция создания актуального списка игроков
local function updatePlayerList()
    local list = {}
    for _, plr in ipairs(PS:GetPlayers()) do
        if plr ~= Player then
            table.insert(list, plr.DisplayName .. " (" .. plr.Name .. ")")
        end
    end
    table.sort(list) -- Сортируем для точного сравнения таблиц
    if #list == 0 then
        table.insert(list, "Нет игроков")
    end
    return list
end

-- Функция проверки изменений на сервере
local function tablesMatch(t1, t2)
    if #t1 ~= #t2 then return false end
    for i, v in ipairs(t1) do
        if v ~= t2[i] then return false end
    end
    return true
end

-- Функция получения объекта игрока
local function getPlayerFromSelection(selection)
    if not selection or selection == "Нет игроков" or selection == "Выбрать..." or selection == "" then
        return nil
    end
    local username = selection:match("%((.-)%)") 
    if username then
        return PS:FindFirstChild(username)
    end
    return nil
end

-- Кешируем изначальный список
local lastPlayerList = updatePlayerList()
local PlayerDropdown

-- Добавление Дропдауна внутрь вашей секции Section
PlayerDropdown = Section:AddDropdown({
    Name = "Select Player",
    Options = lastPlayerList,
    Default = "Выбрать...",
    Multi = false,
    MaxSize = 25,                     
    Search = true,                    
    Flag = "PlayerDropdownFlag",      
    Callback = function(Value)
        -- ЗАЩИТА ОТ ВЫЛЕТА ПРИ ЗАКРЫТИИ:
        -- Если BetterOrion пытается передать пустоту или сбросить текст меню при закрытии,
        -- мы просто игнорируем это действие и не перезаписываем выбранного игрока!
        if Value == nil or Value == "" or Value == "Выбрать..." then 
            return 
        end
        
        local target = getPlayerFromSelection(Value)
        if target then
            selectedKickPlayer = target
            print("Успешно закреплен игрок:", selectedKickPlayer.Name)
        end
    end
})

-- Функция умного обновления UI (только если кто-то зашел/вышел)
local function safeRefresh()
    if PlayerDropdown then
        local newList = updatePlayerList()
        
        -- Если состав сервера не изменился — не трогаем UI (защита от сброса)
        if tablesMatch(lastPlayerList, newList) then 
            return 
        end
        
        lastPlayerList = newList
        PlayerDropdown:Refresh(newList, true)
        
        -- Если выбранный игрок вышел с сервера, только тогда обнуляем его
        if selectedKickPlayer and not PS:FindFirstChild(selectedKickPlayer.Name) then
            selectedKickPlayer = nil
            PlayerDropdown:Set("Выбрать...")
        end
    end
end

-- Автоматика мгновенного реагирования на изменения сервера
PS.PlayerAdded:Connect(safeRefresh)
PS.PlayerRemoving:Connect(function(plr)
    if selectedKickPlayer == plr then
        selectedKickPlayer = nil
        PlayerDropdown:Set("Выбрать...")
    end
    safeRefresh()
end)

-- Фоновый поток проверки (не сбрасывает кликнутый выбор)
task.spawn(function()
    while true do
        task.wait(3) 
        safeRefresh()
    end
end)


PCLD = {
    Enabled = false,
    Boxes = {},
    NameTags = {},
    Connections = {}
}

Section:AddToggle({
    Name = "PCLD ESP",
    Default = false,
    Callback = function(State)
        PCLD.Enabled = State
        
        if State then
            for _, box in pairs(PCLD.Boxes) do
                if box and box.Parent then
                    box:Destroy()
                end
            end
            for _, tag in pairs(PCLD.NameTags) do
                if tag and tag.Parent then
                    tag:Destroy()
                end
            end
            for _, conn in pairs(PCLD.Connections) do
                conn:Disconnect()
            end
            
            PCLD.Boxes = {}
            PCLD.NameTags = {}
            PCLD.Connections = {}
            
            local debounce = {}
            local function createOrUpdatePlayerESP(player)
                if player == game.Players.LocalPlayer then return end
                if debounce[player] then return end
                debounce[player] = true
                
                for i, box in pairs(PCLD.Boxes) do
                    if box.Name:find(player.Name) then
                        if box.Parent then box:Destroy() end
                        PCLD.Boxes[i] = nil
                    end
                end
                
                for i, tag in pairs(PCLD.NameTags) do
                    if tag.Name:find(player.Name) then
                        if tag.Parent then tag:Destroy() end
                        PCLD.NameTags[i] = nil
                    end
                end
                
                local function setupESP(character)
                    if not character or not character.Parent then 
                        task.wait(0.1)
                        debounce[player] = nil
                        return 
                    end
                    
                    local head = character:WaitForChild("Head", 2)
                    if not head then 
                        task.wait(0.1)
                        debounce[player] = nil
                        return 
                    end
                    
                    local highlight = Instance.new("Highlight")
                    highlight.Name = "ESP_Highlight_" .. player.Name
                    highlight.Adornee = character
                    highlight.FillColor = Color3.fromRGB(180, 0, 255)
                    highlight.FillTransparency = 0.7
                    highlight.OutlineColor = Color3.fromRGB(180, 0, 255)
                    highlight.OutlineTransparency = 0.3
                    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                    highlight.Parent = character
                    
                    table.insert(PCLD.Boxes, highlight)
                    
                    local billboard = Instance.new("BillboardGui")
                    billboard.Name = "ESP_Name_" .. player.Name
                    billboard.Adornee = head
                    billboard.Size = UDim2.new(0, 200, 0, 40)
                    billboard.StudsOffset = Vector3.new(0, 3.5, 0)
                    billboard.AlwaysOnTop = true
                    billboard.MaxDistance = math.huge
                    billboard.Enabled = true
                    billboard.Parent = head
                    
                    local nameLabel = Instance.new("TextLabel")
                    nameLabel.Size = UDim2.new(1, 0, 1, 0)
                    nameLabel.BackgroundTransparency = 0.5
                    nameLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                    nameLabel.Text = player.DisplayName .. " | " .. player.Name
                    nameLabel.TextColor3 = Color3.fromRGB(180, 0, 255)
                    nameLabel.TextStrokeTransparency = 0
                    nameLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
                    nameLabel.Font = Enum.Font.SourceSansBold
                    nameLabel.TextSize = 18
                    nameLabel.TextScaled = false
                    nameLabel.Parent = billboard
                    
                    table.insert(PCLD.NameTags, billboard)
                    
                    local conn = character.AncestryChanged:Connect(function(_, parent)
                        if not parent then
                            if PCLD.Enabled then
                                task.wait(0.5)
                                debounce[player] = nil
                                createOrUpdatePlayerESP(player)
                            end
                        end
                    end)
                    
                    table.insert(PCLD.Connections, conn)
                    
                    local humanoid = character:FindFirstChild("Humanoid")
                    if humanoid then
                        local diedConn = humanoid.Died:Connect(function()
                            task.wait(2)
                            if PCLD.Enabled then
                                debounce[player] = nil
                                createOrUpdatePlayerESP(player)
                            end
                        end)
                        
                        table.insert(PCLD.Connections, diedConn)
                    end
                    
                    debounce[player] = nil
                end
                
                if player.Character then
                    setupESP(player.Character)
                else
                    local charAddedConn = player.CharacterAdded:Connect(function(character)
                        task.wait(1)
                        if PCLD.Enabled then
                            debounce[player] = nil
                            createOrUpdatePlayerESP(player)
                        end
                    end)
                    
                    table.insert(PCLD.Connections, charAddedConn)
                end
            end
            
            local function setupPCLDDetection()
                local processed = {}
                
                local function createPCLDBox(obj)
                    if not obj or not obj.Parent or processed[obj] then return end
                    processed[obj] = true
                    
                    local posY = obj.Position.Y
                    local spawnPos = Vector3.new(3, -7, -2)
                    local distanceFromSpawn = (obj.Position - spawnPos).Magnitude
                    
                    if posY >= 5 and posY <= 9 and distanceFromSpawn <= 15 then
                        return
                    end
                    
                    local box = Instance.new("BoxHandleAdornment")
                    box.Name = "PCLD_Box_" .. obj.Name
                    box.Adornee = obj
                    box.AlwaysOnTop = true
                    box.ZIndex = 5
                    box.Size = obj.Size * 1.05
                    box.Color3 = Color3.fromRGB(180, 0, 255)
                    box.Transparency = 0.5
                    box.Parent = obj
                    
                    table.insert(PCLD.Boxes, box)
                    
                    local conn = obj.AncestryChanged:Connect(function(_, parent)
                        if not parent then
                            processed[obj] = nil
                            if box.Parent then
                                box:Destroy()
                            end
                        end
                    end)
                    
                    table.insert(PCLD.Connections, conn)
                end
                
                for _, obj in pairs(workspace:GetChildren()) do
                    if obj:IsA("BasePart") then
                        local name = obj.Name:lower()
                        if name:find("playercharacterlocationdetector") or 
                           name:find("characterdetector") or
                           name:find("partesp") then
                            createPCLDBox(obj)
                        end
                    end
                end
                
                local pcldConn = workspace.DescendantAdded:Connect(function(obj)
                    if obj:IsA("BasePart") then
                        local name = obj.Name:lower()
                        if name:find("playercharacterlocationdetector") or 
                           name:find("characterdetector") or
                           name:find("partesp") then
                            task.wait(0.1)
                            createPCLDBox(obj)
                        end
                    end
                end)
                
                table.insert(PCLD.Connections, pcldConn)
            end
            
            task.spawn(function()
                for _, player in pairs(game:GetService("Players"):GetPlayers()) do
                    if player ~= game.Players.LocalPlayer then
                        createOrUpdatePlayerESP(player)
                        task.wait(0.3)
                    end
                end
            end)
            
            task.delay(1, setupPCLDDetection)
            
            local playerAddedConn = game:GetService("Players").PlayerAdded:Connect(function(player)
                task.wait(2)
                if PCLD.Enabled then
                    createOrUpdatePlayerESP(player)
                end
            end)
            
            table.insert(PCLD.Connections, playerAddedConn)
            
            local playerRemovingConn = game:GetService("Players").PlayerRemoving:Connect(function(player)
                for i, box in pairs(PCLD.Boxes) do
                    if box.Name:find(player.Name) then
                        if box.Parent then box:Destroy() end
                        PCLD.Boxes[i] = nil
                    end
                end
                
                for i, tag in pairs(PCLD.NameTags) do
                    if tag.Name:find(player.Name) then
                        if tag.Parent then tag:Destroy() end
                        PCLD.NameTags[i] = nil
                    end
                end
            end)
            
            table.insert(PCLD.Connections, playerRemovingConn)
            
           
        else
            for _, box in pairs(PCLD.Boxes) do
                if box and box.Parent then
                    box:Destroy()
                end
            end
            for _, tag in pairs(PCLD.NameTags) do
                if tag and tag.Parent then
                    tag:Destroy()
                end
            end
            for _, conn in pairs(PCLD.Connections) do
                conn:Disconnect()
            end
            
            PCLD.Boxes = {}
            PCLD.NameTags = {}
            PCLD.Connections = {}
            
            BetterOrion:MakeNotification({
                Title = "PCLD ESP",
                Content = "Выключен",
                Image = "eye-off",
                Time = 2,
            })
        end
    end
})
Section:AddToggle({
    Name = "ragdoll",
    Default = false,
Callback = function(on)
    if not on then 
        ragdollEnabled = false
        local MyToys = workspace:FindFirstChild(Player.Name.."SpawnedInToys")
        if MyToys then
            for _, toy in pairs(MyToys:GetChildren()) do
                if toy.Name == "PalletLightBrown" then
                    pcall(function() ReplicatedStorage.MenuToys.DestroyToy:FireServer(toy) end)
                end
            end
        end
        return 
    end
    
    ragdollEnabled = true
    
    task.spawn(function()
        local RS = game:GetService("ReplicatedStorage")
        local SetNetOwner = RS:WaitForChild("GrabEvents"):FindFirstChild("SetNetworkOwner")
        local HIDDEN_CF = CFrame.new(0, 5005, 0)
        local pallet, soundPart, lastSpawnTime = nil, nil, 0
        
        while ragdollEnabled do
            if tick() - lastSpawnTime >= 4 or not pallet or not pallet.Parent then
                if pallet and pallet.Parent then
                    pcall(function() RS.MenuToys.DestroyToy:FireServer(pallet) end)
                end
                RS.MenuToys.SpawnToyRemoteFunction:InvokeServer("PalletLightBrown", HIDDEN_CF, Vector3.new(0, -90, 0)) 
                task.wait(0.05)
                local MyToys = workspace:FindFirstChild(Player.Name.."SpawnedInToys") 
                local p = MyToys and MyToys:FindFirstChild("PalletLightBrown")
                if p then 
                    for _, part in pairs(p:GetDescendants()) do 
                        if part:IsA("BasePart") then part.Massless = true part.CanCollide = false part.Transparency = 1 end 
                    end
                    pallet, soundPart = p, p:FindFirstChild("SoundPart")
                    lastSpawnTime = tick()
                end
            end
            
            if pallet and soundPart and pallet.Parent then
                local target = selectedKickPlayer
                if target and target.Parent then
                    local tChar = target.Character 
                    local torso = tChar and (tChar:FindFirstChild("UpperTorso") or tChar:FindFirstChild("Torso"))
                    if torso then
                        for _, part in pairs(pallet:GetDescendants()) do
                            if part:IsA("BasePart") then
                                pcall(function()
                                    SetNetOwner:FireServer(part, part.CFrame)
                                    local po = part:FindFirstChild("PartOwner")
                                    if po then po.Value = Player.Name end
                                end)
                            end
                        end
                        soundPart.CFrame = torso.CFrame
                        task.wait()
                        soundPart.CFrame = HIDDEN_CF
                    end
                end
            end
            task.wait()
        end
        
        if pallet and pallet.Parent then
            pcall(function() RS.MenuToys.DestroyToy:FireServer(pallet) end)
        end
        ragdollEnabled = false
    end)
end})



















Section:AddDropdown({
    Name = "Режим кика",
    Options = {"Fast", "Normal", "Slow"},
    Default = "Normal",
    Callback = function(option)
        SelectedKickMode = option
    end
})

Section:AddToggle({
    Name = "Kick",
    Default = false,
    Callback = function(on)
        kickLoopEnabled = on

        if not on then
            normalKickTimer = nil
            slowKickTimer = nil
            fastKickTimer = nil
            normalGrabCounter = 0
            slowGrabCounter = 0
            fastGrabCounter = 0
            normalOwnerCounter = 0
            slowOwnerCounter = 0
            fastOwnerCounter = 0

            task.spawn(function()
                if selectedKickPlayer and selectedKickPlayer.Character then
                    local targetRoot = selectedKickPlayer.Character:FindFirstChild("HumanoidRootPart")
                    if targetRoot then
                        pcall(function()
                            local GrabEvents = ReplicatedStorage:WaitForChild("GrabEvents")
                            GrabEvents.DestroyGrabLine:FireServer(targetRoot)
                        end)
                    end
                end
            end)
            return
        end

        if not selectedKickPlayer then
            BetterOrion:MakeNotification({
                Title = "Ошибка",
                Content = "Сначала выберите игрока!",
                Image = "alert-triangle",
                Time = 3
            })
            return
        end

        task.spawn(function()
            local GrabEvents = ReplicatedStorage:WaitForChild("GrabEvents")
            local SetNetworkOwner = GrabEvents:WaitForChild("SetNetworkOwner")

            local myRoot = Player.Character and Player.Character:FindFirstChild("HumanoidRootPart")
            if not myRoot then
                kickLoopEnabled = false
                return
            end

            local anchors = {}
            local orients = {}
            local grabLineCreated = false
            local grabStartTime = 0
            local endKickPhase = false
            local pcldActive = false

            local function pcldBypass(targetRoot)
                if not targetRoot or not targetRoot.Parent then return end
                
                local detector = Instance.new("Part")
                detector.Name = "PlayerCharacterLocationDetector"
                detector.Size = Vector3.new(1, 1, 1)
                detector.CanCollide = false
                detector.Transparency = 1
                detector.Anchored = true
                detector.Position = targetRoot.Position + Vector3.new(0, -10, 0)
                detector.Parent = workspace
                
                for i = 1, 150 do
                    pcall(function()
                        SetNetworkOwner:FireServer(targetRoot, targetRoot.CFrame)
                        task.wait(0.001)
                    end)
                end
                
                task.wait(0.1)
                detector:Destroy()
                
                return true
            end

            while kickLoopEnabled do
                local target = selectedKickPlayer
                if not target or not target.Parent then
                    break
                end

                local myCharacter = Player.Character
                myRoot = myCharacter and myCharacter:FindFirstChild("HumanoidRootPart")
                if not myRoot then
                    break
                end

                local targetCharacter = target.Character
                local targetRoot = targetCharacter and targetCharacter:FindFirstChild("HumanoidRootPart")
                local targetHumanoid = targetCharacter and targetCharacter:FindFirstChild("Humanoid")

                if targetRoot and targetHumanoid and targetHumanoid.Health > 0 then
                    local distance = (myRoot.Position - targetRoot.Position).Magnitude

                    if targetRoot.Position.Y < 5 and targetRoot.Velocity.Y < -20 then
                        pcldActive = true
                        pcall(function()
                            pcldBypass(targetRoot)
                        end)
                        pcldActive = false
                    end

                    if distance > 25 then
                        myRoot.CFrame = targetRoot.CFrame * CFrame.new(0, 0, 2)
                        myRoot.Velocity = Vector3.zero
                    end

                    local targetPos = myRoot.Position + Vector3.new(0, 15, 0)

                    if targetRoot.Position.Y > 50 then
                        endKickPhase = true
                    else
                        endKickPhase = false
                    end

                    if SelectedKickMode == "Fast" then
                        if not fastKickTimer then
                            fastKickTimer = tick()
                            fastGrabCounter = 0
                            fastOwnerCounter = 0
                        end
                        if tick() - fastKickTimer >= 0.005 then
                            fastKickTimer = tick()
                            fastGrabCounter = fastGrabCounter + 1
                            fastOwnerCounter = fastOwnerCounter + 1

                            if fastOwnerCounter <= 1 then
                                for _, part in pairs(targetCharacter:GetChildren()) do
                                    if part:IsA("BasePart") then
                                        pcall(function()
                                            SetNetworkOwner:FireServer(part, part.CFrame)
                                        end)
                                    end
                                end
                            end
                            if fastOwnerCounter >= 1 then
                                fastOwnerCounter = 0
                            end

                            if fastGrabCounter <= 1 then
                                if not grabLineCreated then
                                    targetHumanoid.PlatformStand = true
                                    GrabEvents.SetNetworkOwner:FireServer(targetRoot, myRoot.CFrame)
                                    task.wait()
                                    GrabEvents.CreateGrabLine:FireServer(targetRoot, Vector3.zero, targetPos, false)
                                    grabLineCreated = true
                                    grabStartTime = tick()
                                end
                            end

                            if grabLineCreated and fastGrabCounter <= 1 then
                                pcall(function()
                                    GrabEvents.DestroyGrabLine:FireServer(targetRoot)
                                end)
                                grabLineCreated = false
                            end

                            if fastGrabCounter >= 1 then
                                fastGrabCounter = 0
                            end
                        end

                        -- УВЕЛИЧИЛ ГРАБЫ В НАЧАЛЕ И В КОНЦЕ
                        local anchorCount = endKickPhase and 500 or 50

                        while #anchors > anchorCount do
                            local a = table.remove(anchors)
                            if a and a.Parent then a:Destroy() end
                        end
                        while #orients > anchorCount do
                            local o = table.remove(orients)
                            if o and o.Parent then o:Destroy() end
                        end

                        for i = 1, anchorCount do
                            if not anchors[i] or not anchors[i].Parent then
                                if anchors[i] then anchors[i]:Destroy() end

                                local anchor = Instance.new("AlignPosition")
                                anchor.Name = "KickAnchor_" .. i
                                anchor.Mode = Enum.PositionAlignmentMode.OneAttachment
                                anchor.MaxForce = 1e12
                                anchor.MaxVelocity = 100000
                                anchor.Responsiveness = 5000

                                local att = Instance.new("Attachment", targetRoot)
                                anchor.Attachment0 = att
                                anchor.Parent = targetRoot
                                anchors[i] = anchor

                                local orient = Instance.new("AlignOrientation")
                                orient.Name = "KickOrient_" .. i
                                orient.Mode = Enum.OrientationAlignmentMode.OneAttachment
                                orient.MaxTorque = 1e12
                                orient.MaxAngularVelocity = 100000
                                orient.Responsiveness = 5000

                                local att2 = Instance.new("Attachment", targetRoot)
                                orient.Attachment0 = att2
                                orient.Parent = targetRoot
                                orients[i] = orient
                            end

                            anchors[i].Position = targetPos
                            orients[i].CFrame = targetRoot.CFrame
                        end

                    elseif SelectedKickMode == "Normal" then
                        if not normalKickTimer then
                            normalKickTimer = tick()
                            normalGrabCounter = 0
                            normalOwnerCounter = 0
                        end
                        if tick() - normalKickTimer >= 0.01 then
                            normalKickTimer = tick()
                            normalGrabCounter = normalGrabCounter + 1
                            normalOwnerCounter = normalOwnerCounter + 1

                            if normalOwnerCounter <= 1 then
                                for _, part in pairs(targetCharacter:GetChildren()) do
                                    if part:IsA("BasePart") then
                                        pcall(function()
                                            SetNetworkOwner:FireServer(part, part.CFrame)
                                        end)
                                    end
                                end
                            end
                            if normalOwnerCounter >= 1 then
                                normalOwnerCounter = 0
                            end

                            if normalGrabCounter <= 25 then
                                if not grabLineCreated then
                                    targetHumanoid.PlatformStand = true
                                    GrabEvents.SetNetworkOwner:FireServer(targetRoot, myRoot.CFrame)
                                    task.wait()
                                    GrabEvents.CreateGrabLine:FireServer(targetRoot, Vector3.zero, targetPos, false)
                                    grabLineCreated = true
                                    grabStartTime = tick()
                                end
                            end

                            if grabLineCreated and normalGrabCounter <= 25 then
                                pcall(function()
                                    GrabEvents.DestroyGrabLine:FireServer(targetRoot)
                                end)
                                grabLineCreated = false
                            end

                            if normalGrabCounter >= 25 then
                                normalGrabCounter = 0
                            end
                        end

                        -- УВЕЛИЧИЛ ГРАБЫ В НАЧАЛЕ И В КОНЦЕ
                        local anchorCount = endKickPhase and 600 or 60

                        while #anchors > anchorCount do
                            local a = table.remove(anchors)
                            if a and a.Parent then a:Destroy() end
                        end
                        while #orients > anchorCount do
                            local o = table.remove(orients)
                            if o and o.Parent then o:Destroy() end
                        end

                        for i = 1, anchorCount do
                            if not anchors[i] or not anchors[i].Parent then
                                if anchors[i] then anchors[i]:Destroy() end

                                local anchor = Instance.new("AlignPosition")
                                anchor.Name = "KickAnchor_" .. i
                                anchor.Mode = Enum.PositionAlignmentMode.OneAttachment
                                anchor.MaxForce = 1e12
                                anchor.MaxVelocity = 100000
                                anchor.Responsiveness = 5000

                                local att = Instance.new("Attachment", targetRoot)
                                anchor.Attachment0 = att
                                anchor.Parent = targetRoot
                                anchors[i] = anchor

                                local orient = Instance.new("AlignOrientation")
                                orient.Name = "KickOrient_" .. i
                                orient.Mode = Enum.OrientationAlignmentMode.OneAttachment
                                orient.MaxTorque = 1e12
                                orient.MaxAngularVelocity = 100000
                                orient.Responsiveness = 5000

                                local att2 = Instance.new("Attachment", targetRoot)
                                orient.Attachment0 = att2
                                orient.Parent = targetRoot
                                orients[i] = orient
                            end

                            anchors[i].Position = targetPos
                            orients[i].CFrame = targetRoot.CFrame
                        end

                    elseif SelectedKickMode == "Slow" then
                        if not slowKickTimer then
                            slowKickTimer = tick()
                            slowGrabCounter = 0
                            slowOwnerCounter = 0
                        end
                        if tick() - slowKickTimer >= 0.015 then
                            slowKickTimer = tick()
                            slowGrabCounter = slowGrabCounter + 1
                            slowOwnerCounter = slowOwnerCounter + 1

                            if slowOwnerCounter <= 1 then
                                for _ = 1, 2 do
                                    for _, part in pairs(targetCharacter:GetChildren()) do
                                        if part:IsA("BasePart") then
                                            pcall(function()
                                                SetNetworkOwner:FireServer(part, part.CFrame)
                                            end)
                                        end
                                    end
                                end
                            end
                            if slowOwnerCounter >= 2 then
                                slowOwnerCounter = 0
                            end

                            if slowGrabCounter <= 13 then
                                if not grabLineCreated then
                                    targetHumanoid.PlatformStand = true
                                    GrabEvents.SetNetworkOwner:FireServer(targetRoot, myRoot.CFrame)
                                    task.wait()
                                    GrabEvents.CreateGrabLine:FireServer(targetRoot, Vector3.zero, targetPos, false)
                                    grabLineCreated = true
                                    grabStartTime = tick()
                                end
                            end

                            if grabLineCreated and slowGrabCounter <= 25 then
                                pcall(function()
                                    GrabEvents.DestroyGrabLine:FireServer(targetRoot)
                                end)
                                grabLineCreated = false
                            end

                            if slowGrabCounter >= 25 then
                                slowGrabCounter = 0
                            end
                        end

                        -- УВЕЛИЧИЛ ГРАБЫ В НАЧАЛЕ И В КОНЦЕ
                        local anchorCount = endKickPhase and 700 or 70

                        while #anchors > anchorCount do
                            local a = table.remove(anchors)
                            if a and a.Parent then a:Destroy() end
                        end
                        while #orients > anchorCount do
                            local o = table.remove(orients)
                            if o and o.Parent then o:Destroy() end
                        end

                        for i = 1, anchorCount do
                            if not anchors[i] or not anchors[i].Parent then
                                if anchors[i] then anchors[i]:Destroy() end

                                local anchor = Instance.new("AlignPosition")
                                anchor.Name = "KickAnchor_" .. i
                                anchor.Mode = Enum.PositionAlignmentMode.OneAttachment
                                anchor.MaxForce = 1e12
                                anchor.MaxVelocity = 100000
                                anchor.Responsiveness = 5000

                                local att = Instance.new("Attachment", targetRoot)
                                anchor.Attachment0 = att
                                anchor.Parent = targetRoot
                                anchors[i] = anchor

                                local orient = Instance.new("AlignOrientation")
                                orient.Name = "KickOrient_" .. i
                                orient.Mode = Enum.OrientationAlignmentMode.OneAttachment
                                orient.MaxTorque = 1e12
                                orient.MaxAngularVelocity = 100000
                                orient.Responsiveness = 5000

                                local att2 = Instance.new("Attachment", targetRoot)
                                orient.Attachment0 = att2
                                orient.Parent = targetRoot
                                orients[i] = orient
                            end

                            anchors[i].Position = targetPos
                            orients[i].CFrame = targetRoot.CFrame
                        end
                    end

                    if tick() - grabStartTime > 0.2 then
                        -- защита от зависания
                    end

                else
                    grabLineCreated = false
                    grabStartTime = 0
                    endKickPhase = false

                    for _, a in pairs(anchors) do
                        if a and a.Parent then a:Destroy() end
                    end
                    anchors = {}

                    for _, o in pairs(orients) do
                        if o and o.Parent then o:Destroy() end
                    end
                    orients = {}

                    if targetRoot then
                        pcall(function()
                            GrabEvents.DestroyGrabLine:FireServer(targetRoot)
                        end)
                    end
                end

                task.wait(0.005)
            end

            for _, a in pairs(anchors) do
                if a and a.Parent then a:Destroy() end
            end
            anchors = {}

            for _, o in pairs(orients) do
                if o and o.Parent then o:Destroy() end
            end
            orients = {}

            if selectedKickPlayer and selectedKickPlayer.Character then
                local targetRoot = selectedKickPlayer.Character:FindFirstChild("HumanoidRootPart")
                if targetRoot then
                    pcall(function()
                        GrabEvents.DestroyGrabLine:FireServer(targetRoot)
                    end)
                end
            end

            kickLoopEnabled = false
        end)
    end
})