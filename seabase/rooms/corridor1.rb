room(:corridor1) do
  self.exit_north = :station_beta
  self.exit_east  = :corridor2
  self.exit_west  = :corridor4
  self.exit_south = :diving_storeroom

  self.desc = <<-DESC
    I've entered a large CURVING CORRIDOR. It stretches out
    EAST/WEST & Walkways lead NORTH & SOUTH.
  DESC
  self.short_desc = "Corridor"
end