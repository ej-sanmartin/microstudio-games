get_axis = function()
  ax = 0
  if keyboard.LEFT  then ax -= 1 end
  if keyboard.A     then ax -= 1 end
  if keyboard.RIGHT then ax += 1 end
  if keyboard.D     then ax += 1 end

  // touch: halves fallback
  if touch.available and touch.touching then
    if touch.x < 0 then ax -= 1 else ax += 1 end
  end

  if gamepad.connected and abs(gamepad.lx) > 0.2 then ax = gamepad.lx end
  if ax < -1 then ax = -1 end
  if ax >  1 then ax =  1 end
  return ax
end
