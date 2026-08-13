local Library = {}

-- // Services
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")

local Player = Players.LocalPlayer
local TweenTime = 0.4
local TweenInfoFast = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

-- // Protect UI
local GuiTarget = pcall(function() return CoreGui.Name end) and CoreGui or Player:WaitForChild("PlayerGui")

-- // Theme Colors
local Theme = {
	Background = Color3.fromRGB(12, 12, 14),
	Panel = Color3.fromRGB(18, 18, 22),
	DarkBlue = Color3.fromRGB(0, 65, 180),
	LightBlue = Color3.fromRGB(0, 100, 255),
	Text = Color3.fromRGB(240, 240, 240),
	SubText = Color3.fromRGB(160, 160, 160),
	Line = Color3.fromRGB(35, 35, 45)
}

-- // Initialize Notification GUI
local NotifyGui = GuiTarget:FindFirstChild("LibraryNotifications")
if not NotifyGui then
	NotifyGui = Instance.new("ScreenGui")
	NotifyGui.Name = "LibraryNotifications"
	NotifyGui.ResetOnSpawn = false
	NotifyGui.Parent = GuiTarget

	local NotifyList = Instance.new("Frame")
	NotifyList.Name = "List"
	NotifyList.Size = UDim2.new(0, 300, 1, -20)
	NotifyList.Position = UDim2.new(1, -320, 0, 10)
	NotifyList.BackgroundTransparency = 1
	NotifyList.Parent = NotifyGui

	local ListLayout = Instance.new("UIListLayout")
	ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	ListLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
	ListLayout.Padding = UDim.new(0, 10)
	ListLayout.Parent = NotifyList
end

-- // Notification System
function Library:Notification(Config)
	local TitleText = Config.Title or "Notification"
	local DescText = Config.Description or ""
	local Duration = Config.Duration or 3
	local Icon = Config.Icon or ""

	local NotifyFrame = Instance.new("CanvasGroup")
	NotifyFrame.Size = UDim2.new(1, 0, 0, 70)
	NotifyFrame.BackgroundColor3 = Theme.Panel
	NotifyFrame.GroupTransparency = 1
	NotifyFrame.Parent = NotifyGui.List

	local UICorner = Instance.new("UICorner")
	UICorner.CornerRadius = UDim.new(0, 6)
	UICorner.Parent = NotifyFrame

	local Accent = Instance.new("Frame")
	Accent.Size = UDim2.new(0, 4, 1, 0)
	Accent.BackgroundColor3 = Theme.LightBlue
	Accent.BorderSizePixel = 0
	Accent.Parent = NotifyFrame

	local CornerAccent = Instance.new("UICorner")
	CornerAccent.CornerRadius = UDim.new(0, 6)
	CornerAccent.Parent = Accent

	local Title = Instance.new("TextLabel")
	Title.Size = UDim2.new(1, -50, 0, 25)
	Title.Position = UDim2.new(0, 15, 0, 10)
	Title.BackgroundTransparency = 1
	Title.Text = TitleText
	Title.TextColor3 = Theme.LightBlue
	Title.TextSize = 15
	Title.Font = Enum.Font.GothamBold
	Title.TextXAlignment = Enum.TextXAlignment.Left
	Title.Parent = NotifyFrame

	local Desc = Instance.new("TextLabel")
	Desc.Size = UDim2.new(1, -20, 0, 20)
	Desc.Position = UDim2.new(0, 15, 0, 35)
	Desc.BackgroundTransparency = 1
	Desc.Text = DescText
	Desc.TextColor3 = Theme.SubText
	Desc.TextSize = 13
	Desc.Font = Enum.Font.Gotham
	Desc.TextXAlignment = Enum.TextXAlignment.Left
	Desc.Parent = NotifyFrame

	-- Animate In
	TweenService:Create(NotifyFrame, TweenInfoFast, {GroupTransparency = 0}):Play()
	
	-- Destroy after duration
	task.delay(Duration, function()
		local fadeOut = TweenService:Create(NotifyFrame, TweenInfoFast, {GroupTransparency = 1})
		fadeOut:Play()
		fadeOut.Completed:Wait()
		NotifyFrame:Destroy()
	end)
end

