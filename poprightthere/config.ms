// ====== CONFIG / TUNABLES ======
BALLOON_SPRITE_W = 72
BALLOON_SPRITE_H = 110
BULB_RADIUS      = 28
BULB_OFFSET_Y    = 22

SPAWN_INTERVAL_START = 0.60
SPAWN_INTERVAL_MIN   = 0.25
SPEED_Y_MIN   = 2.1
SPEED_Y_MAX   = 4.2
DRIFT_X_ABS   = 0.55

SESSION_LENGTH = 20.0
MAX_ONSCREEN   = 15

// === FX / SFX ===
CONFETTI_COUNT = 14
CONFETTI_SPEED = 160
FIRE_COUNT     = 22
FIRE_SPEED     = 240
PART_SIZE      = 3
PART_GRAVITY   = 260
PART_FRICTION  = 0.98

// --- MUSIC ---
MUSIC_BG      = "poprightthere"
music_started = false

// --- SHAKE FX ---
SHAKE_DURATION = 0.45
SHAKE_MAG      = 12

shake_t  = 0
shake_dx = 0
shake_dy = 0

RESTART_COOLDOWN = 1.50

particles = []
restart_ready_at = 0

// spawn mix
SPAWN_WEIGHTS = object
  red = 0.28
  blue = 0.22
  green = 0.18
  yellow = 0.14
  purple = 0.10
  bomb = 0.08
end

POINTS = object
  red = 1
  blue = 2
  green = 3
  yellow = 4
  purple = 5
end

// --- SFX names ---
SFX = object
  pop = "pop"
  bomb = "bomb"
  miss = "miss"
end

// difficulty ramp
RAMP_EVERY_SEC = 4
SPAWN_DEC_STEP = 0.08
SPEED_INC_STEP = 0.12
