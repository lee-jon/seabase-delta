room(:station_delta) do
  self.exit_north = :observation_dome
  self.destination = :station_echo
  self.desc = <<-DESC
    I am on a platform at STATION DELTA. The platform
    opens out to the NORTH.
  DESC
  self.short_desc = "Station Delta"
end
room(:observation_dome) do
  self.exit_south = :station_delta
  self.desc = <<-DESC
    This is the OBSERVATION DOME. The exit is to the SOUTH.
    DESC
  self.short_desc = "Observation dome."
  item(:huge_window, 'window') do
    self.fixed = true
    self.desc = <<-DESC
      The murky sea stretches out before me. In on direction I see a
      SMALL MISSILE BAY and in the other- some sort of POLE sticking
      out of some WRECKAGE.
      DESC
    self.presence = "Huge viewing window"
  end
end