room(:music_room) do
  self.short_desc = "music_room"
  self.desc = <<-DESC
    I've walked into the MUSIC ROOM. The exit is EAST
  DESC

  self.music_on  = false

  self.exit_east = :library

  self.script_enter = <<-SCRIPT
    if self.music_on
      puts "Oh what a din! Sounds like an old Rock & Roll song!-"
      puts "WITH A BARREL OF LAUGHS,"
      puts "AND WHAT THE SPIRITS ADVISE,"
      puts "WE'RE DOING HAMMER & NAILS,"
      puts "TO GET OUR BODIES TO RISE..."
    end

    return true
  SCRIPT

  item(:loudspeaker, 'loudspeaker') do
    self.fixed = true
    self.presence = "Loudspeaker"
    self.desc = "It has a loose magnet"

    item(:magnet, 'magnet') do
      self.presence = "Magnet"
      self.script_unscrew = <<-SCRIPT
        puts "Could help you get to the bottom of a problem..."
        get_root.move(:loudspeaker, :void)
        get_root.move(:magnet, :music_room, false)
      SCRIPT

      self.script_tie = <<-SCRIPT
        line = get_root.find(:washing_line)

        if get_room.find(:washing_line)
          get_root.move(:magnet, :void)
          get_root.move(:washing_line, :lift2)

          line.presence   << " (with magnet attached)"
          line.short_desc << " (with magnet attached)"
          line.with_magnet = true

          puts "OK"
        else
          puts "I don't know how to do that"
          return true
        end
      SCRIPT
    end
  end

  item(:hifi_unit, 'hifi', 'unit') do
    self.fixed = true
    self.presence = "Hifi unit"
  end
end
