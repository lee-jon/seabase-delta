room(:tcorridor1) do
  self.short_desc = "tcorridor1"
  self.desc = <<-DESC
    The TWISTING WALKWAY meets a junctino of TUBES leading NORTH, SOUTH, EAST
    and WEST.
  DESC
  
  self.exit_north = :living_quarters
  self.exit_east  = :tcorridor2
  
  # Logic
  
  item(:microphone, 'microphone') do
    self.presence = "Microphone"
    self.fixed = true
  end
end