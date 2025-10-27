get_axis = function()
  ax = 0

  // Desktop / gamepad
  if keyboard.LEFT  then ax -= 1 end
  if keyboard.A     then ax -= 1 end
  if keyboard.RIGHT then ax += 1 end
  if keyboard.D     then ax += 1 end
  if gamepad.connected and abs(gamepad.lx) > 0.2 then ax = gamepad.lx end

  // Mobile: while touching, left half = -1, right half = +1
  // NOTE: Mobile not working
  if touch.available and (touch.touching or touch.pressed) then
    if touch.x < 0 then ax = -1 else ax = 1 end
  end

  return ax
end
