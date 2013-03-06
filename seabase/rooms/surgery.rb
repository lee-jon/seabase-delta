room(:surgery) do
  self.short_desc = "surgery"
  self.desc = <<-DESC
    I'm in the doctors surgery. Exit is South
  DESC
  
  self.exit_south = :fcorridor2
  
  item(:thermometer, 'thermometer') do
    self.presence   = "thermometer"
    self.short_desc = "thermometer"
    self.desc = <<-DESC
      104 degrees! Wow! This adventure must have really fired
      your imagination!
    DESC
  end
end