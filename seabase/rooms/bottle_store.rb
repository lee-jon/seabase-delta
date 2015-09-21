room(:bottle_store) do
  self.short_desc = "bottle_store"
  self.desc = <<-DESC
    The Gas Bottle Store. The exit is south.
  DESC

  self.exit_south = :fcorridor1

  item(:air_bottle, 'bottle') do
    self.presence   = "Air bottle"
    self.short_desc = "Air bottle"
    self.desc = "There's a HOSE fitted"
  end
end
