room(:surgery) do
  self.short_desc = "surgery"
  self.desc = <<-DESC
    I'm in the DOCTORS SURGERY. Exit is SOUTH
  DESC

  self.exit_south = :fcorridor2

  item(:thermometer, 'thermometer') do
    self.presence   = "thermometer"
    self.short_desc = "thermometer"
    self.desc = <<-DESC
      104 DEGREES! WOW! This adventure must have really FIRED
      YOUR IMAGINATION!
    DESC
  end
end
