room(:laundry) do
  self.short_desc = "laundry"
  self.desc = <<-DESC
    I have wantered into the LAUNDRY AREA. There is an ICY COLD Tunnel WEST
    & Exit EAST.
  DESC
  
  self.exit_west = :deep_freeze
  self.exit_east = :dinning_room
  
  item(:steam_iron, 'iron') do
    self.presence = "Steam-Iron"
    self.desc = "Its ON and HOT!"
    self.short_desc = "Iron"
  end
  
  item(:washing_line, 'line') do
    self.presence = "Washing line"
    self.desc = "It's LONG....but not that STRONG.."
    self.short_desc = "Washing line"
  end
end