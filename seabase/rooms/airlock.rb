room(:airlock) do
  self.desc = "I am in the AIRLOCK. There's a dull silence in this cramped dingy compartment."
  self.short_desc = "Airlock"

  self.empty = true

  item(:wheel, 'wheel') do
    self.presence = "Large wheel"
    self.fixed = true

    self.script_turn = <<-SCRIPT
      if get_room.empty
        if get_room.find(:connected_suit)
          get_room.empty = false

          puts "AIRLOCK fills with seawater"
          puts "Metallic voice says- 'Standby for EJECT'"
          puts "WHOOSHH!"
          puts ""

          get_root.move(:player, :murky_depths, false)

        else
          puts "AIRLOCK fills with seawater. CHOKE! GASP! NO AIR....I'M DROWING"
          puts "AAAARGH"
          puts ""
          puts "GAME OVER"
          get_root.move(:player, :void)
        end

      else
        get_room.empty = true

        puts "The room is emptying"

        get_root.move(:player, :station_beta)
      end
    SCRIPT
  end

  item(:sign, 'sign') do
    self.presence = "Sign"
    self.desc = "Automatic Air-Lock"
    self.fixed = true
  end
end
