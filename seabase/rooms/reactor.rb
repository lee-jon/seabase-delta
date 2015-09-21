room(:reactor) do
  self.short_desc = "reactor"
  self.desc = <<-DESC
    I'm in the REACTOR ROOM. The exit is WEST.
  DESC

  self.exit_west = :power_distribution

  item(:hammer, 'hammer') do
    self.presence = "Hammer"
    self.desc = "See what you can MAKE"
  end
end
