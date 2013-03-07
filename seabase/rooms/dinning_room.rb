room(:dinning_room) do
  self.short_desc = "dinning_room"
  self.desc = <<-DESC
    The DINNING ROOM AREA. Walkways lead NORTH EAST and WEST.
  DESC
  
  self.exit_north = :fcorridor2
  self.exit_east  = :kitchen
  self.exit_west  = :laundry
  
  item(:flippers, 'flippers', 'sure-grip') do
    self.presence = "Pair of \"Sure Grip\" Flippers"
    self.desc = <<-DESC
    DESC
  end
  
  item(:fork, 'fork') do
    self.presence ="Fork"
    self.desc = "One of it's PRONGS is missing."
  end
end