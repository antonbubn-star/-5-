local repo = "https://raw.githubusercontent.com/deividcomsono/Obsidian/main/"
  local Library = loadstring(game:HttpGet(repo .. "Library.lua"))()
  local ThemeManager = loadstring(game:HttpGet(repo .. "addons/ThemeManager.lua"))()
  local SaveManager = loadstring(game:HttpGet(repo .. "addons/SaveManager.lua"))()
local Players = game:GetService("Players")
local RS = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local Debris = game:GetService("Debris")
local TextChatService = game:GetService("TextChatService")
local Lighting = game:GetService("Lighting")
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
local Options = Library.Options
  local Toggles = Library.Toggles
  Library.ForceCheckbox = false
local Window = Library:CreateWindow({
    Title = "kirpich",
    Footer = "by cimkarta",
    Icon = 9174663321,
    NotifySide = "Right",
    ShowCustomCursor = true,
  })
Window:SetBackgroundImage("rbxassetid://86870310824805") 

local Tabs = {
	Player = Window:AddTab("player", "user"),	Misc = Window:AddTab("misc", "layers"),
	Defense = Window:AddTab("defense", "shield"),
	Target = Window:AddTab("target", "crosshair"),
	Grab = Window:AddTab("grab", "hand"),
	
}


local LeftGroupbox = PlayerTab:AddGroupbox({
    Side = "Left",
    Name = "Settings",
    IconName = "wrench",
})
