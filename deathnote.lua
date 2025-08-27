-- Death Note Script
-- Finds the closest player to "Id" parts and shows their name on the SurfaceGui

local Map = workspace:WaitForChild("Map")
local Players = game:GetService("Players")

-- Function to get closest player to a position
local function closestPlayerAtPos(Position)
    local MaxRange = math.huge
    local ClosestPlayer = nil
    
    for _, player in Players:GetPlayers() do
        local char = player.Character
        local root = char and char:FindFirstChild("HumanoidRootPart")
        if root then
            local dist = (root.Position - Position).Magnitude
            if dist < MaxRange then
                ClosestPlayer = player
                MaxRange = dist
            end
        end
    end
    
    return ClosestPlayer
end

-- Loop through all "Id" parts in the map
for _, v in Map:GetChildren() do
    if v:IsA("BasePart") and v.Name == "Id" then
        local SurfaceGui = v:FindFirstChild("SurfaceGui")
        if SurfaceGui then
            local textLabel = SurfaceGui:FindFirstChildWhichIsA("TextLabel")
            SurfaceGui:GetPropertyChangedSignal("Enabled"):Connect(function()
                if SurfaceGui.Enabled then
                    local closest = closestPlayerAtPos(v.Position)
                    if closest and textLabel then
                        textLabel.Text = "Kira is: " .. closest.Name
                    end
                else
                    if textLabel then
                        textLabel.Text = ""
                    end
                end
            end)
        end
    end
end
