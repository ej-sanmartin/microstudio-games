just_pressed = function()
  return (touch.press or mouse.pressed)
end

pointer_xy = function()
  if touch.touch then
    return object x = touch.x y = touch.y end
  else
    return object x = mouse.x y = mouse.y end
  end
end
