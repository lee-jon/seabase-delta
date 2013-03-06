room(:corridor2) do
  self.exit_west = :corridor1
  self.exit_east = :corridor3
  self.exit_south = :lift2
  self.desc = <<-DESC
    The CURVING EAST/WEST CORRIDOR continues here.
    There is a simly lit ALCOVE to the SOUTH.
  DESC
  item(:sign_missile, 'sign') do
    self.fixed = true
    self.desc = <<-DESC
      In case of ELEVATOR breakdown contact MISS. ISLES on "199"
    DESC
  end
end