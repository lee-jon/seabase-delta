room(:missile_room) do
  self.exit_south = :station_echo

  self.desc = <<-DESC
      I am in the TIGER-FISH MISSILE ROOM. Exit is SOUTH.
  DESC

  item(:small_missile, 'missile', 'small') do
    self.fixed = true
    self.desc = <<-DESC
      Not to be confused with the HUGE NUCLEAR MISSILE you've got to stop!
      DESC
    self.presence = "Small Tiger-Fish missile"

    self.bearing_set = false
    self.bearing = "104"
    self.elevation = "199"

    self.script_set_bearing = <<-SCRIPT
      self.bearing_set = true

      get_root.find(:display_screen).desc = "ENTER ELEVATION FIGURES NOW:"

      puts "The screen reads:ENTRY ACCEPTED"
      puts "ENTER ELEVATION FIGURES NOW:"
    SCRIPT

    self.script_fire = <<-SCRIPT
      get_root.move(:small_missile, :void)
      get_root.find(:mast).presence = "Broken mast"
      get_root.find(:mast).desc = nil
      get_root.move(:wood, :deck_of_ship)

      puts "WHOOOOSH!! TIGER-FISH MISSILE IS FIRED AND HEADS OUT TOWARDS THE OLD WRECK..."
      puts "CRACK!... It hits the MAST of the WRECK!"
    SCRIPT
  end

  item(:display_screen, 'screen') do
    self.fixed = true

    self.desc = <<-DESC
      To aim missile enter 1. Degrees Bearing. 2. Elevation.
      Enter bearing figures now:
    DESC

    self.presence = "Display screen"
    self.read = ""
  end

  item(:keyboard, 'keyboard', 'small') do
    self.fixed = true
    self.presence = "Small keyboard"
  end
end
