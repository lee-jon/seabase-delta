room(:library) do
  self.short_desc = "library"
  self.desc = <<-DESC
    This is the LIBRARY. Exits lead WEST and SOUTH.
  DESC

  self.exit_south = :shower_room
  self.exit_west  = :music_room

  self.script_enter = <<-SCRIPT
    puts "MUSIC seems louder now\n" if get_root.find(:music_room).music_on

    return true
  SCRIPT

  item(:cookbook, "cookbook") do
    self.presence = "Cookbook"
    self.fixed    = true
    self.desc     = '"MAKING PANCAKES" by LEN SCOVER'
    self.read     = false

    self.script_examine = <<-SCRIPT
      self.desc
      self.read = true
    SCRIPT
  end
end
