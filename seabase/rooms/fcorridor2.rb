room(:fcorridor2) do
  self.short_desc = "fcorridor2"
  self.desc = <<-DESC
    As the CORRIDOR continues EAST/WEST, I begin to with I was still on the
    SUB'. At least the gangwaus were straight!
    There are also compartments to the north and south.
  DESC
  
  self.exit_south = :dinning_room
  self.exit_north = :surgery
  self.exit_east  = :fcorridor3
  self.exit_west  = :fcorridor1
  
  # Logic
  
  # Items
end