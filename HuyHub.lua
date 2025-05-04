local player = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui", player.PlayerGui)
gui.ResetOnSpawn = false

local toggleButton = Instance.new("TextButton")
toggleButton.Parent = gui
toggleButton.Size = UDim2.new(0, 50, 0, 50)
toggleButton.Position = UDim2.new(0, 100, 0, 100)
toggleButton.Text = "H"
toggleButton.TextScaled = true
toggleButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
toggleButton.TextColor3 = Color3.fromRGB(255, 0, 0)
toggleButton.BorderSizePixel = 2
toggleButton.BorderColor3 = Color3.fromRGB(255, 0, 0)
toggleButton.AnchorPoint = Vector2.new(0.5, 0.5)
toggleButton.Draggable = true

local mainFrame = Instance.new("Frame")
mainFrame.Parent = gui
mainFrame.Size = UDim2.new(0, 500, 0, 550)
mainFrame.Position = UDim2.new(0.5, -250, 0.5, -275)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
mainFrame.BorderColor3 = Color3.fromRGB(255, 0, 0)
mainFrame.BorderSizePixel = 2
mainFrame.Visible = false
mainFrame.Active = true
mainFrame.Draggable = true

local title = Instance.new("TextLabel")
title.Parent = mainFrame
title.Size = UDim2.new(1, 0, 0, 50)
title.Position = UDim2.new(0, 0, 0, 0)
title.Text = "HUY HUB"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
title.BorderSizePixel = 0
title.TextScaled = true

toggleButton.MouseButton1Click:Connect(function()
	mainFrame.Visible = not mainFrame.Visible
end)

local tabs = {"Farm", "Teleport", "Misc"}
local currentTab = "Farm"

local function createTabButton(tabName, position)
	local btn = Instance.new("TextButton")
	btn.Parent = mainFrame
	btn.Size = UDim2.new(0, 150, 0, 40)
	btn.Position = position
	btn.Text = tabName
	btn.TextScaled = true
	btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	btn.BorderSizePixel = 0
	btn.MouseButton1Click:Connect(function()
		currentTab = tabName
		for _, btn in pairs(mainFrame:GetChildren()) do
			if btn:IsA("TextButton") and btn.Name == "ActionButton" then
				btn.Visible = (btn.Tab == currentTab)
			end
		end
	end)
end

for i, tab in ipairs(tabs) do
	createTabButton(tab, UDim2.new(0, (i - 1) * 160 + 10, 0, 60))
end

local function createButton(text, tab, position, color, callback)
	local btn = Instance.new("TextButton")
	btn.Parent = mainFrame
	btn.Size = UDim2.new(0, 200, 0, 40)
	btn.Position = position
	btn.Text = text
	btn.TextScaled = true
	btn.BackgroundColor3 = color
	btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	btn.BorderSizePixel = 0
	btn.Name = "ActionButton"
	btn.Tab = tab
	btn.Visible = (tab == currentTab)
	btn.MouseButton1Click:Connect(callback)
	return btn
end

createButton("Auto Farm", "Farm", UDim2.new(0, 10, 0, 120), Color3.fromRGB(0, 200, 0), function()
	print("Auto Farm Activated")
end)

createButton("Teleport Jungle", "Teleport", UDim2.new(0, 10, 0, 120), Color3.fromRGB(0, 120, 255), function()
	local island = game.Workspace:FindFirstChild("Jungle")
	if island and island:FindFirstChild("SpawnPoint") then
		player.Character.HumanoidRootPart.CFrame = island.SpawnPoint.CFrame + Vector3.new(0, 5, 0)
	end
end)

createButton("ESP Players", "Misc", UDim2.new(0, 10, 0, 120), Color3.fromRGB(0, 255, 255), function()
	for _, p in pairs(game.Players:GetPlayers()) do
		if p ~= player and p.Character and p.Character:FindFirstChild("Head") and not p.Character.Head:FindFirstChild("HUYESP") then
			local esp = Instance.new("BillboardGui", p.Character.Head)
			esp.Name = "HUYESP"
			esp.Size = UDim2.new(0, 100, 0, 50)
			esp.AlwaysOnTop = true
			local name = Instance.new("TextLabel", esp)
			name.Size = UDim2.new(1, 0, 1, 0)
			name.Text = p.Name
			name.TextColor3 = Color3.fromRGB(255, 0, 0)
			name.BackgroundTransparency = 1
		end
	end
end)