-- // Window Creation
function Library:CreateWindow(Config)
	local TitleText = Config.Title or "Hub"
	local DescText = Config.Description or "Script Hub"
	local WindowIcon = Config.Icon or ""

	if GuiTarget:FindFirstChild("UI_" .. TitleText) then
		GuiTarget["UI_" .. TitleText]:Destroy()
	end

	local ScreenGui = Instance.new("ScreenGui")
	ScreenGui.Name = "UI_" .. TitleText
	ScreenGui.ResetOnSpawn = false
	ScreenGui.Parent = GuiTarget

	local MainFrame = Instance.new("CanvasGroup")
	MainFrame.Name = "MainFrame"
	MainFrame.Size = UDim2.new(0, 600, 0, 400)
	MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
	MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
	MainFrame.BackgroundColor3 = Theme.Background
	MainFrame.BorderSizePixel = 0
	MainFrame.GroupTransparency = 1
	MainFrame.Parent = ScreenGui

	local UICorner = Instance.new("UICorner")
	UICorner.CornerRadius = UDim.new(0, 8)
	UICorner.Parent = MainFrame

	local TopAccent = Instance.new("Frame")
	TopAccent.Size = UDim2.new(1, 0, 0, 2)
	TopAccent.BackgroundColor3 = Theme.DarkBlue
	TopAccent.BorderSizePixel = 0
	TopAccent.Parent = MainFrame

	-- Top Bar
	local TopBar = Instance.new("Frame")
	TopBar.Size = UDim2.new(1, 0, 0, 45)
	TopBar.BackgroundTransparency = 1
	TopBar.Parent = MainFrame

	local TopLine = Instance.new("Frame")
	TopLine.Size = UDim2.new(1, 0, 0, 1)
	TopLine.Position = UDim2.new(0, 0, 1, 0)
	TopLine.BackgroundColor3 = Theme.Line
	TopLine.BorderSizePixel = 0
	TopLine.Parent = TopBar

	local Title = Instance.new("TextLabel")
	Title.Size = UDim2.new(0, 200, 1, 0)
	Title.Position = UDim2.new(0, 15, 0, 0)
	Title.BackgroundTransparency = 1
	Title.Text = TitleText
	Title.TextColor3 = Theme.LightBlue
	Title.TextSize = 17
	Title.Font = Enum.Font.GothamBold
	Title.TextXAlignment = Enum.TextXAlignment.Left
	Title.Parent = TopBar

	local Description = Instance.new("TextLabel")
	Description.Size = UDim2.new(0, 200, 1, 0)
	Description.Position = UDim2.new(0, 15 + Title.TextBounds.X + 10, 0, 0)
	Description.BackgroundTransparency = 1
	Description.Text = "|  " .. DescText
	Description.TextColor3 = Theme.SubText
	Description.TextSize = 14
	Description.Font = Enum.Font.Gotham
	Description.TextXAlignment = Enum.TextXAlignment.Left
	Description.Parent = TopBar

	local CloseBtn = Instance.new("TextButton")
	CloseBtn.Size = UDim2.new(0, 45, 1, -2)
	CloseBtn.Position = UDim2.new(1, -45, 0, 2)
	CloseBtn.BackgroundTransparency = 1
	CloseBtn.Text = "✕"
	CloseBtn.TextColor3 = Theme.SubText
	CloseBtn.TextSize = 16
	CloseBtn.Font = Enum.Font.GothamBold
	CloseBtn.Parent = TopBar

	local Container = Instance.new("Frame")
	Container.Size = UDim2.new(1, 0, 1, -46)
	Container.Position = UDim2.new(0, 0, 0, 46)
	Container.BackgroundTransparency = 1
	Container.Parent = MainFrame

	-- Left Catalogue
	local Catalogue = Instance.new("ScrollingFrame")
	Catalogue.Size = UDim2.new(0.4, 0, 1, -20)
	Catalogue.Position = UDim2.new(0, 15, 0, 10)
	Catalogue.BackgroundTransparency = 1
	Catalogue.ScrollBarThickness = 2
	Catalogue.ScrollBarImageColor3 = Theme.DarkBlue
	Catalogue.CanvasSize = UDim2.new(0, 0, 0, 0)
	Catalogue.AutomaticCanvasSize = Enum.AutomaticSize.Y
	Catalogue.Parent = Container

	local ListLayout = Instance.new("UIListLayout")
	ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	ListLayout.Padding = UDim.new(0, 8)
	ListLayout.Parent = Catalogue

	-- Vertical Divider
	local VertLine = Instance.new("Frame")
	VertLine.Size = UDim2.new(0, 1, 1, 0)
	VertLine.Position = UDim2.new(0.4, 25, 0, 0)
	VertLine.BackgroundColor3 = Theme.Line
	VertLine.BorderSizePixel = 0
	VertLine.Parent = Container

	-- Right Details
	local DetailsFrame = Instance.new("Frame")
	DetailsFrame.Size = UDim2.new(0.6, -45, 1, -20)
	DetailsFrame.Position = UDim2.new(0.4, 35, 0, 10)
	DetailsFrame.BackgroundColor3 = Theme.Panel
	DetailsFrame.Parent = Container

	local DetailsCorner = Instance.new("UICorner")
	DetailsCorner.CornerRadius = UDim.new(0, 6)
	DetailsCorner.Parent = DetailsFrame

	local Thumbnail = Instance.new("ImageLabel")
	Thumbnail.Size = UDim2.new(1, -20, 0.45, 0)
	Thumbnail.Position = UDim2.new(0, 10, 0, 10)
	Thumbnail.BackgroundColor3 = Theme.Background
	Thumbnail.ScaleType = Enum.ScaleType.Crop
	Thumbnail.Parent = DetailsFrame

	local ThumbCorner = Instance.new("UICorner")
	ThumbCorner.CornerRadius = UDim.new(0, 4)
	ThumbCorner.Parent = Thumbnail

	local ScriptName = Instance.new("TextLabel")
	ScriptName.Size = UDim2.new(1, -20, 0, 25)
	ScriptName.Position = UDim2.new(0, 10, 0.45, 20)
	ScriptName.BackgroundTransparency = 1
	ScriptName.Text = "Select a script"
	ScriptName.TextColor3 = Theme.Text
	ScriptName.TextSize = 20
	ScriptName.Font = Enum.Font.GothamBold
	ScriptName.TextXAlignment = Enum.TextXAlignment.Left
	ScriptName.Parent = DetailsFrame

	local FeaturesList = Instance.new("TextLabel")
	FeaturesList.Size = UDim2.new(1, -20, 0.5, -115)
	FeaturesList.Position = UDim2.new(0, 10, 0.45, 50)
	FeaturesList.BackgroundTransparency = 1
	FeaturesList.Text = "Awaiting selection..."
	FeaturesList.TextColor3 = Theme.SubText
	FeaturesList.TextSize = 13
	FeaturesList.Font = Enum.Font.Gotham
	FeaturesList.TextXAlignment = Enum.TextXAlignment.Left
	FeaturesList.TextYAlignment = Enum.TextYAlignment.Top
	FeaturesList.Parent = DetailsFrame

	-- Action Buttons Area
	local ActionArea = Instance.new("Frame")
	ActionArea.Size = UDim2.new(1, -20, 0, 40)
	ActionArea.Position = UDim2.new(0, 10, 1, -50)
	ActionArea.BackgroundTransparency = 1
	ActionArea.Parent = DetailsFrame

	local LoadBtn = Instance.new("TextButton")
	LoadBtn.Size = UDim2.new(0.65, -5, 1, 0)
	LoadBtn.BackgroundColor3 = Theme.DarkBlue
	LoadBtn.Text = "Load Script"
	LoadBtn.TextColor3 = Theme.Text
	LoadBtn.TextSize = 14
	LoadBtn.Font = Enum.Font.GothamBold
	LoadBtn.AutoButtonColor = false
	LoadBtn.Parent = ActionArea

	local LoadCorner = Instance.new("UICorner")
	LoadCorner.CornerRadius = UDim.new(0, 4)
	LoadCorner.Parent = LoadBtn

	local AutoLoadToggle = Instance.new("TextButton")
	AutoLoadToggle.Size = UDim2.new(0.35, -5, 1, 0)
	AutoLoadToggle.Position = UDim2.new(0.65, 5, 0, 0)
	AutoLoadToggle.BackgroundColor3 = Theme.Background
	AutoLoadToggle.Text = "Auto: OFF"
	AutoLoadToggle.TextColor3 = Theme.SubText
	AutoLoadToggle.TextSize = 12
	AutoLoadToggle.Font = Enum.Font.GothamBold
	AutoLoadToggle.AutoButtonColor = false
	AutoLoadToggle.Parent = ActionArea

	local AutoLoadCorner = Instance.new("UICorner")
	AutoLoadCorner.CornerRadius = UDim.new(0, 4)
	AutoLoadCorner.Parent = AutoLoadToggle

	local AutoLoadLine = Instance.new("UIStroke")
	AutoLoadLine.Color = Theme.Line
	AutoLoadLine.Thickness = 1
	AutoLoadLine.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	AutoLoadLine.Parent = AutoLoadToggle

	-- // Logic Variables
	local CurrentAction = nil
	local CurrentName = ""
	local IsLoading = false
	local AutoLoadEnabled = false

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

	-- // Fade In
	TweenService:Create(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {GroupTransparency = 0}):Play()

	-- // Close UI Function
	local function CloseUI()
		local closeTween = TweenService:Create(MainFrame, TweenInfo.new(TweenTime, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {GroupTransparency = 1})
		closeTween:Play()
		closeTween.Completed:Wait()
		ScreenGui:Destroy()
	end

	CloseBtn.MouseEnter:Connect(function() TweenService:Create(CloseBtn, TweenInfoFast, {TextColor3 = Color3.fromRGB(255, 60, 60)}):Play() end)
	CloseBtn.MouseLeave:Connect(function() TweenService:Create(CloseBtn, TweenInfoFast, {TextColor3 = Theme.SubText}):Play() end)
	CloseBtn.MouseButton1Click:Connect(CloseUI)

	-- // Auto Load Toggle Logic
	AutoLoadToggle.MouseButton1Click:Connect(function()
		if IsLoading then return end
		AutoLoadEnabled = not AutoLoadEnabled
		
		if AutoLoadEnabled then
			AutoLoadToggle.Text = "Auto: ON"
			AutoLoadToggle.TextColor3 = Theme.LightBlue
			AutoLoadLine.Color = Theme.LightBlue
			Library:Notification({Title = "Auto Load", Description = "Auto loading is enabled.", Duration = 2})
		else
			AutoLoadToggle.Text = "Auto: OFF"
			AutoLoadToggle.TextColor3 = Theme.SubText
			AutoLoadLine.Color = Theme.Line
			Library:Notification({Title = "Auto Load", Description = "Auto loading disabled.", Duration = 2})
		end
	end)

	-- // Load Button Logic (5s Timer & Close)
	LoadBtn.MouseEnter:Connect(function() 
		if not IsLoading then TweenService:Create(LoadBtn, TweenInfoFast, {BackgroundColor3 = Theme.LightBlue}):Play() end
	end)
	LoadBtn.MouseLeave:Connect(function() 
		if not IsLoading then TweenService:Create(LoadBtn, TweenInfoFast, {BackgroundColor3 = Theme.DarkBlue}):Play() end
	end)

	LoadBtn.MouseButton1Click:Connect(function()
		if CurrentAction and not IsLoading then
			IsLoading = true
			TweenService:Create(LoadBtn, TweenInfoFast, {BackgroundColor3 = Color3.fromRGB(50, 150, 50)}):Play()

			-- Start 5 second timer
			for i = 5, 1, -1 do
				LoadBtn.Text = "Loading " .. CurrentName .. " (" .. i .. "s)"
				task.wait(1)
			end

			LoadBtn.Text = "Executing..."
			
			-- Execute the script
			local success, err = pcall(CurrentAction)
			
			if success then
				Library:Notification({
					Title = "Success",
					Description = CurrentName .. " loaded successfully!",
					Duration = 3
				})
				task.wait(0.5)
				CloseUI() -- Closes UI on successful load
			else
				Library:Notification({
					Title = "Error",
					Description = "Failed to load script.",
					Duration = 4
				})
				IsLoading = false
				LoadBtn.Text = "Load Script"
				TweenService:Create(LoadBtn, TweenInfoFast, {BackgroundColor3 = Theme.DarkBlue}):Play()
			end
		elseif not CurrentAction then
			LoadBtn.Text = "Select a script first!"
			task.wait(1)
			LoadBtn.Text = "Load Script"
		end
	end)

	-- // Window Methods
	local Window = {}
	
	function Window:AddScript(ScriptConfig)
		local ItemBtn = Instance.new("TextButton")
		ItemBtn.Size = UDim2.new(1, 0, 0, 36)
		ItemBtn.BackgroundColor3 = Theme.Panel
		ItemBtn.Text = "  " .. ScriptConfig.Name
		ItemBtn.TextColor3 = Theme.SubText
		ItemBtn.TextSize = 13
		ItemBtn.Font = Enum.Font.Gotham
		ItemBtn.TextXAlignment = Enum.TextXAlignment.Left
		ItemBtn.AutoButtonColor = false
		ItemBtn.Parent = Catalogue

		local ItemCorner = Instance.new("UICorner")
		ItemCorner.CornerRadius = UDim.new(0, 4)
		ItemCorner.Parent = ItemBtn

		local ItemLine = Instance.new("UIStroke")
		ItemLine.Color = Theme.Line
		ItemLine.Thickness = 1
		ItemLine.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		ItemLine.Parent = ItemBtn

		ItemBtn.MouseEnter:Connect(function()
			if not IsLoading then TweenService:Create(ItemBtn, TweenInfoFast, {TextColor3 = Theme.Text, BackgroundColor3 = Theme.Background}):Play() end
		end)
		ItemBtn.MouseLeave:Connect(function()
			if not IsLoading then TweenService:Create(ItemBtn, TweenInfoFast, {TextColor3 = Theme.SubText, BackgroundColor3 = Theme.Panel}):Play() end
		end)

		ItemBtn.MouseButton1Click:Connect(function()
			if IsLoading then return end
			Thumbnail.Image = ScriptConfig.Thumbnail or ""
			ScriptName.Text = ScriptConfig.Name
			FeaturesList.Text = ScriptConfig.Features or "No features listed."
			CurrentAction = ScriptConfig.Action
			CurrentName = ScriptConfig.Name
		end)
	end

	return Window
end

return Library
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
