room(:restroom) do
  self.short_desc = "restroom"
  self.desc = <<-DESC
    I've entered a cosy looking RESTROOM. 
    There's a damp tunnel to the NORTH and a 
    Walk-tube to the SOUTH.
  DESC
  
  self.exit_north
  self.exit_south = :living_quarters
  
  # Logic
  
  item(:games_machine, 'video') do
    self.presence = "Video games machine"
    self.desc = "Insert DISC for PLAY"
    self.fixed = true
  end
  
  item(:joystick, 'joystick') do
  end
end