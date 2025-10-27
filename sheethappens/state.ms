// --- Game state containers ---
state = "play"
score = 0
best  = 0

prevSheetMid = 0
celebrateTimer = 0

// drift
ambientDrift = 0
ambientTimer = 0

// difficulty tracking
difficultyStep = 0

// sound gate (mobile/desktop)
soundUnlocked = false

// actors
left  = object x = -40 end
right = object x =  40 end

jumper = object
  x = 0
  y = 80
  vx = 0
  vy = -6
end
