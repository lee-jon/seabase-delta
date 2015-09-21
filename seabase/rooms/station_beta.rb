room(:station_beta) do
  self.exit_south = :corridor1
  self.destination = :station_charlie
  self.desc = <<-DESC
    I am on a platform at STATION "BETA". A connecting walk-tube
    leads off SOUTH.
  DESC
  scenery(:hatch, 'hatch') do
    self.presence = "Closed hatch"
    #TODO hatch doesn't work as expected. Needs open and closed
    self.openable = true

    self.script_enter = <<-SCRIPT
      return false if !self.open

      puts ""
      puts "Bang! Hatch slams shut!"
      get_root.move(:player, :airlock)

      return false
    SCRIPT

    self.script_open = <<-SCRIPT
      self.presence = "Open hatch"
    SCRIPT
  end
end
