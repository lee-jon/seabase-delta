room(:station_beta) do
  self.exit_south = :corridor1
  self.destination = :station_charlie
  self.desc = <<-DESC
    I am on a platform at STATION "BETA". A connecting walk-tube
    leads off SOUTH.
  DESC
  item(:hatch, 'hatch') do
    self.openable = true
    self.script_enter = <<-SCRIPT
      puts "Bang! Hatch slams shut!"
      get_root.move(:player, :airlock)
      SCRIPT
  end
end