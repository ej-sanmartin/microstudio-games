// Sounds: upload WAVs in the **Sounds** tab and call by asset name
// Example names: "bounce", "yahoo", "aww"
play = function(name)
  if soundUnlocked then audio.playSound(name, 1, 1, 0, false) end
end

unlock_sound_mobile = function()
  if not soundUnlocked then
    if touch.available and (touch.pressed or touch.touching) then soundUnlocked = true end
    // keyboard.any is not real; leave to desktop unlock
  end
end

unlock_sound_desktop = function(ax)
  if not soundUnlocked then
    if mouse.pressed then soundUnlocked = true end
    if ax != 0 then soundUnlocked = true end
    if keyboard.SPACE or keyboard.ENTER then soundUnlocked = true end
  end
end
