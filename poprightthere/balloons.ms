spawn_balloon = function()
  if balloons.length >= MAX_ONSCREEN then return end

  local kind = rand_choice_weighted(SPAWN_WEIGHTS)
  local x = randomRange(-screen.width/2 + 40, screen.width/2 - 40)
  local y = -screen.height/2 - (BALLOON_SPRITE_H/2 + 8)
  local vy = randomRange(SPEED_Y_MIN, SPEED_Y_MAX) + speed_bonus
  local vx = randomRange(-DRIFT_X_ABS, DRIFT_X_ABS)

  local is_bomb = (kind == "bomb")
  local sprite  = is_bomb and "bomb" or kind
  local points  = is_bomb and 0       or POINTS[kind]
  
  local b = object
    x = x
    y = y
    vx = vx
    vy = vy
    sprite = sprite
    is_bomb = is_bomb
    points = points
    w = BALLOON_SPRITE_W
    h = BALLOON_SPRITE_H
  end

  balloons.push(b)
end

update_balloons = function()
  local i = 0
  while i < balloons.length
    local b = balloons[i]
    b.x += b.vx
    b.y += b.vy

    if b.x < -screen.width/2 + 30 or b.x > screen.width/2 - 30 then
      b.vx = -b.vx
    end
    
    // Missed off the top?
    if (b.y + b.h/1000 - 40) >= (screen.height/2 + 8) then
      if not b.is_bomb then
        score -= b.points * 2
        last_delta = -b.points * 2
        delta_time = DELTA_SHOW
        play_sfx_miss()
      end
      balloons.remove(i)
    else
      i += 1
    end
  end
end

draw_balloons = function()
  local i = 0
  while i < balloons.length
    local b = balloons[i]
    screen.drawSprite(b.sprite, sx(b.x), sy(b.y), b.w, b.h)
    i += 1
  end
end

hit_test_bulb = function(mx, my)
  local i = 0
  while i < balloons.length
    local b = balloons[i]
    local bulb_cx = b.x
    local bulb_cy = b.y + BULB_OFFSET_Y
    if dist2(mx, my, bulb_cx, bulb_cy) <= (BULB_RADIUS * BULB_RADIUS) then
      return object
        index = i
        entity = b
      end
    end
    i += 1
  end
  return nil
end
