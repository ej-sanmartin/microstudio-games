rand_choice_weighted = function(tbl_weights)
  local kinds   = ["red","blue","green","yellow","purple","bomb"]
  local weights = [tbl_weights.red, tbl_weights.blue, tbl_weights.green,
                   tbl_weights.yellow, tbl_weights.purple, tbl_weights.bomb]

  local total = 0
  local i = 0
  while i < weights.length
    total += weights[i]
    i += 1
  end

  local r = randomRange(0, total)
  local acc = 0
  i = 0
  while i < weights.length
    acc += weights[i]
    if r <= acc then return kinds[i] end
    i += 1
  end
  return "red"
end

clamp = function(v, a, b)
  if v < a then return a end
  if v > b then return b end
  return v
end

sign = function(v) if v < 0 then return -1 else return 1 end end

dist2 = function(x1,y1,x2,y2)
  local dx = x1 - x2
  local dy = y1 - y2
  return dx*dx + dy*dy
end

sx = function(x) return x + shake_dx end
sy = function(y) return y + shake_dy end

randomRange = function(min, max)
  return min + (max - min) * random.next()
end

sprite_color = function(sp)
  if sp == "red"    then return "rgb(220,40,40)" end
  if sp == "blue"   then return "rgb(50,90,210)" end
  if sp == "green"  then return "rgb(40,160,70)" end
  if sp == "yellow" then return "rgb(240,200,40)" end
  if sp == "purple" then return "rgb(150,70,200)" end
  return "rgb(200,200,200)"
end
