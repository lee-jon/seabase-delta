room(:corridor3) do
  self.exit_west = :corridor2
  self.exit_east = :corridor4
  self.exit_north = :workshop

  self.desc = <<-DESC
    This CORRIDOR still stretches EAST/WEST. I get the strangest feeling
    - like I am walking around a huge WHITE MINT! There is also a
    compartment to the NORTH.
  DESC
  self.short_desc = "Corridor"
end