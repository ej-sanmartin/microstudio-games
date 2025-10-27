draw = function()
  // bg
  screen.clear("#202530")

  // sheet
  sheetMid = (left.x + right.x)/2
  sheetW   = (right.x - left.x) * SHEET_SHRINK
  screen.drawSprite("sheet", sheetMid, SHEET_Y, sheetW, SHEET_THICK)

  // men gripping edges
  edgeL = sheetMid - sheetW/2 - 10
  edgeR = sheetMid + sheetW/2 + 10
  screen.drawSprite("man", edgeL, SHEET_Y - 5, 20, 20)
  screen.setDrawScale(-1, 1)
  screen.drawSprite("man", edgeR, SHEET_Y - 5, 20, 20)
  screen.setDrawScale(1, 1)

  // jumper
  screen.drawSprite("jumper", jumper.x, jumper.y, 18, 18)

  // walls (visual)
  wall = screen.width * 0.45
  screen.setLineWidth(2)
  topY  = screen.height/2
  feetY = SHEET_Y - 5
  screen.drawLine(-wall, feetY, -wall, topY, "#ffffff")
  screen.drawLine( wall, feetY,  wall, topY, "#ffffff")

  // celebration confetti
  if celebrateTimer > 0 then
    cx = sheetMid
    cy = SHEET_Y
    localCount = CELEB_COUNT
    if screen.width < 360 or screen.height < 640 then localCount = 16 end
    for i = 1 to localCount by 1
      r  = (CELEB_TIME - celebrateTimer + random.next()*2) * 2
      a  = random.next() * 6.28318
      px = cx + r * cos(a)
      py = cy + r * sin(a)
      screen.fillRect(px-1, py-1, 2, 2, "#ffffff")
    end
    celebrateTimer -= 1
  end

  // UI
  scoreSize = max(14, floor(screen.height * 0.05))
  bestSize  = max(10, floor(screen.height * 0.03))
  screen.drawText(score + "", 0, -screen.height/2 + scoreSize, scoreSize, "#ffffff")
  screen.drawText("best " + best, 0, -screen.height/2 + scoreSize + bestSize + 4, bestSize, "#9ab")

  if state == "gameover" then
    screen.drawText("Game Over", 0, 0, 20, "#ffd166")
    screen.drawText("Tap / Space to retry", 0, 18, 12, "#fff")
  end
end
