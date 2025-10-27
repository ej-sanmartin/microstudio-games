// Sounds: upload WAVs in the **Sounds** tab and call by asset name
// Example names: "bounce", "yahoo", "aww"
play = function(name)
  if soundUnlocked then audio.playSound(name, 1, 1, 0, false) end
end

unlock_sound_if_gesture = function()
  if soundUnlocked then return end
  
  if mouse.pressed or mouse.down then soundUnlocked = true end
  if touch.press or mouse.press then soundUnlocked = true end

  if keyboard.press.SPACE or keyboard.press.ENTER
     or keyboard.press.A or keyboard.press.D
     or keyboard.press.LEFT or keyboard.press.RIGHT then
    soundUnlocked = true
  end

  if gamepad.connected and (gamepad.press.A or gamepad.press.START) then
    soundUnlocked = true
  end
end
