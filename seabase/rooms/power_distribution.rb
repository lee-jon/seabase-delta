room(:power_distribution) do
  self.short_desc = "power_distribution"
  self.desc = <<-DESC
    This is the POWER DISTRIBUTION ROOM. The exits are NORTH, SOUTH & EAST.
  DESC

  # Exits
  self.exit_east  = :reactor
  self.exit_south = :tcorridor4

  item(:power_distribution_switch, 'switch') do
    self.fixed = true
    self.presence = "Switch"

    self.script_push = <<-SCRIPT
      get_root.find(:music_room).music_on = true
      puts "I can hear the faint sound of MUSIC"
    SCRIPT
  end
end
