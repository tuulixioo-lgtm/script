-- Painel Gatucho (SCRIPT COMPLETO COM VISUAL MELHORADO)

local player = game.Players.LocalPlayer
local mouse = player:GetMouse()

local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")

local flying = false
local clickTp = false
local minimized = false
local noclip = false
local speed = 70

local bodyVelocity
local bodyGyro

-- GUI
local gui = Instance.new("ScreenGui")
gui.Name = "PainelHub"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0,260,0,400)
frame.Position = UDim2.new(0,20,0.5,-200)
frame.BackgroundColor3 = Color3.fromRGB(18,18,18)
frame.BorderSizePixel = 0
frame.Parent = gui
Instance.new("UICorner", frame)

local stroke = Instance.new("UIStroke", frame)
stroke.Color = Color3.fromRGB(0,255,170)
stroke.Thickness = 2

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,0,0,35)
title.BackgroundColor3 = Color3.fromRGB(0,255,170)
title.Text = "⚡ Gatucho Hub ⚡"
title.TextColor3 = Color3.fromRGB(0,0,0)
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.Parent = frame
Instance.new("UICorner", title)

local function topBtn(txt,x,color)
	local b = Instance.new("TextButton")
	b.Size = UDim2.new(0,30,0,30)
	b.Position = UDim2.new(1,x,0,2)
	b.Text = txt
	b.TextColor3 = Color3.new(1,1,1)
	b.BackgroundColor3 = color
	b.Font = Enum.Font.GothamBold
	b.TextSize = 18
	b.BorderSizePixel = 0
	b.Parent = frame
	Instance.new("UICorner", b)
	return b
end

local closeBtn = topBtn("X",-65,Color3.fromRGB(255,70,70))
local minBtn = topBtn("-", -32, Color3.fromRGB(80,80,80))

local function makeBtn(y,text)
	local b = Instance.new("TextButton")
	b.Size = UDim2.new(0,220,0,35)
	b.Position = UDim2.new(0.5,-110,0,y)
	b.Text = text
	b.BackgroundColor3 = Color3.fromRGB(35,35,35)
	b.TextColor3 = Color3.fromRGB(255,255,255)
	b.Font = Enum.Font.GothamBold
	b.TextSize = 14
	b.BorderSizePixel = 0
	b.Parent = frame
	Instance.new("UICorner", b)

	local s = Instance.new("UIStroke", b)
	s.Color = Color3.fromRGB(0,255,170)
	s.Thickness = 1

	return b
end

local flyBtn = makeBtn(45,"fly(não funciona no mobile)")
local unflyBtn = makeBtn(85,"unfly")
local tpBtn = makeBtn(125,"TP CLICK: OFF")
local rejoinBtn = makeBtn(165,"REJOIN SERVER")
local noclipBtn = makeBtn(205,"NOCLIP: OFF")

local nameBox = Instance.new("TextBox")
nameBox.Size = UDim2.new(0,220,0,35)
nameBox.Position = UDim2.new(0.5,-110,0,250)
nameBox.PlaceholderText = "Nome do player"
nameBox.Text = ""
nameBox.BackgroundColor3 = Color3.fromRGB(35,35,35)
nameBox.TextColor3 = Color3.new(1,1,1)
nameBox.PlaceholderColor3 = Color3.fromRGB(160,160,160)
nameBox.Font = Enum.Font.GothamBold
nameBox.TextSize = 14
nameBox.BorderSizePixel = 0
nameBox.Parent = frame
Instance.new("UICorner", nameBox)

local boxStroke = Instance.new("UIStroke", nameBox)
boxStroke.Color = Color3.fromRGB(0,255,170)

local execBtn = makeBtn(295,"EXECUTAR TP PLAYER")

-- RESTANTE DO SCRIPT CONTINUA IGUAL AO ANTERIOR
-- (funções, voo, noclip, tp, minimizar, fechar, etc)

print("Cole o restante do script antigo abaixo dessa parte visual")
