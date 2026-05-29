local CoreGui = game:GetService("CoreGui")
local loading = CoreGui:FindFirstChild("loading")

while loading do
    task.wait()
    loading = CoreGui:FindFirstChild("loading")
end

loading = CoreGui:FindFirstChild("loading")

local parent = game.CoreGui

local ScreenGui1 = Instance.new("ScreenGui", parent)
ScreenGui1.ResetOnSpawn = false
ScreenGui1.Name = "loading"
ScreenGui1.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local Frame2 = Instance.new("Frame", ScreenGui1)
Frame2.Name = "Main"
Frame2.Position = UDim2.new(0.295644879, 0, 0.253467858, 0)
Frame2.BorderColor3 = Color3.new(0, 0, 0)
Frame2.Size = UDim2.new(0, 488, 0, 326)
Frame2.BorderSizePixel = 0
Frame2.BackgroundColor3 = Color3.new(1, 1, 1)

local ImageLabel3 = Instance.new("ImageLabel", Frame2)
ImageLabel3.Image = "rbxassetid://8215072078"
ImageLabel3.Name = "Background"
ImageLabel3.BorderColor3 = Color3.new(0, 0, 0)
ImageLabel3.Size = UDim2.new(0, 488, 0, 326)
ImageLabel3.BorderSizePixel = 0
ImageLabel3.BackgroundColor3 = Color3.new(1, 1, 1)

local UICorner4 = Instance.new("UICorner", ImageLabel3)
UICorner4.CornerRadius = UDim.new(0, 4)

local UICorner5 = Instance.new("UICorner", Frame2)
UICorner5.CornerRadius = UDim.new(0, 4)

local Script6 = Instance.new("Script", Frame2)
Script6.Name = "Drag"

local TextLabel7 = Instance.new("TextLabel", Frame2)
TextLabel7.TextColor3 = Color3.new(1, 1, 1)
TextLabel7.BorderColor3 = Color3.new(0, 0, 0)
TextLabel7.Text = ""
TextLabel7.TextTransparency = 1
TextLabel7.TextSize = 33
TextLabel7.Font = Enum.Font.Code
TextLabel7.BackgroundTransparency = 1
TextLabel7.Position = UDim2.new(0.422131151, 0, 0.469325155, 0)
TextLabel7.Name = "Text"
TextLabel7.Size = UDim2.new(0, 75, 0, 19)
TextLabel7.BorderSizePixel = 0
TextLabel7.BackgroundColor3 = Color3.new(1, 1, 1)

local Script8 = Instance.new("Script", TextLabel7)
Script8.Name = "script"

local TextLabel9 = Instance.new("TextLabel", Frame2)
TextLabel9.TextColor3 = Color3.new(1, 1, 1)
TextLabel9.BorderColor3 = Color3.new(0, 0, 0)
TextLabel9.Text = "Loader"
TextLabel9.TextSize = 33
TextLabel9.Font = Enum.Font.Code
TextLabel9.BackgroundTransparency = 1
TextLabel9.Position = UDim2.new(0.0471311472, 0, 0.0214723926, 0)
TextLabel9.Name = "Title"
TextLabel9.Size = UDim2.new(0, 75, 0, 19)
TextLabel9.BorderSizePixel = 0
TextLabel9.BackgroundColor3 = Color3.new(1, 1, 1)

local TextLabel10 = Instance.new("TextLabel", Frame2)
TextLabel10.TextColor3 = Color3.new(1, 1, 1)
TextLabel10.BorderColor3 = Color3.new(0, 0, 0)
TextLabel10.Text = "%0"
TextLabel10.TextSize = 22
TextLabel10.Font = Enum.Font.Code
TextLabel10.BackgroundTransparency = 1
TextLabel10.Position = UDim2.new(0.422131151, 0, 0.57055217, 0)
TextLabel10.Name = "Number"
TextLabel10.Size = UDim2.new(0, 75, 0, 19)
TextLabel10.BorderSizePixel = 0
TextLabel10.BackgroundColor3 = Color3.new(1, 1, 1)

local TextButton11 = Instance.new("TextButton", Frame2)
TextButton11.TextColor3 = Color3.new(0, 0, 0)
TextButton11.BorderColor3 = Color3.new(0, 0, 0)
TextButton11.Text = ""
TextButton11.Font = Enum.Font.SourceSans
TextButton11.Name = "Close"
TextButton11.Position = UDim2.new(0.924180329, 0, 0.0214723926, 0)
TextButton11.TextSize = 14
TextButton11.Size = UDim2.new(0, 28, 0, 28)
TextButton11.BorderSizePixel = 0
TextButton11.BackgroundColor3 = Color3.new(1, 0.494118, 0.494118)

local UICorner12 = Instance.new("UICorner", TextButton11)

local Script13 = Instance.new("Script", TextButton11)
Script13.Name = "script3"

