room(:lift2) do
  self.short_desc = "Lift 2"
  self.desc = <<-DESC
    Sea-Base Lift Number >2<. The EXIT is to the NORTH.
  DESC

  self.exit_north = :corridor2

  scenery(:floor_panel, 'panel') do
    self.desc     = "It can be OPENED but It's LOCKED!"
    self.presence = "Floor panel"
    self.openable = true

    self.script_open = <<-SCRIPT
      if get_room.find(:large_key)
        puts "I see something!!"

        self.presence = "Open Floor panel"
        self.openable = false

        get_root.move(:deep_liftshaft, :lift2)

        return false
      else
        puts "it can be OPENED but it's LOCKED"

        return false
      end
    SCRIPT

    scenery(:deep_liftshaft, 'shaft') do
      self.presence = 'Deep liftshaft'
      self.desc = "It's a long way down. There might be something down there but I can't see that far!"

      item(:small_metal_disc, 'disc') do
        self.presence   = "Small metal disc"
        self.short_desc = "Small metal disc"
        self.desc       = "One play"

        self.script_use = <<-SCRIPT
          if get_room.find(:games_machine)
            get_room.find(:games_machine).playing = true
            
            puts "It's one of those PLATFORM GAMES. A clown is jumping up and down on a Circus SEESAW...."
          end
        SCRIPT
      end
    end
  end

  scenery(:lift2_buttons, 'buttons') do
    self.presence = "Row of buttons"

    self.script_push = <<-SCRIPT
      puts "OK. Nothing Happened."
    SCRIPT
  end
end
