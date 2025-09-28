-- ESP Library
local ESP = {}
local active = false
local connections = {}

function ESP:Add(plr)
    if plr == game.Players.LocalPlayer then return end
    local char = plr.Character or plr.CharacterAdded:Wait()
    local head = char:WaitForChild("Head", 5)

    -- Billboard
    local gui = Instance.new("BillboardGui")
    gui.AlwaysOnTop = true
    gui.Size = UDim2.new(0, 100, 0, 20)
    gui.StudsOffset = Vector3.new(0, 2, 0)
    gui.Parent = head

    local txt = Instance.new("TextLabel")
    txt.Size = UDim2.new(1, 0, 1, 0)
    txt.BackgroundTransparency = 1
    txt.Text = plr.Name
    txt.TextColor3 = Color3.fromRGB(255, 50, 50)
    txt.TextScaled = true
    txt.TextStrokeTransparency = 0
    txt.Font = Enum.Font.SourceSansBold
    txt.Parent = gui

    -- Highlight
    local hl = Instance.new("Highlight")
    hl.FillTransparency = 0.7
    hl.OutlineColor = Color3.fromRGB(255, 50, 50)
    hl.Parent = char

    connections[plr] = {gui, hl}
end

function ESP:Remove(plr)
    if connections[plr] then
        for _, v in pairs(connections[plr]) do v:Destroy() end
        connections[plr] = nil
    end
end

function ESP:Enable()
    if active then return end
    active = true
    for _, plr in ipairs(game.Players:GetPlayers()) do
        ESP:Add(plr)
    end
end

function ESP:Disable()
    active = false
    for plr, _ in pairs(connections) do
        ESP:Remove(plr)
    end
end

return ESP
