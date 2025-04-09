-- SNIPPET BY @CO_RVUS
AnimationController.Load(Character,Animations[Weaponmodule[Character.Weaponfolder:GetAttribute("Weapon")].Animations]["LeanLeft"]):Stop(StopTime)
        end
    end
end

function Attack(Character,OnHitfunction,IsHeavy)

    if Character:FindFirstChild("Knocked") or Character:FindFirstChild("Gripping")  then
        return
    end

    if Character:FindFirstChild("TrueStun") then
        if not Character:FindFirstChild("dash") then
            return
        end
    end

    if Character:FindFirstChild("Weaponfolder") then
        if Character.Weaponfolder:GetAttribute("Attacking") then
            return
        end
    else
        return
    end

    local Direction = Character:FindFirstChild("Weaponfolder"):GetAttribute("Dir")
    if Direction ~= "Up" and Direction ~= "Right"  and Direction ~= "Left"  then
        return
    end
    PlayLean(Character,true)
    Character.Weaponfolder:SetAttribute("Attacking",true)
    if IsHeavy then
        Character.Weaponfolder:SetAttribute("Heavy",true)
    end
    for i,v in pairs(Character.Humanoid:GetPlayingAnimationTracks()) do
        v:Stop()
    end

    local Hit = false
    local Id = Animations[Weaponmodule[Character.Weaponfolder:GetAttribute("Weapon")].Animations][Direction.."Slash"]
    local Animation = AnimationController.Load(Character,Id)
    Animation:Play()    
    Animation:AdjustSpeed(Weaponmodule[Character.Weaponfolder:GetAttribute("Weapon")].BaseSpeed )

    if IsHeavy then
        Animation:AdjustSpeed(Weaponmodule[Character.Weaponfolder:GetAttribute("Weapon")].HeavySpeed)
    end
    if Character:FindFirstChild("LowStamina") then
        Animation:AdjustSpeed(Weaponmodule[Character.Weaponfolder:GetAttribute("Weapon")].LowSpeed)
        if IsHeavy then
            Animation:AdjustSpeed(Weaponmodule[Character.Weaponfolder:GetAttribute("Weapon")].LowSpeed-.13)
        end
