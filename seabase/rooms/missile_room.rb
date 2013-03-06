room(:missile_room) do
  self.exit_south = :station_echo
  self.desc = <<-DESC
      I am in the TIGER-FISH MISSILE ROOM. Exit is SOUTH.
  DESC
  item(:small_missile, 'missile', 'small') do
    self.fixed = true
    self.desc = <<-DESC
      Not to be confused with the HUGE NUCLEAR MISSILE you've got to stop!
      DESC
    self.presence = "Small Tiger-Fish missile"
  end
  item(:display_screen, 'screen') do
    self.fixed = true
    self.desc = <<-DESC
      To aim missile enter 1. Degrees Bearing. 2. Elevation.
      Enter bearing figures now:
    DESC
    self.presence = "Display screen"
    self.read = ""
  end
  item(:keyboard, 'keyboard', 'small') do
    self.fixed = true
    self.presence = "Small keyboard"
  end
end