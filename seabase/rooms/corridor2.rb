room(:corridor2) do
  self.short_desc = "E/W Corridor."
  self.desc = <<-DESC
    The CURVING EAST/WEST CORRIDOR continues here.
    There is a simly lit ALCOVE to the SOUTH.
  DESC

  self.exit_west = :corridor1
  self.exit_east = :corridor3
  self.exit_south = :lift2


  item(:sign_missile, 'sign') do
    self.presence = "Sign"
    self.fixed = true
    self.desc = <<-DESC
      In case of ELEVATOR breakdown contact MISS. ISLES on "199"
    DESC
    self.script_read = <<-SCRIPT
      puts "In case of ELEVATOR breakdown contact MISS. ISLES on 199"
    SCRIPT
  end
end