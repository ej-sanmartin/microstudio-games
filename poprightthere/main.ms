// ====== LIFECYCLE ======
init = function()
  game_time = 0
  best = storage.get("best") or 0
  game_state = "start"
  start_music()
end

update = function()
  if game_state == "start" then
    if just_pressed() then
      sfx_unlock()
      reset_run()
      game_state = "play"
    end
    return
  end

  if game_state == "play" then
    now_ms = system.time()
    dt_sec = (now_ms - prev_ms) / 1000
    update_particles(dt_sec)

    if delta_time > 0 then
      delta_time -= dt_sec
      if delta_time < 0 then delta_time = 0 end
    end
    
    // update camera shake
    if shake_t > 0 then
      shake_t -= dt_sec
      if shake_t < 0 then shake_t = 0 end
      local k = shake_t / SHAKE_DURATION
      local mag = SHAKE_MAG * k
      shake_dx = randomRange(-mag, mag)
      shake_dy = randomRange(-mag, mag)
    else
      shake_dx = 0
      shake_dy = 0
    end
    
    prev_ms = now_ms
    
    elapsed += dt_sec
    spawn_timer += dt_sec

    // ramp difficulty
    if elapsed - last_ramp_t >= RAMP_EVERY_SEC then
      last_ramp_t = elapsed
      spawn_interval = clamp(spawn_interval - SPAWN_DEC_STEP, SPAWN_INTERVAL_MIN, 10)
      speed_bonus += SPEED_INC_STEP
    end

    // spawn
    if spawn_timer >= spawn_interval then
      spawn_timer -= spawn_interval
      spawn_balloon()
    end

    update_balloons()

    // input
    if just_pressed() then
      sfx_unlock()
      local pt = pointer_xy()
      local hit = hit_test_bulb(pt.x, pt.y)
      if hit != nil then
        local idx = hit.index
        local ent = hit.entity
        if ent.is_bomb or (ent.sprite == "bomb") then
          emit_fire(ent.x, ent.y)
          play_sfx_bomb()
          game_over("bomb")
        else
          emit_confetti(ent.x, ent.y, ent.sprite)
          play_sfx_pop()
          score += ent.points
          last_delta = ent.points
          delta_time = DELTA_SHOW
          balloons.remove(idx)
        end
      end
    end

    // end on timer
    if elapsed >= SESSION_LENGTH then
      game_state = "summary"
      if score > best then
        best = score
        storage.set("best", best)
      end
    end
    return
  end

  if game_state == "gameover" or game_state == "summary" then
    // continue shake on gameover
    if game_state == "gameover" then
      if shake_t > 0 then
        local dt = (system.time() - prev_ms) / 1000
        prev_ms = system.time()
        shake_t -= dt
        if shake_t < 0 then shake_t = 0 end
        local k = shake_t / SHAKE_DURATION
        local mag = SHAKE_MAG * k
        shake_dx = randomRange(-mag, mag)
        shake_dy = randomRange(-mag, mag)
      else
        shake_dx = 0
        shake_dy = 0
      end
    end

    if just_pressed() and (system.time() >= restart_ready_at) then
      game_state = "start"
    end
    return
  end
end

draw = function()
  // --- Responsive font scale (tune baseline as you wish) ---
  local BASE_H = 240
  local font_scale = screen.height / BASE_H

  // precompute sizes
  local SIZE_TITLE      = clampf(16 * font_scale, 10, 22)
  local SIZE_SUBTITLE   = clampf(8  * font_scale, 7, 13)
  local SIZE_HUD        = clampf(9  * font_scale, 7, 14)
  local SIZE_HUD_DELTA  = clampf(12 * font_scale, 9, 18)
  local SIZE_GO_TITLE   = clampf(18 * font_scale, 12, 26)

  // --- Background ---
  screen.clear()
  screen.setColor("rgb(135,206,250)")
  screen.fillRect(sx(0), sy(0), screen.width, screen.height)

  // --- START SCREEN ---
  if game_state == "start" then
    screen.setFont("PressStart2P")
    screen.setColor("rgb(20,20,40)")
    screen.drawText("POP RIGHT THERE!", sx(0), sy(45), SIZE_TITLE)

    screen.setFont("PixelOperator")
    screen.setColor("rgb(10,10,20)")
    screen.drawText("Tap balloons for points.", sx(0), sy(20), SIZE_SUBTITLE)
    screen.drawText("Don't tap the bomb!",     sx(0), sy(5),  SIZE_SUBTITLE)
    screen.drawText("Tap to start",            sx(0), sy(-30), SIZE_SUBTITLE)
    return
  end

  // --- GAME ---
  draw_balloons()
  draw_particles()

  // HUD
  screen.setFont("PixelOperator")
  screen.setColor("rgb(10,10,20)")
  local bottom = -screen.height/2 + (12 * font_scale)

  screen.drawText("Score: " + score, sx(-screen.width/2 + 55), sy(bottom), SIZE_HUD)

  if game_state == "play" then
    local remain = max(0, floor((SESSION_LENGTH - elapsed) + 0.5))
    screen.drawText("Time: " + ("" + remain), sx(0), sy(bottom), SIZE_HUD)
  end

  screen.drawText("Best: " + ("" + best), sx(screen.width/2 - 55), sy(bottom), SIZE_HUD)

  // delta popup
  if delta_time > 0 then
    local dy = (18 * font_scale) + (1 - delta_time/DELTA_SHOW) * (12 * font_scale)
    local txt = ""
    if last_delta >= 0 then
      txt = "+" + last_delta
      screen.setColor("rgb(30,160,60)")
    else
      txt = "" + last_delta
      screen.setColor("rgb(200,40,40)")
    end
    screen.drawText(txt, sx(-screen.width/2 + 55), sy(bottom + dy), SIZE_HUD_DELTA)
  end

  // --- END SCREENS ---
  if game_state == "gameover" then
    screen.setFont("PressStart2P")
    screen.setColor("rgb(180,20,20)")
    screen.drawText("BOOM!", sx(0), sy(40), SIZE_GO_TITLE)

    screen.setFont("PixelOperator")
    screen.setColor("rgb(10,10,20)")
    screen.drawText("Final Score: " + score, sx(0), sy(18), SIZE_SUBTITLE)
    screen.drawText("Tap to retry",          sx(0), sy(-6),  SIZE_SUBTITLE)

  elsif game_state == "summary" then
    screen.setFont("PressStart2P")
    screen.setColor("rgb(20,120,40)")
    screen.drawText("Time!", sx(0), sy(40), SIZE_GO_TITLE)

    screen.setFont("PixelOperator")
    screen.setColor("rgb(10,10,20)")
    screen.drawText("Final Score: " + score, sx(0), sy(18), SIZE_SUBTITLE)
    screen.drawText("Tap to play again",     sx(0), sy(-6),  SIZE_SUBTITLE)
  end
end
