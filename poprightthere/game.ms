// ====== GAME FLOW ======
reset_run = function()
  balloons = []
  score = 0
  spawn_interval = SPAWN_INTERVAL_START
  spawn_timer = 0
  speed_bonus = 0
  elapsed = 0
  last_ramp_t = 0
  now_ms = system.time()
  prev_ms = now_ms
  dt_sec = 0
  end_reason = ""
end

game_over = function(reason)
  game_state = "gameover"
  end_reason = reason or "bomb"

  if end_reason == "bomb" then
    shake_t = SHAKE_DURATION
  end

  restart_ready_at = system.time() + floor(RESTART_COOLDOWN * 1000)
  if score > best then
    best = score
    storage.set("best", best)
  end
end
