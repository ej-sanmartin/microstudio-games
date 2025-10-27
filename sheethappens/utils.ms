randomRange = function(min, max)
  return min + (max - min) * random.next()
end

sqrt = function(x)
  if x < 0 then return 0 end
  return x ^ 0.5
end
