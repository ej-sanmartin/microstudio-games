sfx_unlocked = false

game_state = "start"   // "start" | "play" | "gameover" | "summary"
balloons = []
score = 0
best  = 0

last_delta = 0
delta_time = 0
DELTA_SHOW = 0.6

spawn_interval = SPAWN_INTERVAL_START
spawn_timer = 0
speed_bonus = 0
elapsed = 0
last_ramp_t = 0
now_ms = 0
prev_ms = 0
dt_sec = 0

end_reason = ""
