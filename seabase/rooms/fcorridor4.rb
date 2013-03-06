room(:fcorridor4) do
  self.desc = <<-DESC
    The east/west curving corridor leads on with a very
    brightly lit Walk-way south.
  DESC
  
  self.exit_east  = :fcorridor2
  self.exit_west  = :fcorridor4
  self.exit_south = :head_office
end