spawn(function()
local script = Script6
local userInputService = game:GetService("UserInputService")
local tweenService = game:GetService("TweenService")

local frame = script.Parent

local stroke = Instance.new("UIStroke")
stroke.Parent = frame
stroke.Thickness = 1
stroke.Color = Color3.fromRGB(255, 255, 255)
stroke.Transparency = 1
stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
stroke.LineJoinMode = Enum.LineJoinMode.Round

local shadow = Instance.new("Frame")
shadow.Name = "Shadow"
shadow.Parent = frame.Parent
shadow.Size = frame.Size
shadow.Position = frame.Position
shadow.AnchorPoint = frame.AnchorPoint
shadow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
shadow.BackgroundTransparency = 1
shadow.BorderSizePixel = 0
shadow.ZIndex = frame.ZIndex - 1

local shadowCorner = Instance.new("UICorner")
shadowCorner.CornerRadius = UDim.new(0, 12)
shadowCorner.Parent = shadow

local dragging = false
local dragInput
local dragStart
local startPos

local function update(input)
local delta = input.Position - dragStart

local newPos = UDim2.new(
startPos.X.Scale,
startPos.X.Offset + delta.X,
startPos.Y.Scale,
startPos.Y.Offset + delta.Y
)

frame.Position = newPos

tweenService:Create(shadow, TweenInfo.new(0.08), {
Position = UDim2.new(newPos.X.Scale, newPos.X.Offset + 8, newPos.Y.Scale, newPos.Y.Offset + 8)
}):Play()
end

frame.InputBegan:Connect(function(input)
if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
dragging = true
dragStart = input.Position
startPos = frame.Position

tweenService:Create(stroke, TweenInfo.new(0.15), {Transparency = 0}):Play()
tweenService:Create(shadow, TweenInfo.new(0.15), {BackgroundTransparency = 0.7}):Play()

input.Changed:Connect(function()
if input.UserInputState == Enum.UserInputState.End then
dragging = false
tweenService:Create(stroke, TweenInfo.new(0.15), {Transparency = 1}):Play()
tweenService:Create(shadow, TweenInfo.new(0.15), {
BackgroundTransparency = 1,
Position = UDim2.new(frame.Position.X.Scale, frame.Position.X.Offset + 4, frame.Position.Y.Scale, frame.Position.Y.Offset + 4)
}):Play()
end
end)
end
end)

frame.InputChanged:Connect(function(input)
if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
dragInput = input
end
end)

userInputService.InputChanged:Connect(function(input)
if input == dragInput and dragging then
update(input)
end
end)

shadow.Position = UDim2.new(frame.Position.X.Scale, frame.Position.X.Offset + 4, frame.Position.Y.Scale, frame.Position.Y.Offset + 4)
end)

spawn(function()
local script = Script8
local TweenService = game:GetService("TweenService")

local text = script.Parent
local number = script.Parent.Parent.Number
local frame = script.Parent.Parent
local gui = script.Parent.Parent.Parent

repeat task.wait() until game:IsLoaded()

local function fadeText(label, newText)
local fadeOut = TweenService:Create(label, TweenInfo.new(0.7), {TextTransparency = 1})
fadeOut:Play()
fadeOut.Completed:Wait()
label.Text = newText
local fadeIn = TweenService:Create(label, TweenInfo.new(0.7), {TextTransparency = 0})
fadeIn:Play()
fadeIn.Completed:Wait()
end

local function fadeFrame()
for _, v in pairs(frame:GetDescendants()) do
if v:IsA("TextLabel") or v:IsA("TextButton") then
TweenService:Create(v, TweenInfo.new(1), {TextTransparency = 1, BackgroundTransparency = 1}):Play()
elseif v:IsA("Frame") then
TweenService:Create(v, TweenInfo.new(1), {BackgroundTransparency = 1}):Play()
elseif v:IsA("ImageLabel") or v:IsA("ImageButton") then
TweenService:Create(v, TweenInfo.new(1), {ImageTransparency = 1, BackgroundTransparency = 1}):Play()
end
end
task.wait(1)
gui:Destroy()
end

text.TextTransparency = 0
number.TextTransparency = 1

fadeText(text, "Hi")
task.wait(3)
fadeText(text, "Loading UI and another stuff")

number.Text = "%0"

local numberFade = TweenService:Create(number, TweenInfo.new(0.7), {TextTransparency = 0})
numberFade:Play()
numberFade.Completed:Wait()

for i = 0, 100 do
number.Text = "%" .. i
task.wait(0.05)
end

fadeFrame()
end)

spawn(function()
local script = Script13
local button = script.Parent
local main = script.Parent.Parent
local gui = main.Parent

local TweenService = game:GetService("TweenService")

button.MouseButton1Click:Connect(function()
local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

for _, v in ipairs(main:GetDescendants()) do
if v:IsA("Frame") then
TweenService:Create(v, tweenInfo, {BackgroundTransparency = 1}):Play()
elseif v:IsA("TextLabel") or v:IsA("TextButton") then
TweenService:Create(v, tweenInfo, {BackgroundTransparency = 1, TextTransparency = 1}):Play()
elseif v:IsA("ImageLabel") or v:IsA("ImageButton") then
TweenService:Create(v, tweenInfo, {BackgroundTransparency = 1, ImageTransparency = 1}):Play()
end
end

TweenService:Create(main, tweenInfo, {BackgroundTransparency = 1}):Play()

task.wait(0.5)
gui:Destroy()
end)
end)
