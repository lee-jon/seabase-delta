room(:launch_pad) do
  self.short_desc = "Huge launch pad"
  self.desc = <<-DESC
    I have reached the HUGE LAUNCH PAD. A metal path leads SOUTH
  DESC

  self.exit_south = :launch_control_area

  # Logic

  scenery(:platform, "platform") do
    self.presence = "Warhead platform"
    self.desc = <<-DESC
      Way up high....Can't reach!
    DESC
  end

  scenery(:nuclear_missle, "missile") do
    self.presence = "Huge nuclear missile"
    self.desc = <<-DESC
      It is controlled by a BEAM of LIGHT near that platform...
    DESC
  end
end
