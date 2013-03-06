room(:fcorridor2) do
  self.short_desc = "fcorridor2"
  self.desc = <<-DESC
    As the corridor continues East/West, I begin to with I was still on the
    sub'. At least the gangwaus were straight!
    There are also compartments to the north and south.
  DESC
  
  self.exit_south = :
  self.exit_north = :surgery
  self.exit_east  = :fcorridor1
  self.exit_west  = :fcorridor3
  
  # Logic
  
  # Items
end