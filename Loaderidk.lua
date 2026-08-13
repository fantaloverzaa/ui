local Library = {}

-- // Services
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")

local Player = Players.LocalPlayer
local TweenTime = 0.4
local TweenInfoFast = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

-- // Protect UI
local GuiTarget = pcall(function() return CoreGui.Name end) and CoreGui or Player:WaitForChild("PlayerGui")

function Library:CreateWindow(Config)
	local TitleText = Config.Title or "Library"
	local DescText = Config.Description or "Description here"
	local WindowIcon = Config.Icon or "rbxassetid://0" -- Default blank if none provided
	
	-- Cleanup old instances
	if GuiTarget:FindFirstChild("ScriptLoaderUI_" .. TitleText) then
		GuiTarget["ScriptLoaderUI_" .. TitleText]:Destroy()
	end

	local ScreenGui = Instance.new("ScreenGui")
	ScreenGui.Name = "ScriptLoaderUI_" .. TitleText
	ScreenGui.ResetOnSpawn = false
	ScreenGui.Parent = GuiTarget

	-- Using CanvasGroup for smooth Fade In/Out of the entire UI
	local MainFrame = Instance.new("CanvasGroup")
	MainFrame.Name = "MainFrame"
	MainFrame.Size = UDim2.new(0, 580, 0, 360) -- BIGGER UI
	MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
	MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
	MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20) -- Sleek notify color
	MainFrame.BorderSizePixel = 0
	MainFrame.GroupTransparency = 1 -- Start invisible for Fade In
	MainFrame.Parent = ScreenGui

	local UICorner = Instance.new("UICorner")
	UICorner.CornerRadius = UDim.new(0, 8)
	UICorner.Parent = MainFrame

	-- Top Bar
	local TopBar = Instance.new("Frame")
	TopBar.Size = UDim2.new(1, 0, 0, 40)
	TopBar.BackgroundTransparency = 1
	TopBar.Parent = MainFrame

	-- Window Icon
	local Icon = Instance.new("ImageLabel")
	Icon.Size = UDim2.new(0, 24, 0, 24)
	Icon.Position = UDim2.new(0, 10, 0.5, -12)
	Icon.BackgroundTransparency = 1
	Icon.Image = WindowIcon
	Icon.Parent = TopBar

	-- Window Title
	local Title = Instance.new("TextLabel")
	Title.Size = UDim2.new(0, 200, 1, 0)
	Title.Position = UDim2.new(0, 42, 0, 0)
	Title.BackgroundTransparency = 1
	Title.Text = TitleText
	Title.TextColor3 = Color3.fromRGB(255, 255, 255)
	Title.TextSize = 16
	Title.Font = Enum.Font.GothamBold
	Title.TextXAlignment = Enum.TextXAlignment.Left
	Title.Parent = TopBar

	-- Window Description
	local Description = Instance.new("TextLabel")
	Description.Size = UDim2.new(0, 200, 1, 0)
	Description.Position = UDim2.new(0, 42 + Title.TextBounds.X + 10, 0, 0) -- Adjust position based on title size
	Description.BackgroundTransparency = 1
	Description.Text = "- " .. DescText
	Description.TextColor3 = Color3.fromRGB(150, 150, 150)
	Description.TextSize = 13
	Description.Font = Enum.Font.Gotham
	Description.TextXAlignment = Enum.TextXAlignment.Left
	Description.Parent = TopBar

	-- Close Button
	local CloseBtn = Instance.new("TextButton")
	CloseBtn.Size = UDim2.new(0, 30, 0, 30)
	CloseBtn.Position = UDim2.new(1, -35, 0.5, -15)
	CloseBtn.BackgroundTransparency = 1
	CloseBtn.Text = "✕"
	CloseBtn.TextColor3 = Color3.fromRGB(150, 150, 150)
	CloseBtn.TextSize = 16
	CloseBtn.Font = Enum.Font.GothamBold
	CloseBtn.Parent = TopBar

	-- Container
	local Container = Instance.new("Frame")
	Container.Size = UDim2.new(1, -20, 1, -50)
	Container.Position = UDim2.new(0, 10, 0, 40)
	Container.BackgroundTransparency = 1
	Container.Parent = MainFrame

	-- Left Side (Catalogue)
	local Catalogue = Instance.new("ScrollingFrame")
	Catalogue.Size = UDim2.new(0.4, -5, 1, -10)
	Catalogue.BackgroundTransparency = 1
	Catalogue.ScrollBarThickness = 4
	Catalogue.CanvasSize = UDim2.new(0, 0, 0, 0)
	Catalogue.AutomaticCanvasSize = Enum.AutomaticSize.Y
	Catalogue.Parent = Container

	local ListLayout = Instance.new("UIListLayout")
	ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	ListLayout.Padding = UDim.new(0, 6)
	ListLayout.Parent = Catalogue

	-- Right Side (Details)
	local DetailsFrame = Instance.new("Frame")
	DetailsFrame.Size = UDim2.new(0.6, 0, 1, -10)
	DetailsFrame.Position = UDim2.new(1, 0, 0, 0)
	DetailsFrame.AnchorPoint = Vector2.new(1, 0)
	DetailsFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	DetailsFrame.Parent = Container

	local DetailsCorner = Instance.new("UICorner")
	DetailsCorner.CornerRadius = UDim.new(0, 6)
	DetailsCorner.Parent = DetailsFrame

	local Thumbnail = Instance.new("ImageLabel")
	Thumbnail.Size = UDim2.new(1, -14, 0.45, 0)
	Thumbnail.Position = UDim2.new(0, 7, 0, 7)
	Thumbnail.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	Thumbnail.ScaleType = Enum.ScaleType.Crop
	Thumbnail.Parent = DetailsFrame

	local ThumbCorner = Instance.new("UICorner")
	ThumbCorner.CornerRadius = UDim.new(0, 4)
	ThumbCorner.Parent = Thumbnail

	local ScriptName = Instance.new("TextLabel")
	ScriptName.Size = UDim2.new(1, -14, 0, 20)
	ScriptName.Position = UDim2.new(0, 7, 0.45, 15)
	ScriptName.BackgroundTransparency = 1
	ScriptName.Text = "Select a script"
	ScriptName.TextColor3 = Color3.fromRGB(255, 255, 255)
	ScriptName.TextSize = 18
	ScriptName.Font = Enum.Font.GothamBold
	ScriptName.TextXAlignment = Enum.TextXAlignment.Left
	ScriptName.Parent = DetailsFrame

	local FeaturesList = Instance.new("TextLabel")
	FeaturesList.Size = UDim2.new(1, -14, 0.5, -60)
	FeaturesList.Position = UDim2.new(0, 7, 0.45, 40)
	FeaturesList.BackgroundTransparency = 1
	FeaturesList.Text = "Awaiting selection..."
	FeaturesList.TextColor3 = Color3.fromRGB(180, 180, 180)
	FeaturesList.TextSize = 14
	FeaturesList.Font = Enum.Font.Gotham
	FeaturesList.TextXAlignment = Enum.TextXAlignment.Left
	FeaturesList.TextYAlignment = Enum.TextYAlignment.Top
	FeaturesList.Parent = DetailsFrame

	local LoadBtn = Instance.new("TextButton")
	LoadBtn.Size = UDim2.new(1, -14, 0, 35)
	LoadBtn.Position = UDim2.new(0, 7, 1, -42)
	LoadBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
	LoadBtn.Text = "Load Script"
	LoadBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
	LoadBtn.TextSize = 14
	LoadBtn.Font = Enum.Font.GothamBold
	LoadBtn.AutoButtonColor = false
	LoadBtn.Parent = DetailsFrame

	local LoadCorner = Instance.new("UICorner")
	LoadCorner.CornerRadius = UDim.new(0, 4)
	LoadCorner.Parent = LoadBtn

	-- // Dragging Logic
	local dragging, dragInput, dragStart, startPos
	TopBar.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = MainFrame.Position
			
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)

	TopBar.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			dragInput = input
		end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			local delta = input.Position - dragStart
			MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
		end
	end)

	-- // Fade In Animation
	TweenService:Create(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {GroupTransparency = 0}):Play()

	-- // Core Mechanics
	local CurrentAction = nil

	LoadBtn.MouseEnter:Connect(function()
		TweenService:Create(LoadBtn, TweenInfoFast, {BackgroundColor3 = Color3.fromRGB(0, 120, 240)}):Play()
	end)
	LoadBtn.MouseLeave:Connect(function()
		TweenService:Create(LoadBtn, TweenInfoFast, {BackgroundColor3 = Color3.fromRGB(0, 100, 200)}):Play()
	end)

	LoadBtn.MouseButton1Click:Connect(function()
		if CurrentAction then
			LoadBtn.Text = "Loading..."
			task.wait(0.2)
			CurrentAction()
			LoadBtn.Text = "Load Script"
		end
	end)

	CloseBtn.MouseEnter:Connect(function()
		TweenService:Create(CloseBtn, TweenInfoFast, {TextColor3 = Color3.fromRGB(255, 75, 75)}):Play()
	end)
	CloseBtn.MouseLeave:Connect(function()
		TweenService:Create(CloseBtn, TweenInfoFast, {TextColor3 = Color3.fromRGB(150, 150, 150)}):Play()
	end)

	CloseBtn.MouseButton1Click:Connect(function()
		-- Fade Out
		local closeTween = TweenService:Create(MainFrame, TweenInfo.new(TweenTime, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {GroupTransparency = 1})
		closeTween:Play()
		closeTween.Completed:Wait()
		ScreenGui:Destroy()
	end)

	-- // Return Window Methods to User
	local Window = {}

	function Window:AddScript(ScriptConfig)
		local ItemBtn = Instance.new("TextButton")
		ItemBtn.Size = UDim2.new(1, -10, 0, 32)
		ItemBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
		ItemBtn.Text = "  " .. ScriptConfig.Name
		ItemBtn.TextColor3 = Color3.fromRGB(220, 220, 220)
		ItemBtn.TextSize = 14
		ItemBtn.Font = Enum.Font.Gotham
		ItemBtn.TextXAlignment = Enum.TextXAlignment.Left
		ItemBtn.AutoButtonColor = false
		ItemBtn.Parent = Catalogue

		local ItemCorner = Instance.new("UICorner")
		ItemCorner.CornerRadius = UDim.new(0, 4)
		ItemCorner.Parent = ItemBtn

		ItemBtn.MouseEnter:Connect(function()
			TweenService:Create(ItemBtn, TweenInfoFast, {BackgroundColor3 = Color3.fromRGB(50, 50, 50)}):Play()
		end)
		ItemBtn.MouseLeave:Connect(function()
			TweenService:Create(ItemBtn, TweenInfoFast, {BackgroundColor3 = Color3.fromRGB(35, 35, 35)}):Play()
		end)

		ItemBtn.MouseButton1Click:Connect(function()
			Thumbnail.Image = ScriptConfig.Thumbnail or ""
			ScriptName.Text = ScriptConfig.Name
			FeaturesList.Text = ScriptConfig.Features or "No features listed."
			CurrentAction = ScriptConfig.Action
		end)
	end

	return Window
end

return Library
