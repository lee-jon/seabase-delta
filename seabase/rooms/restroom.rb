room(:restroom) do
  self.short_desc = "restroom"
  self.desc = <<-DESC
    I've entered a cosy looking RESTROOM.
    There's a damp tunnel to the NORTH and a
    Walk-tube to the SOUTH.
  DESC

  self.exit_north = :shower_room
  self.exit_south = :living_quarters

  item(:games_machine, 'machine') do
    self.presence = "Video games machine"
    self.desc     = "Insert DISC for PLAY"
    self.fixed    = true
    self.playing  = false
  end

  item(:joystick, 'joystick') do
    self.presence = 'Joystick'
    self.desc     = 'Try PUSHING & PULLING it...'
    self.fixed    = true

    self.script_push = <<-SCRIPT
      if get_root.find(:games_machine).playing
        puts "Clown flips up into the air! This is fun! But back to the quest..."
      end
    SCRIPT

    self.script_push = <<-SCRIPT
      if get_root.find(:games_machine).playing
        puts "Clown throws a black ball.."
      end
    SCRIPT
  end
end
