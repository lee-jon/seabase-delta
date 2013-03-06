room(:electronic_workshop) do
  self.exit_south = :corridor3
  self.desc = "This is the ELECTRIC WORKSHOP. The only exit is SOUTH from here."
  self.short_desc = "Workshop."

  item(:tape_player, 'player') do
    self.presence = "Tape player."
    self.short_desc = "Tape player."
    self.desc = <<-DESC
      Mitsu-tachi recorder - Insert cassette
    DESC
  end
end