room(:computer_room) do
  self.desc = <<-DESC
    I am in the SEABASE MAIN COMPUTER ROOM. Corridors lead NORTH, SOUTH, & WEST.
  DESC

  self.exit_south = :tcorridor3

  self.script_enter = <<-SCRIPT
    if get_root.find(:tv_camera).covered == true
      return true
    else

      puts "Metallic voice:"
      puts 'SECURITY ALERT! ANTI-PERSONAL GUNS...AIM...FIRE! AAAGGGHHH!!!'
      puts ""
      puts "You run quickly back to the corridor!"
      puts "\n\n"

      return false
    end
  SCRIPT
end
