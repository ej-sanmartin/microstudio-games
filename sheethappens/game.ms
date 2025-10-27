init = function()
  SHEET_Y = screen.height/2 - 140
  GRAVITY = BASE_GRAVITY
  SHEET_SHRINK = BASE_SHEET_SHRINK
  b = storage.get("best")
  if b != nil then best = b end
  reset()
end

reset = function()
  state = "play"
  score = 0
  GRAVITY = BASE_GRAVITY
  SHEET_SHRINK = BASE_SHEET_SHRINK
  difficultyStep = 0

  left.x  = -40
  right.x =  40

  localSheetMid = (left.x + right.x) / 2

  // start higher; fall under gravity
  jumper.x  = localSheetMid + randomRange(-30, 30)
  jumper.y  = SHEET_Y + 120
  jumper.vx = randomRange(-1.2, 1.2)
  jumper.vy = 0

  ambientDrift = 0
  ambientTimer = 0

  prevSheetMid = localSheetMid
end

update = function()
  unlock_sound_mobile()

  if state == "play" then
    ax = get_axis()
    unlock_sound_desktop(ax)

    // move carriers as one
    left.x  += ax * MOVE
    right.x += ax * MOVE

    // spacing
    if right.x - left.x < MIN_GAP then right.x = left.x + MIN_GAP end

    // clamps
    halfW = screen.width * 0.45
    if left.x < -halfW then
      offset = -halfW - left.x
      left.x += offset
      right.x += offset
    end
    if right.x > halfW then
      offset = right.x - halfW
      left.x -= offset
      right.x -= offset
    end

    // sheet geometry
    sheetMid = (left.x + right.x) / 2
    sheetW   = (right.x - left.x) * SHEET_SHRINK
    sheetDX  = sheetMid - prevSheetMid

    // finger-follow override (mobile)
    if touch.available and touch.touching then
      ax = (touch.x - sheetMid) / (screen.width * 0.5)
      if ax < -1 then ax = -1 end
      if ax >  1 then ax =  1 end
      left.x  += ax * MOVE
      right.x += ax * MOVE
      // recompute after move
      sheetMid = (left.x + right.x) / 2
      sheetW   = (right.x - left.x) * SHEET_SHRINK
      sheetDX  = sheetMid - prevSheetMid
    end

    // physics
    prevY = jumper.y
    jumper.vy += GRAVITY
    jumper.x  += jumper.vx
    jumper.y  += jumper.vy

    // ambient drift
    ambientTimer += 1
    if ambientTimer >= AMBIENT_TICKS then
      ambientTimer = 0
      ambientDrift = randomRange(-AMBIENT_DRIFT_MAX, AMBIENT_DRIFT_MAX)
    end
    jumper.vx += ambientDrift * 0.01
    if jumper.vx < -VX_MAX then jumper.vx = -VX_MAX end
    if jumper.vx >  VX_MAX then jumper.vx =  VX_MAX end

    // bounce (crossing test)
    bandTop = SHEET_Y + SHEET_THICK/2
    if jumper.vy < 0 and prevY >= bandTop and jumper.y <= bandTop and abs(jumper.x - sheetMid) <= sheetW/2 then
      jumper.y  = bandTop + EPS
      jumper.vy = sqrt(2 * abs(GRAVITY) * TARGET_APEX)

      hit   = (jumper.x - sheetMid) / (sheetW/2)
      carry = sheetDX
      jumper.vx += hit * HIT_K + carry * CARRIER_K

      ambientTimer = 0
      ambientDrift = ambientDrift * 0.5

      if jumper.vx < -VX_MAX then jumper.vx = -VX_MAX end
      if jumper.vx >  VX_MAX then jumper.vx =  VX_MAX end
      jumper.vx *= 0.995

      score += 1
      play("bounce")

      if (score % CELEB_STEP) == 0 then
        celebrateTimer = CELEB_TIME
        play("yahoo")
        jumper.vy = sqrt(2 * abs(GRAVITY) * (TARGET_APEX * 1.5))  // extra high
      end
    end

    // walls (match carriers)
    wall = halfW
    if jumper.x < -wall then jumper.x = -wall
      jumper.vx = -jumper.vx * 0.6
    end
    if jumper.x >  wall then jumper.x =  wall
      jumper.vx = -jumper.vx * 0.6
    end

    // fail
    if jumper.y < (-screen.height/2 - 20) then
      state = "gameover"
      play("aww")
      if score > best then
        best = score
        storage.set("best", best)
      end
    end

  else
    if keyboard.space or mouse.pressed or (touch.available and touch.pressed) then
      reset()
    end
  end

  // difficulty ramp (only shrink sheet; gravity still ramps in your version)
  step = floor(score / 10)
  if step > difficultyStep then
    difficultyStep = step
    GRAVITY = GRAVITY - 0.01
    SHEET_SHRINK = max(0.5, SHEET_SHRINK - 0.02)
  end

  jumper.vx *= 0.995
  prevSheetMid = sheetMid
end
