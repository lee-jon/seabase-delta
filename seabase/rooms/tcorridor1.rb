room(:tcorridor1) do
  self.short_desc = "Corridor"
  self.desc = <<-DESC
    The TWISTING WALKWAY meets a junction of TUBES leading NORTH, SOUTH, EAST
    and WEST.
  DESC

  self.exit_north = :living_quarters
  self.exit_south = :shadowy_tunnel
  self.exit_east  = :tcorridor2
  self.exit_west  = :tcorridor4

  self.script_enter = <<-SCRIPT
    if get_root.find(:tape_player).playing && get_room.find(:microphone).unplayed
      puts "ZZZZZZZAANG!..The sound of metal sliding over metal and a DAZZLING BEAM of LIGHT from the SOUTH..\n\n"

      get_room.find(:microphone).unplayed = false
      doors = get_root.find(:sliding_doors)
      doors.unlocked = true
      doors.presence = "Huge OPEN metal sliding doors"
    end

    return true
  SCRIPT

  scenery(:microphone, 'microphone') do
    self.presence = "Microphone"
    self.unplayed = true
  end
end
