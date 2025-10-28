// Confetti for popped balloons
emit_confetti = function(x, y, sprite)
  local col = sprite_color(sprite)
  local n = CONFETTI_COUNT
  local i = 0
  while i < n
    local ang = randomRange(160, 380) * 0.0174533
    local spd = randomRange(CONFETTI_SPEED*0.5, CONFETTI_SPEED*1.1)
    local vx  = cos(ang) * spd
    local vy  = sin(ang) * spd
    local p = object
      x = x
      y = y
      vx = vx
      vy = vy
      life = randomRange(0.5, 0.9)
      color = col
    end
    particles.push(p)
    i += 1
  end
end

// Fire burst for bomb
emit_fire = function(x, y)
  local n = FIRE_COUNT
  local i = 0
  while i < n
    local ang = randomRange(70, 110) * 0.0174533
    local spd = randomRange(FIRE_SPEED*0.7, FIRE_SPEED*1.2)
    local vx  = cos(ang) * spd
    local vy  = sin(ang) * spd
    local r = floor(randomRange(200,255))
    local g = floor(randomRange(80,180))
    local b = floor(randomRange(20,60))
    local col = "rgb(" + r + "," + g + "," + b + ")"
    local p = object
      x = x
      y = y
      vx = vx
      vy = vy
      life = randomRange(0.4, 0.7)
      color = col
    end
    particles.push(p)
    i += 1
  end
end

update_particles = function(dt)
  local i = 0
  while i < particles.length
    local p = particles[i]
    p.vx *= PART_FRICTION
    p.vy = p.vy - PART_GRAVITY * dt
    p.x  = p.x + p.vx * dt
    p.y  = p.y + p.vy * dt
    p.life -= dt
    if p.life <= 0 then
      particles.remove(i)
    else
      i += 1
    end
  end
end

draw_particles = function()
  local i = 0
  while i < particles.length
    local p = particles[i]
    screen.setColor(p.color)
    screen.fillRect(sx(p.x - PART_SIZE/2), sy(p.y - PART_SIZE/2), PART_SIZE, PART_SIZE)
    i += 1
  end
end
