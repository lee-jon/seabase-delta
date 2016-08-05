room(:computer_memory_banks) do
  self.short_desc = "Computer memory banks"
  self.desc = <<-DESC
    This is a small compartment containing the COMPUTER MEMORY BANKS. Exit is EAST.
  DESC

  self.exit_east = :computer_room

  item(:cassette, 'cassette') do
    self.presence   = "Cassette"
    self.short_desc = "Cassette"
    self.desc       = "HEAVY METAL MUSIC"

    self.script_use = <<-SCRIPT
      if get_room.find(:tape_player)
        get_root.move(:tape_player, :computer_memory_banks)
        get_root.move(:cassette, :void)

        item = get_root.find(:tape_player)

        item.playing = true
        item.presence << " (Playing HEAVY METAL music)"
        item.short_desc = item.presence
        item.desc = nil
        
        return false
      else
        return true
      end
    SCRIPT
  end
end
