room(:shower_room) do
  self.desc = <<-DESC
    I am in the SHOWER-ROOM. The exits are NORTH and SOUTH.
  DESC

  self.exit_north = :library
  self.exit_south = :restroom

  self.script_enter = <<-SCRIPT
    puts "I can hear the faint sound of music." if get_root.find(:music_room).music_on

    return true
  SCRIPT

  scenery(:tap, 'tap') do
    self.presence = 'Tap'
    self.short_desc = 'Tap'
  end
end
