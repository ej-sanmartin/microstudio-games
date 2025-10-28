sfx_unlock = function()
  if sfx_unlocked then return end
  audio.playSound(SFX.pop)   // gesture-unlock on mobile
  sfx_unlocked = true
  start_music()
end

play_sfx_pop = function()
  audio.playSound(SFX.pop)
end

play_sfx_bomb = function()
  audio.playSound(SFX.bomb)
end

play_sfx_miss = function()
  audio.playSound(SFX.miss)
end

start_music = function()
  if music_started then return end
  if audio and audio.playMusic then
    audio.playMusic(MUSIC_BG, true) // loop
  elsif audio and audio.playSound then
    audio.playSound(MUSIC_BG, 0, 1, true) // pan=0, pitch=1, loop=true
  end
  music_started = true
end
