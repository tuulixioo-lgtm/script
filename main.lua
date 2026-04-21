-- Painel Gatucho (SCRIPT COMPLETO COM NOCLIP OFF CORRIGIDO)

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
frame.Size = UDim2.new(0,250,0,400)
frame.Position = UDim2.new(0,20,0.5,-200)
frame.BackgroundColor3 = Color3.fromRGB(35,35,35)
frame.BorderSizePixel = 0
frame.Parent = gui
Instance.new("UICorner", frame)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,0,0,30)
title.BackgroundColor3 = Color3.fromRGB(25,25,25)
title.Text = "Gatucho Hub"
title.TextColor3 = Color3.new(1,1,1)
title.Parent = frame

local function topBtn(txt,x,color)
	local b = Instance.new("TextButton")
	b.Size = UDim2.new(0,30,0,30)
	b.Position = UDim2.new(1,x,0,0)
	b.Text = txt
	b.TextColor3 = Color3.new(1,1,1)
	b.BackgroundColor3 = color
	b.Parent = frame
	return b
end

local closeBtn = topBtn("X",-60,Color3.fromRGB(200,50,50))
local minBtn = topBtn("-", -30, Color3.fromRGB(60,60,60))

local function makeBtn(y,text)
	local b = Instance.new("TextButton")
	b.Size = UDim2.new(0,210,0,35)
	b.Position = UDim2.new(0.5,-105,0,y)
	b.Text = text
	b.Parent = frame
	return b
end

local flyBtn = makeBtn(40,"VOAR")
local unflyBtn = makeBtn(80,"NÃO VOAR")
local tpBtn = makeBtn(120,"TP CLICK: OFF")
local rejoinBtn = makeBtn(160,"REJOIN SERVER")
local noclipBtn = makeBtn(200,"NOCLIP: OFF")

local nameBox = Instance.new("TextBox")
nameBox.Size = UDim2.new(0,210,0,35)
nameBox.Position = UDim2.new(0.5,-105,0,245)
nameBox.PlaceholderText = "Nome do player"
nameBox.Parent = frame

local execBtn = makeBtn(290,"EXECUTAR TP PLAYER")

-- FUNÇÕES
local function getChar(plr)
	plr = plr or player
	return plr.Character or plr.CharacterAdded:Wait()
end

local function getRoot(plr)
	return getChar(plr):WaitForChild("HumanoidRootPart")
end

local function getHumanoid()
	return getChar():WaitForChild("Humanoid")
end

local function findPlayer(name)
	name = string.lower(name)
	for _,p in pairs(Players:GetPlayers()) do
		if string.find(string.lower(p.Name),name,1,true)
		or string.find(string.lower(p.DisplayName),name,1,true) then
			return p
		end
	end
end

-- FECHAR / MINIMIZAR
closeBtn.MouseButton1Click:Connect(function()
	gui:Destroy()
end)

local buttons = {flyBtn,unflyBtn,tpBtn,rejoinBtn,noclipBtn,nameBox,execBtn}

minBtn.MouseButton1Click:Connect(function()
	minimized = not minimized
	frame.Size = minimized and UDim2.new(0,250,0,30) or UDim2.new(0,250,0,400)
	minBtn.Text = minimized and "+" or "-"

	for _,v in pairs(buttons) do
		v.Visible = not minimized
	end
end)

-- ARRASTAR
local dragging = false
local dragStart
local startPos

title.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1
	or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = frame.Position
	end
end)

UIS.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1
	or input.UserInputType == Enum.UserInputType.Touch then
		dragging = false
	end
end)

UIS.InputChanged:Connect(function(input)
	if dragging then
		local delta = input.Position - dragStart
		frame.Position = UDim2.new(
			startPos.X.Scale,
			startPos.X.Offset + delta.X,
			startPos.Y.Scale,
			startPos.Y.Offset + delta.Y
		)
	end
end)

-- BOTÕES
flyBtn.MouseButton1Click:Connect(function()
	if flying then return end
	flying = true

	getHumanoid().PlatformStand = true

	bodyVelocity = Instance.new("BodyVelocity")
	bodyVelocity.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
	bodyVelocity.Parent = getRoot()

	bodyGyro = Instance.new("BodyGyro")
	bodyGyro.MaxTorque = Vector3.new(math.huge,math.huge,math.huge)
	bodyGyro.P = 10000
	bodyGyro.Parent = getRoot()
end)

unflyBtn.MouseButton1Click:Connect(function()
	flying = false
	getHumanoid().PlatformStand = false

	if bodyVelocity then bodyVelocity:Destroy() end
	if bodyGyro then bodyGyro:Destroy() end
end)

tpBtn.MouseButton1Click:Connect(function()
	clickTp = not clickTp
	tpBtn.Text = clickTp and "TP CLICK: ON" or "TP CLICK: OFF"
end)

rejoinBtn.MouseButton1Click:Connect(function()
	TeleportService:Teleport(game.PlaceId, player)
end)

noclipBtn.MouseButton1Click:Connect(function()
	noclip = not noclip
	noclipBtn.Text = noclip and "NOCLIP: ON" or "NOCLIP: OFF"

	if not noclip then
		for _,v in pairs(getChar():GetDescendants()) do
			if v:IsA("BasePart") then
				v.CanCollide = true
			end
		end
	end
end)

execBtn.MouseButton1Click:Connect(function()
	local target = findPlayer(nameBox.Text)
	if target and target ~= player then
		getRoot().CFrame = getRoot(target).CFrame * CFrame.new(0,0,-3)
	end
end)

-- LOOP
RunService.RenderStepped:Connect(function()
	if flying and bodyVelocity and bodyGyro then
		local cam = workspace.CurrentCamera
		local vel = Vector3.zero
		local look = cam.CFrame.LookVector
		local right = cam.CFrame.RightVector

		if UIS:IsKeyDown(Enum.KeyCode.W) then vel += look end
		if UIS:IsKeyDown(Enum.KeyCode.S) then vel -= look end
		if UIS:IsKeyDown(Enum.KeyCode.A) then vel -= right end
		if UIS:IsKeyDown(Enum.KeyCode.D) then vel += right end

		if vel.Magnitude > 0 then
			bodyVelocity.Velocity = vel.Unit * speed
		else
			bodyVelocity.Velocity = Vector3.zero
		end

		bodyGyro.CFrame = cam.CFrame
	end

	if noclip then
		for _,v in pairs(getChar():GetDescendants()) do
			if v:IsA("BasePart") then
				v.CanCollide = false
			end
		end
	end
end)

-- TP CLICK
mouse.Button1Down:Connect(function()
	if clickTp then
		getRoot().CFrame = CFrame.new(mouse.Hit.Position + Vector3.new(0,3,0))
	end
end)
